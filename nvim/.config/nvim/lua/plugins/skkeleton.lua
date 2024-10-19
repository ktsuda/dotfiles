return {
  'ktsuda/skkeleton',
  enabled = true,
  branch = 'revert-to-old-saver',
  keys = {
    { '<C-j>', '<Plug>(skkeleton-toggle)', mode = { 'i', 'c' }, desc = 'SKK' },
  },
  dependencies = {
    { 'vim-denops/denops.vim' },
  },
  config = function()
    vim.keymap.set({ 'i', 'c' }, '<C-j>', '<Plug>(skkeleton-toggle)', { noremap = false })
    vim.cmd([[
      call skkeleton#config({
        \   'eggLikeNewline': v:true,
        \   'globalDictionaries': ['~/.local/share/nvim/skk/SKK-JISYO.L', '~/.local/share/nvim/skk/SKK-JISYO.edict2'],
        \ })
    ]])
  end,
}
