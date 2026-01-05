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

  local cc_select = require('CopilotChat.select')

  require('CopilotChat').setup({
    show_help = true,
    prompts = {
      Explain = {
        prompt = '/COPILOT_EXPLAIN コードを日本語で説明してください',
        mapping = '<leader>ae',
        description = 'コードの説明をお願いする',
      },
      Review = {
        prompt = '/COPILOT_REVIEW コードを日本語でレビューしてください。',
        mapping = '<leader>ar',
        description = 'コードのレビューをお願いする',
      },
      Fix = {
        prompt = '/COPILOT_FIX このコードには問題があります。バグを修正したコードを表示してください。説明は日本語で、コード内のコメントは英語でお願いします。',
        mapping = '<leader>af',
        description = 'コードの修正をお願いする',
      },
      Optimize = {
        prompt = '/COPILOT_REFACTOR 選択したコードを最適化し、パフォーマンスと可読性を向上させてください。説明は日本語で、コード内のコメントは英語でお願いします。',
        mapping = '<leader>ao',
        description = 'コードの最適化をお願いする',
      },
      Docs = {
        prompt = '/COPILOT_GENERATE 選択したコードに関するドキュメントコメントを英語で生成してください。',
        mapping = '<leader>ad',
        description = 'コードのドキュメント作成をお願いする',
      },
      Tests = {
        prompt = '/COPILOT_TESTS 選択したコードの詳細なユニットテストを書いてください。説明は日本語で、コード内のコメントは英語でお願いします。',
        mapping = '<leader>at',
        description = 'テストコード作成をお願いする',
      },
      FixDiagnostic = {
        prompt = 'コードの診断結果に従って問題を修正してください。修正内容の説明は日本語で、コード内のコメントは英語でお願いします。',
        mapping = '<leader>au',
        description = 'コードの修正をお願いする',
        selection = cc_select.diagnostics,
      },
      Commit = {
        prompt = '実装差分に対するコミットメッセージを英語で記述してください。',
        mapping = '<leader>ac',
        description = 'コミットメッセージの作成をお願いする',
        selection = cc_select.gitdiff,
      },
      CommitStaged = {
        prompt = 'ステージ済みの変更に対するコミットメッセージを英語で記述してください。',
        mapping = '<leader>as',
        description = 'ステージ済みのコミットメッセージの作成をお願いする',
        selection = function(source)
          return cc_select.gitdiff(source, true)
        end,
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
