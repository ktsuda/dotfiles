return {
  {
    'ktsuda/vim-fugitive',
    branch = 'signoff',
    pin = true,
    dependencies = {
      'tpope/vim-rhubarb',
    },
    cmd = { 'G', 'Git', 'Gdiff', 'GBrowse' },
    keys = {
      { '<leader>gs', '<cmd>G<cr>', desc = '[g]it [s]tatus' },
      { '<leader>gd', '<cmd>Gdiff<cr>', desc = '[g]it [d]iff' },
      { '<leader>br', '<cmd>GBrowse<cr>', desc = '[b]rowse [r]epo' },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local cgs = require('utils.git')
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end
        -- Navigation
        map('n', ']c', cgs.next_hunk, { expr = true })
        map('n', '[c', cgs.prev_hunk, { expr = true })
        -- Actions
        map('n', '<leader>hs', gs.stage_hunk)
        map('v', '<leader>hs', cgs.stage_hunk)
        map('n', '<leader>hr', gs.reset_hunk)
        map('v', '<leader>hr', cgs.reset_hunk)
        map('n', '<leader>hS', gs.stage_buffer)
        map('n', '<leader>hu', gs.undo_stage_hunk)
        map('n', '<leader>hR', gs.reset_buffer)
        map('n', '<leader>hp', gs.preview_hunk)
        map('n', '<leader>hb', cgs.blame_line)
        map('n', '<leader>tb', gs.toggle_current_line_blame)
        map('n', '<leader>hd', gs.diffthis)
        map('n', '<leader>hD', cgs.diffthis)
        map('n', '<leader>td', gs.toggle_deleted)
        -- Text object
        map({ 'o', 'x' }, 'ih', gs.select_hunk)
      end,
    },
  },
}
