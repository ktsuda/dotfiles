local status, configs = pcall(require, 'nvim-treesitter.configs')
if not status then return end
configs.setup({
  ensure_installed = {
    'c',
    'cpp',
    'lua',
    'help',
    'python',
    'cmake',
    'dockerfile',
    'go',
    'json',
    'latex',
    'make',
    'markdown',
    'ruby',
    'javascript',
    'typescript',
    'vim',
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})
