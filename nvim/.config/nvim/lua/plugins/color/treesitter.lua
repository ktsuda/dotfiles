local function load()
  vim.pack.add({
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'master' },
  })

  -- pcall(require('nvim-treesitter.install').update({ with_sync = true }))

  require('nvim-treesitter.configs').setup({
    ensure_installed = {
      'c',
      'cmake',
      'cpp',
      'diff',
      'dockerfile',
      -- 'go',
      'javascript',
      'json',
      -- 'latex',
      'lua',
      'make',
      'markdown',
      'python',
      -- 'ruby',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
    },
    sync_install = false,
    auto_install = true,
    ignore_install = {},
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    modules = {},
  })
end

local group = vim.api.nvim_create_augroup('my.treesitter', {})

local cmd = {
  group = group,
  once = true,
  callback = load,
}

local events = { 'BufReadPre', 'BufNewFile' }

vim.api.nvim_create_autocmd(events, cmd)
