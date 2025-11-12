local function load()
  vim.diagnostic.config({
    float = {
      border = 'rounded',
      format = function(diagnostic)
        return string.format('[%s] %s', diagnostic.source, diagnostic.message)
      end,
    },
    virtual_text = false,
    underline = false,
    update_in_insert = false,
    severity_sort = true,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = 'E',
        [vim.diagnostic.severity.WARN] = 'W',
        [vim.diagnostic.severity.INFO] = 'I',
        [vim.diagnostic.severity.HINT] = 'H',
      },
      linehl = {
        [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
      },
      numhl = {
        [vim.diagnostic.severity.WARN] = 'WarningMsg',
      },
    },
    jump = {
      float = true,
    },
  })

  vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open diagnostic float' })
  vim.keymap.set('n', '[d', function()
    vim.diagnostic.jump({
      count = -1,
    })
  end, { desc = 'Previous diagnostic' })
  vim.keymap.set('n', ']d', function()
    vim.diagnostic.jump({
      count = 1,
    })
  end, { desc = 'Next diagnostic' })
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist, { desc = 'Set diagnostics qf' })
end

local group = vim.api.nvim_create_augroup('my.diagnostic', {})

local cmd = {
  group = group,
  once = true,
  callback = load,
}

local events = { 'InsertEnter' }

vim.api.nvim_create_autocmd(events, cmd)
