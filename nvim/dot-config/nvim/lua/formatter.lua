local M = {}

M.formatters = {
  lua = "stylua --indent-type Spaces --indent-width 2 -",
  javascript = "prettierd --stdin-filepath %",
  typescript = "prettierd --stdin-filepath %",
  typescriptreact = "prettierd --stdin-filepath %",
  json = "prettierd --stdin-filepath %",
  markdown = "prettierd --stdin-filepath %",
}

local function format(args)
  local bufnr = args.buf
  local ft = vim.bo[bufnr].filetype
  local cmd = M.formatters[ft]

  if cmd then
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    local resolved = cmd:gsub("%%", bufname)
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local input = table.concat(lines, "\n")
    local output = vim.fn.system(resolved, input)

    if vim.v.shell_error == 0 then
      local formatted = vim.split(output, "\n", { plain = true })
      if formatted[#formatted] == "" then
        table.remove(formatted)
      end
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, formatted)
    end
  else
    for _, cl in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
      if cl:supports_method("textDocument/formatting") then
        vim.lsp.buf.format({ bufnr = bufnr, async = false })
        break
      end
    end
  end
end

vim.keymap.set("n", "<leader>f", function()
  local bufnr = vim.api.nvim_get_current_buf()
  format({ buf = bufnr })
end)

return M
