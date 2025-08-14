return {
  'lewis6991/gitsigns.nvim',
  enabled = true,
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    numhl = true,
    linehl = false,
    word_diff = true,
    current_line_blame = true,
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local cgs = require('utils.custom-gitsigns')
      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end
      -- Navigation
      map('n', ']c', cgs.next_hunk, { expr = true, desc = 'Gitsigns: Next hunk' })
      map('n', '[c', cgs.prev_hunk, { expr = true, desc = 'Gitsigns: Previous hunk' })
      -- Actions
      map('n', '<leader>hs', gs.stage_hunk, { desc = 'Gitsigns: Stage hunk' })
      map('v', '<leader>hs', cgs.stage_hunk, { desc = 'Gitsigns: Stage hunk' })
      map('n', '<leader>hr', gs.reset_hunk, { desc = 'Gitsigns: Reset hunk' })
      map('v', '<leader>hr', cgs.reset_hunk, { desc = 'Gitsigns: Reset hunk' })
      map('n', '<leader>hS', gs.stage_buffer, { desc = 'Gitsigns: Stage buffer' })
      map('n', '<leader>hR', gs.reset_buffer, { desc = 'Gitsigns: Reset buffer' })
      map('n', '<leader>hp', gs.preview_hunk, { desc = 'Gitsigns: Preview hunk' })
      map('n', '<leader>hb', cgs.blame_line, { desc = 'Gitsigns: Blame line' })
      map('n', '<leader>hd', gs.diffthis, { desc = 'Gitsigns: Diff this' })
      map('n', '<leader>hD', cgs.diffthis, { desc = 'Gitsigns: Diff this' })
      map('n', '<leader>hq', gs.setqflist, { desc = 'Gitsigns: Set quickfix list' })
      map('n', '<leader>hQ', cgs.setqflist, { desc = 'Gitsigns: Set quickfix list' })
      -- Text object
      map({ 'o', 'x' }, 'ih', gs.select_hunk, { desc = 'Gitsigns: Select hunk' })
    end,
  },
}

