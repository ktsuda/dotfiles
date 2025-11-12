local function load()
  vim.pack.add({
    { src = 'https://github.com/akinsho/bufferline.nvim' },
    { src = 'https://github.com/kyazdani42/nvim-web-devicons' },
  })

  local bl_status, bl = pcall(require, 'bufferline')
  if not bl_status then
    return
  end

  bl.setup({
    options = {
      style_preset = {
        bl.style_preset.no_italic,
        bl.style_preset.no_bold,
      },
      diagnostics = 'nvim_lsp',
      diagnostics_update_on_event = true,
      color_icons = false,
      separator_style = { '', '' },
      offsets = {
        {
          filetype = 'neo-tree',
          text = 'File Explorer',
          highlight = 'Directory',
          text_align = 'left',
          separator = false,
        },
      },
    },
  })
end

local group = vim.api.nvim_create_augroup('my.bufferline', {})

local cmd = {
  group = group,
  once = true,
  callback = load,
}

local events = { 'BufReadPre', 'BufNewFile' }

vim.api.nvim_create_autocmd(events, cmd)
