return {
  'zbirenbaum/copilot.lua',
  enabled = true,
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = {
    panel = {
      enabled = false,
    },
    suggestion = {
      enabled = false,
    },
    copilot_node_command = 'node',
  },
}
