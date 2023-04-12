return {
  {
    'ktsuda/vim-fugitive',
    branch = 'signoff',
    pin = true,
    cmd = { 'G', 'Git', 'Gdiff' },
    keys = {
      { '<leader>gs', '<cmd>G<cr>', desc = 'git status' },
      { '<leader>gd', '<cmd>Gdiff<cr>', desc = 'git diff' },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local cgs = {
          next_hunk = function()
            if vim.wo.diff then
              return ']c'
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return '<Ignore>'
          end,
          prev_hunk = function()
            if vim.wo.diff then
              return '[c'
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return '<Ignore>'
          end,
          blame_line = function()
            gs.blame_line({ full = true })
          end,
          diffthis = function()
            gs.diffthis('~')
          end,
        }
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end
        -- Navigation
        map('n', ']c', cgs.next_hunk, { expr = true })
        map('n', '[c', cgs.prev_hunk, { expr = true })
        -- Actions
        map({ 'n', 'v' }, '<leader>hs', gs.stage_hunk)
        map({ 'n', 'v' }, '<leader>hr', gs.reset_hunk)
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
