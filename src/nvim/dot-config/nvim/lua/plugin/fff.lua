vim.pack.add({
  { src = "https://github.com/dmtrKovalenko/fff" },
})

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

require("fff").setup({
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
