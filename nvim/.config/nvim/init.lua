vim.loader.enable() -- cache

require('core.builtin')
require('core.options')
require('core.keymaps')
require('core.diagnostic')
require('core.mason')

require('plugins.cmp')
require('plugins.conform')
require('plugins.lspconfig')
require('plugins.lint')

require('plugins.operation')
require('plugins.edit')
-- require('plugins.claude')
require('plugins.color')
require('plugins.wakatime')
