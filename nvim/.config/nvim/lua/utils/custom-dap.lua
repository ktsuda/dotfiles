local M = {}

local mason = vim.fn.stdpath('data') .. '/mason/packages/codelldb/extension/'
local codelldb_path = mason .. 'adapter/codelldb'
local liblldb_path = mason .. 'lldb/lib/liblldb.so'

M.adapters = {
  codelldb = {
    type = 'server',
    port = '${port}',
    executable = {
      command = codelldb_path,
      args = { '--liblldb', liblldb_path, '--port', '${port}' },
    },
  },
}

M.configurations = {
  c = {
    {
      name = 'Build and debug active file',
      type = 'codelldb',
      request = 'launch',
      program = '${fileDirname}/${fileBasenameNoExtension}',
      cwd = '${fileDirname}',
      stopOnEntry = false,
    },
  },
  cpp = {
    {
      name = 'Build and debug active file',
      type = 'codelldb',
      request = 'launch',
      program = '${fileDirname}/${fileBasenameNoExtension}',
      cwd = '${fileDirname}',
      stopOnEntry = false,
    },
  },
}

return M
