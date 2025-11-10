vim.pack.add({
  { src = 'https://github.com/lewis6991/gitsigns.nvim' },
})

local gs_status, gs = pcall(require, 'gitsigns')
if not gs_status then
  return
end

gs.setup({
  numhl = true,
  linehl = false,
  word_diff = true,
  current_line_blame = true,
  on_attach = function(bufnr)
    vim.keymap.set('n', ']c', function()
      if vim.wo.diff then
        return ']c'
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return '<Ignore>'
    end, { expr = true, desc = 'Gitsigns: Next hunk' })
    vim.keymap.set('n', '[c', function()
      if vim.wo.diff then
        return '[c'
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return '<Ignore>'
    end, { expr = true, desc = 'Gitsigns: Previous hunk' })
    vim.keymap.set('n', '<leader>hs', gs.stage_hunk, { desc = 'Gitsigns: Stage hunk' })
    vim.keymap.set('x', '<leader>hs', function()
      gs.stage_hunk({
        vim.fn.line('.'),
        vim.fn.line('v'),
      })
    end, { desc = 'Gitsigns: Stage hunk' })
    vim.keymap.set('n', '<leader>hr', gs.reset_hunk, { desc = 'Gitsigns: Reset hunk' })
    vim.keymap.set('x', '<leader>hr', function()
      gs.reset_hunk({
        vim.fn.line('.'),
        vim.fn.line('v'),
      })
    end, { desc = 'Gitsigns: Reset hunk' })
    vim.keymap.set('n', '<leader>hS', gs.stage_buffer, { desc = 'Gitsigns: Stage buffer' })
    vim.keymap.set('n', '<leader>hR', gs.reset_buffer, { desc = 'Gitsigns: Reset buffer' })
    vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { desc = 'Gitsigns: Preview hunk' })
    vim.keymap.set('n', '<leader>hb', function()
      gs.blame_line({ full = true })
    end, { desc = 'Gitsigns: Blame line' })
    vim.keymap.set('n', '<leader>hd', gs.diffthis, { desc = 'Gitsigns: Diff this' })
    vim.keymap.set('n', '<leader>hD', function()
      gs.diffthis('~')
    end, { desc = 'Gitsigns: Diff this' })
    vim.keymap.set('n', '<leader>hq', gs.setqflist, { desc = 'Gitsigns: Set quickfix list' })
    vim.keymap.set('n', '<leader>hQ', function()
      gs.setqfflist('all')
    end, { desc = 'Gitsigns: Set quickfix list' })
    vim.keymap.set({ 'o', 'x' }, 'ih', gs.select_hunk, { desc = 'Gitsigns: Select hunk' })
  end,
})
