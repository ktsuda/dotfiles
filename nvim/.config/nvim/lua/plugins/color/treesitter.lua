vim.pack.add({
  {
    src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    version = 'main',
    data = {
      on_changed = function(event)
        if event.data.kind == 'install' and event.data.kind == 'update' then
          pcall(require('nvim-treesitter').update())
        end
      end,
    },
  },
}, { load = false })

local group = vim.api.nvim_create_augroup('my.treesitter', { clear = true })

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(event)
    local spec = event.data.spec

    if spec.data and spec.data.on_changed then
      spec.data.on_changed(event)
    end
  end,
})

local pattern = {
  'lua',
  'c',
  'cpp',
  'markdown',
  'go',
  'python',
  'json',
}

vim.api.nvim_create_autocmd('FileType', {
  group = group,
  pattern = pattern,
  callback = function(event)
    local ts_status, ts = pcall(require, 'nvim-treesitter')
    if not ts_status then
      return
    end

    ts.setup({
      install_dir = vim.fs.joinpath(vim.fn.stdpath('data'), '/site'),
    })

    local lang = event.match
    -- local already_installed = vim.api.nvim_get_runtime_file(('parser/%s.so'):format(lang), true)
    local already_installed = ts.get_installed()
    -- if not next(already_installed) then
    if not vim.tbl_contains(already_installed, lang) then
      ts.install(lang, { force = false, summary = true })
    end

    local ok, _ = pcall(vim.treesitter.start, event.buf, lang)
    if not ok then
      return
    end
  end,
})

-- local cmd = {
--   group = group,
--   once = true,
--   callback = function()
--     vim.cmd([[:packadd 'nvim-treesitreesitter tter']])
--   end,
-- }
--
-- local events = { 'BufReadPre', 'BufNewFile' }
--
-- vim.api.nvim_create_autocmd(events, cmd)
