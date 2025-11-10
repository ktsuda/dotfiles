vim.pack.add({
  { src = 'https://github.com/nvim-telescope/telescope-live-grep-args.nvim', version = 'v1.1.0' },
})

local t_status, t = pcall(require, 'telescope')
if not t_status then
  return
end

local lga_status, lga = pcall(require, 'telescope-live-grep-args.actions')
if not lga_status then
  return
end

local lgs_status, lgs = pcall(require, 'telescope-live-grep-args.shortcuts')
if not lgs_status then
  return
end

t.setup({
  extensions = {
    live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
      -- define mappings, e.g.
      mappings = { -- extend mappings
        i = {
          ['<C-k>'] = lga.quote_prompt(),
          ['<C-i>'] = lga.quote_prompt({ postfix = ' --iglob ' }),
          -- freeze the current list and start a fuzzy search in the frozen list
          ['<C-r>'] = lga.to_fuzzy_refine,
        },
      },
    },
  },
})

pcall(t.load_extension, 'live_grep_args')

local opts = {
  search_dirs = {},
}
local is_inside_work_tree = vim.fn.systemlist('git rev-parse --is-inside-work-tree')[1] == 'true'
if is_inside_work_tree then
  table.insert(opts.search_dirs, vim.fn.systemlist('git rev-parse --show-toplevel')[1])
end

vim.keymap.set('n', '<leader>sa', function()
  t.extensions.live_grep_args.live_grep_args(opts)
end, { desc = 'Grep strings' })

vim.keymap.set('n', '<leader>sw', lgs.grep_word_under_cursor, { desc = 'Grep string under cursor' })
