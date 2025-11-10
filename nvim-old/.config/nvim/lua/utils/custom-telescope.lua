local M = {}

function M.custom(builtin, opts)
  local params = { builtin = builtin, opts = opts }
  return function()
    builtin = params.builtin
    opts = params.opts or {}
    local is_inside_work_tree = vim.fn.systemlist('git rev-parse --is-inside-work-tree')[1] == 'true'
    if builtin == 'files' then
      if is_inside_work_tree then
        opts.cwd = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
      end
      builtin = 'find_files'
    elseif builtin == 'grep' then
      if is_inside_work_tree then
        opts.cwd = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
        builtin = 'live_grep'
      else
        opts.search = vim.fn.input('Grep > ')
        builtin = 'grep_string'
      end
    elseif builtin == 'git_log' then
      if is_inside_work_tree then
        opts = {
          git_command = {
            'git',
            'log',
            '--all',
            '--date=short',
            '--pretty=oneline',
            '--format=%h %ad %cn %s %d',
          },
        }
      end
      builtin = 'git_commits'
    elseif builtin == 'string' then
      opts = require('telescope.themes').get_dropdown({
        winblend = 20,
        previewer = false,
      })
      builtin = 'current_buffer_fuzzy_find'
    end
    require('telescope.builtin')[builtin](opts)
  end
end

function M.extension(extension, method, opts)
  local params = { extension = extension, method = method, opts = opts }
  return function()
    extension = params.extension
    method = params.method
    opts = params.opts or {}
    if extension == 'repos' then
      extension = 'project'
      method = 'project'
      opts.display_type = 'full'
    end
    require('telescope').extensions[extension][method](opts)
  end
end

return M
