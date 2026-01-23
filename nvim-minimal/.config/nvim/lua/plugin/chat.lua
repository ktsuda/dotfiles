vim.pack.add({
  {
    src = 'https://github.com/CopilotC-Nvim/CopilotChat.nvim',
    name = 'copilotchat',
    data = {
      on_changed = function(event)
        local name, kind, path = event.data.spec.name, event.data.kind, event.data.path

        if name == 'copilotchat' and (kind == 'install' or kind == 'update') then
          vim.system({ 'make', 'tiktoken' }, { cwd = path })
        end
      end,
    },
  },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
})

vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('my.copilot', {}),
  callback = function(event)
    local spec = event.data.spec

    if spec.data and spec.data.on_changed then
      spec.data.on_changed(event)
    end
  end,
})

local prompt = require('utils.prompt')
local select = require('CopilotChat.select')

require('CopilotChat').setup({
  show_help = true,
  system_prompt = prompt.global_system,
  prompts = {
    Explain = {
      prompt = prompt.explain,
      mapping = '<leader>ae', -- [e]xplain
      description = 'Explain the code',
    },
    Review = {
      prompt = prompt.review,
      mapping = '<leader>ar', -- [r]eview
      description = 'Review the code',
    },
    Fix = {
      prompt = prompt.fix,
      mapping = '<leader>af', -- [f]ix
      description = 'Fix the code',
    },
    Optimize = {
      prompt = prompt.optimize,
      mapping = '<leader>ao', -- [o]ptimize
      description = 'Optimize the code',
    },
    Docs = {
      prompt = prompt.docs,
      mapping = '<leader>ad', -- [d]ocument
      description = 'Create the documents about the code',
    },
    Tests = {
      prompt = prompt.tests,
      mapping = '<leader>at', -- [t]est
      description = 'Write tests for the code',
    },
    FixDiagnostic = {
      prompt = prompt.fix_diagnostic,
      mapping = '<leader>au',
      description = 'Fix the code', -- [u]pdate
      selection = select.diagnostics,
    },
    Commit = {
      prompt = prompt.commit,
      mapping = '<leader>am', -- commit [m]essage
      description = 'Make the commit message',
      selection = select.gitdiff,
    },
    CommitStaged = {
      prompt = prompt.commit_staged,
      mapping = '<leader>as', -- message for [s]taged commit
      description = 'Make the commit message about the staged modification',
      selection = function(source)
        return select.gitdiff(source, true)
      end,
    },
    Translate = {
      prompt = prompt.translate,
      mapping = '<leader>al',
      description = 'Translate to English', -- trans[l]ate
      selection = select.selected_text,
    },
  },

  model = 'gpt-5-mini',
  temperature = 0.5,

  window = {
    layout = 'vertical',
    width = 0.5,
  },

  auto_insert_mode = true,
})
