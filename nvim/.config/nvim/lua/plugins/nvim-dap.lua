return {
  {
    'mfussenegger/nvim-dap',
    enabled = true,
    lazy = true,
    cmd = { 'DapToggleBreakpoint', 'DapNew', 'DapContinue', 'DapStepOver', 'DapStepInto' },
    keys = {
      {
        '<leader>db',
        function()
          require('dap').toggle_breakpoint()
        end,
        desc = 'Toggle breakpoint',
      },
      {
        '<leader>dc',
        function()
          require('dap').continue()
        end,
        desc = 'Open dap UI',
      },
      {
        '<leader>di',
        function()
          require('dap').step_into()
        end,
        desc = 'Terminate',
      },
      {
        '<leader>do',
        function()
          require('dap').step_over()
        end,
        desc = 'Terminate',
      },
      {
        '<leader>dC',
        function()
          require('dap').run_to_cursor()
        end,
        desc = 'Run to cursor',
      },
      {
        '<leader>dT',
        function()
          require('dap').terminate()
        end,
        desc = 'Terminate',
      },
    },
    config = function()
      local dap = require('dap')
      local cdap = require('utils.custom-dap')

      for name, adapter in pairs(cdap.adapters or {}) do
        dap.adapters[name] = adapter
      end

      for lang, config in pairs(cdap.configurations or {}) do
        dap.configurations[lang] = config
      end
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    enabled = true,
    keys = {
      {
        '<leader>du',
        function()
          require('dapui').toggle()
        end,
        desc = 'Dap UI',
      },
    },
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
    },
    config = function()
      local dap, dapui = require('dap'), require('dapui')
      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
      dapui.setup()
    end,
  },
}
