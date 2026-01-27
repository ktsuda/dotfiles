require('nvim-treesitter').setup({
  install_dir = vim.fs.joinpath(vim.fn.stdpath('data'), '/site'),
})

vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

local pattern = {
  'c',
  'cpp',
  'javascript',
  'typescript',
  'tsx',
  'lua',
  'bash',
  'zsh',
  'make',
  'cmake',
  'dockerfile',
  'json',
  'yaml',
  'toml',
  'xml',
  'markdown',
  'vim',
  'vimdoc',
  'regex',
}

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('my.treesitter', { clear = true }),
  pattern = pattern,
  callback = function(event)
    local lang = event.match
    local already_intsalled = vim.api.nvim_get_runtime_file(('parser/%s.so'):format(lang), true)
    if not next(already_intsalled) then
      require('nvim-treesitter').install(lang, { force = false, summary = true })
    end

    local ok, _ = pcall(vim.treesitter.start, event.buf, lang)
    if not ok then
      return
    end

    vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo[0][0].foldmethod = 'expr'
  end,
})
