local function load()
  vim.pack.add({
    { src = 'https://github.com/zbirenbaum/copilot.lua' },
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

  require('copilot').setup({
    suggestion = { enabled = false },
    panel = { enabled = false },
    filetypes = {
      lua = true,
      c = true,
      cpp = true,
      javascript = true,
      typescript = true,
      javascriptreact = true,
      typescriptreact = true,
      sh = true,
      zsh = true,
      python = true,
      ['*'] = false,
    },
  })

  local p = require('utils.prompt')
  local cc_select = require('CopilotChat.select')

  require('CopilotChat').setup({
    show_help = true,
    system_prompt = p.global_system,
    prompts = {
      Explain = {
        prompt = p.explain,
        mapping = '<leader>ae', -- [e]xplain
        description = 'Explain the code',
      },
      Review = {
        prompt = p.review,
        mapping = '<leader>ar', -- [r]eview
        description = 'Review the code',
      },
      Fix = {
        prompt = p.fix,
        mapping = '<leader>af', -- [f]ix
        description = 'Fix the code',
      },
      Optimize = {
        prompt = p.optimize,
        mapping = '<leader>ao', -- [o]ptimize
        description = 'Optimize the code',
      },
      Docs = {
        prompt = p.docs,
        mapping = '<leader>ad', -- [d]ocument
        description = 'Create the documents about the code',
      },
      Tests = {
        prompt = p.tests,
        mapping = '<leader>at', -- [t]est
        description = 'Write tests for the code',
      },
      FixDiagnostic = {
        prompt = p.fix_diagnostic,
        mapping = '<leader>au',
        description = 'Fix the code', -- [u]pdate
        selection = cc_select.diagnostics,
      },
      Commit = {
        prompt = p.commit,
        mapping = '<leader>am', -- commit [m]essage
        description = 'Make the commit message',
        selection = cc_select.gitdiff,
      },
      CommitStaged = {
        prompt = p.commit_staged,
        mapping = '<leader>as', -- message for [s]taged commit
        description = 'Make the commit message about the staged modification',
        selection = function(source)
          return cc_select.gitdiff(source, true)
        end,
      },
      Translate = {
        prompt = p.translate,
        mapping = '<leader>al',
        description = 'Translate to English', -- trans[l]ate
        selection = cc_select.selected_text,
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

  vim.keymap.set('n', '<leader>ac', '<cmd>CopilotChat<cr>', { desc = 'Chat with Copilot' })
  vim.opt.splitright = true
end

local group = vim.api.nvim_create_augroup('my.copilot', {})

vim.api.nvim_create_autocmd('PackChanged', {
  group = group,
  callback = function(event)
    local spec = event.data.spec

    if spec.data and spec.data.on_changed then
      spec.data.on_changed(event)
    end
  end,
})

vim.api.nvim_create_autocmd({ 'InsertEnter', 'CmdlineEnter' }, {
  group = group,
  once = true,
  callback = load,
})

vim.api.nvim_create_autocmd('BufEnter', {
  group = group,
  pattern = 'copilot-*',
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.opt_local.conceallevel = 0
  end,
})
