local M = {}

local gs = package.loaded.gitsigns

function M.next_hunk()
  if vim.wo.diff then
    return ']c'
  end
  vim.schedule(function()
    gs.next_hunk()
  end)
  return '<Ignore>'
end

function M.prev_hunk()
  if vim.wo.diff then
    return '[c'
  end
  vim.schedule(function()
    gs.prev_hunk()
  end)
  return '<Ignore>'
end

function M.stage_hunk()
  gs.stage_hunk({
    vim.fn.line('.'),
    vim.fn.line('v'),
  })
end

function M.reset_hunk()
  gs.reset_hunk({
    vim.fn.line('.'),
    vim.fn.line('v'),
  })
end

function M.blame_line()
  gs.blame_line({ full = true })
end

function M.diffthis()
  gs.diffthis('~')
end

return M

