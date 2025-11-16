local function load()
  vim.pack.add({
    { src = 'https://github.com/greggh/claude-code.nvim' },
    { src = 'https://github.com/nvim-lua/plenary.nvim' },
  })

  local c_status, c = pcall(require, 'claude-code')
  if not c_status then
    return
  end

  c.setup({
    window = {
      position = 'float',
      float = {
        width = '85%',
        height = '85%',
        row = 'center',
        col = 'center',
        relative = 'editor',
        border = 'rounded',
      },
    },
    git = {
      use_git_root = true,
    },
    command = 'claude',
    command_variants = {
      continue = '--continue',
      resume = '--resume',
      verbose = '--verbose',
    },
  })
end

vim.keymap.set('n', '<leader>ct', function()
  load()
  vim.cmd('ClaudeCode')
end, { desc = 'Claude Code Toggle' })

vim.keymap.set('n', '<leader>co', function()
  load()
  vim.cmd('ClaudeCodeOpen')
end, { desc = 'Claude Code Open' })

vim.keymap.set('n', '<leader>cx', function()
  load()
  vim.cmd('ClaudeCodeClode')
end, { desc = 'Claude Code Close' })
