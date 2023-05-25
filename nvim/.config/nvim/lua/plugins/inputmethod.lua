return {
  'vim-skk/skkeleton',
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
        \   'globalJisyo': expand('~/.cache/skk/SKK-JISYO.L'),
        \ })
    ]])
  end,
}
