return {
  'nvim-treesitter/nvim-treesitter',
  enabled = true,
  event = { 'BufReadPre', 'BufNewFile' },
  build = function()
    pcall(require('nvim-treesitter.install').update({ with_sync = true }))
  end,
  config = function()
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
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    })
    -- vim.wo.foldmethod = 'expr'
    -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  end,
}
