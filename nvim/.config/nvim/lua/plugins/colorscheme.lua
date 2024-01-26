return {
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    opts = {
      style = 'darker',
    },
    config = function(_, opts)
      local onedark_status, onedark = pcall(require, 'onedark')
      if not onedark_status then
        return
      end
      onedark.setup(opts)
      onedark.load()
    end,
  },
}
