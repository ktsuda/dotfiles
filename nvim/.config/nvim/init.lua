if vim.env.GIT_EXEC_PATH ~= nil and vim.env.GIT_EXEC_PATH ~= '' then
  return
end

require('packages')
require('config')
require('keybindings')
