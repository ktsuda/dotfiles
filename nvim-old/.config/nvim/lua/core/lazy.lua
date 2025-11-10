local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins', {
  -- ui = { border = 'prounded' },
  concurrency = 8,
  change_detectioin = {
    notify = false,
  },
})

vim.keymap.set('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'Lazy: Open window' })
