vim.pack.add({
  {
    src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    version = 'main',
    data = {
      on_changed = function(event)
        if event.data.kind == 'install' or event.data.kind == 'update' then
          pcall(require('nvim-treesitter').update())
        end
      end,
    },
  },
})

local group = vim.api.nvim_create_augroup('my.treesitter', { clear = true })

vim.api.nvim_create_autocmd('PackChanged', {
  group = group,
  callback = function(event)
    local spec = event.data.spec

    if spec.data and spec.data.on_changed then
      spec.data.on_changed(event)
    end
  end,
})
