vim.pack.add({
  { src = 'https://github.com/vim-skk/skkeleton' },
  { src = 'https://github.com/vim-denops/denops.vim' },
})
vim.keymap.set({ 'i', 'c' }, '<C-j>', '<Plug>(skkeleton-toggle)', { noremap = false, desc = 'SKK: Toggle skk' })

vim.cmd([[
  call skkeleton#config({
    \   'eggLikeNewline': v:true,
    \   'globalDictionaries': ['~/.local/share/nvim/skk/SKK-JISYO.L', '~/.local/share/nvim/skk/SKK-JISYO.edict'],
    \ })
]])
