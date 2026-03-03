vim.keymap.set({ 'i', 'c' }, '<C-j>', '<Plug>(skkeleton-toggle)', { noremap = false, desc = 'Toggle skk' })

vim.cmd([[
  call skkeleton#config({
    \   'eggLikeNewline': v:true,
    \   'globalDictionaries': [
    \       '~/.local/share/nvim/skk/SKK-JISYO.L',
    \       '~/.local/share/nvim/skk/SKK-JISYO.edict'
    \   ],
    \ })
]])
