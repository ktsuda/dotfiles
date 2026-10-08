local M = {}

-- `vim.fn.termopen()` is deprecated since nvim 0.11. Keep the shim so the
-- config still loads on 0.10, where `term = true` would be silently ignored
-- and the job would start without a pty (blank window, hard to diagnose).
local function start_term(cmd, opts)
  if vim.fn.has("nvim-0.11") == 1 then
    return vim.fn.jobstart(cmd, vim.tbl_extend("force", opts or {}, { term = true }))
  end
  return vim.fn.termopen(cmd, opts)
end

local function missing_executables(list)
  local missing = {}
  for _, exe in ipairs(list or {}) do
    if vim.fn.executable(exe) == 0 then
      table.insert(missing, exe)
    end
  end
  return missing
end

--- Strip SGR sequences. Needed because `rg --color=always` embeds them and we
--- cannot fully rely on fzf stripping them from what it writes to stdout.
function M.strip_ansi(s)
  return (s:gsub("\27%[[%d;]*m", ""))
end

--- opts.required  : string[]  executables that must exist
--- opts.title     : string
--- opts.cmd       : fun(outfile: string): string   -- sh script; must redirect the
---                  selection to `outfile` itself (multi-line scripts are fine)
--- opts.temps     : string[]  extra temp files to unlink on teardown
--- opts.on_select : fun(lines: string[])           -- called after the float closes
function M.run(opts)
  local missing = missing_executables(opts.required)
  if #missing > 0 then
    vim.notify("fzf_float: missing executable(s): " .. table.concat(missing, ", "), vim.log.levels.ERROR)
    return
  end

  -- `columns`/`lines` remain correct with zero or multiple attached UIs,
  -- unlike nvim_list_uis()[1].
  local total_w, total_h = vim.o.columns, vim.o.lines
  local width = math.floor(total_w * 0.9)
  local height = math.floor(total_h * 0.8)

  local bufnr = vim.api.nvim_create_buf(false, true)
  local win_id = vim.api.nvim_open_win(bufnr, true, {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((total_h - height) / 2),
    col = math.floor((total_w - width) / 2),
    border = "single",
    title = opts.title or " fzf ",
    title_pos = "center",
  })

  local outfile = vim.fn.tempname()
  local temps = { outfile }
  vim.list_extend(temps, opts.temps or {})

  local function cleanup()
    if vim.api.nvim_win_is_valid(win_id) then
      vim.api.nvim_win_close(win_id, true)
    end
    if vim.api.nvim_buf_is_valid(bufnr) then
      vim.api.nvim_buf_delete(bufnr, { force = true })
    end
    for _, path in ipairs(temps) do
      os.remove(path)
    end
  end

  -- Pass argv directly instead of a shell string: nvim then does not re-parse
  -- the script through 'shell', so the quoting inside it is ours alone.
  local job = start_term({ "sh", "-c", opts.cmd(outfile) }, {
    on_exit = function(_, code)
      -- Deferred: deleting the terminal buffer from inside its own exit
      -- callback races with nvim's channel teardown.
      vim.schedule(function()
        local lines = {}
        if code == 0 then
          local f = io.open(outfile, "r")
          if f then
            for line in f:lines() do
              if line ~= "" then
                table.insert(lines, line)
              end
            end
            f:close()
          end
        end
        cleanup()
        if #lines > 0 and opts.on_select then
          opts.on_select(lines)
        end
      end)
    end,
  })

  -- jobstart() returns 0 (bad args) or -1 (not executable); without this the
  -- float and the temp files leak silently.
  if job <= 0 then
    cleanup()
    vim.notify("fzf_float: failed to start job", vim.log.levels.ERROR)
    return
  end

  vim.cmd.startinsert()
end

return M
