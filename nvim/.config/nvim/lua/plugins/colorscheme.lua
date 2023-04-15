return {
    {
        'xiyaowong/transparent.nvim',
        opts = function(_, opts)
          return vim.tbl_extend('force', {
            extra_groups = {
              'NormalFloat',
            },
          }, opts or {})
        end,
    },
    {
        'ellisonleao/gruvbox.nvim',
        config = function()
            vim.cmd.colorscheme('gruvbox')
        end,
    },
}
