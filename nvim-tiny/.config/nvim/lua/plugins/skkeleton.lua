return {
  'vim-skk/skkeleton',
  enabled = true,
  event = { 'InsertEnter', 'CmdlineEnter' },
  keys = {
    { '<C-j>', '<Plug>(skkeleton-toggle)', mode = { 'i', 'c' }, desc = 'SKK: Toggle skk' },
  },
  dependencies = {
    'vim-denops/denops.vim',
  },
  config = function()
    vim.keymap.set({ 'i', 'c' }, '<C-j>', '<Plug>(skkeleton-toggle)', { noremap = false, desc = 'SKK: Toggle skk' })
    vim.cmd([[
      call skkeleton#config({
        \   'eggLikeNewline': v:true,
        \   'globalDictionaries': ['~/.local/share/nvim/skk/SKK-JISYO.L', '~/.local/share/nvim/skk/SKK-JISYO.edict2'],
        \ })
    ]])
  end,
}
