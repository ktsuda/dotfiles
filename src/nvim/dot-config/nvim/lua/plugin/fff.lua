vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "fff" and (kind == "install" or kind == "update") then
      if not ev.data.active then
        vim.cmd.packadd("fff")
      end
      require("fff.download").download_or_build_binary()
    end
  end,
})

vim.pack.add({
  { src = "https://github.com/dmtrKovalenko/fff" },
})

local f = require("fff")
f.setup({
  prompt = ": ",
  title = "fff",
  lazy_sync = true,
  layout = {
    prompt_position = "top",
  },
  keymaps = {
    move_up = "<C-p>",
    move_down = "<C-n>",
    send_to_quickfix = "<C-q>",
  },
  grep = {
    modes = { "plain", "fuzzy", "regex", "definition_only" },
  },
  debug = {
    enabled = false,
    show_scores = true,
  },
})

vim.keymap.set("n", "<C-p>", f.find_files)
vim.keymap.set("n", "<leader>sa", f.live_grep)
vim.keymap.set({ "n", "x" }, "<leader>sw", f.live_grep_under_cursor)
vim.keymap.set("n", "<leader>ff", function()
  local dir = vim.fn.expand("%:p:h")
  f.find_files_in_dir(dir)
end)
