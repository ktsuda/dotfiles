return {
  'github/copilot.vim',
  enabled = true,
  envent = 'InsertEnter',
  config = function()
    vim.keymap.set(
      'i',
      '<C-l>',
      'copilot#Accept("<CR>")',
      { silent = true, expr = true, script = true, replace_keycodes = false, desc = 'Copilot: Accept the current suggestion' }
    )
    vim.keymap.set('i', '<C-j>', '<Plug>(copilot-next)', { desc = 'Copilot: Move to the next suggestion' })
    vim.keymap.set('i', '<C-k>', '<Plug>(copilot-previous)', { desc = 'Copilot: Move to the previous suggestion' })
    vim.keymap.set('i', '<C-o>', '<Plug>(copilot-dismiss)', { desc = 'Copilot: Dismiss the current suggestion' })
    vim.keymap.set('i', '<C-s>', '<Plug>(copilot-suggest)', { desc = 'Copilot: Suggest a new completion' })
    vim.g.copilot_no_tab_map = true
  end,
}
