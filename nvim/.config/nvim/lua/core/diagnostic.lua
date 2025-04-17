vim.diagnostic.config({
  float = {
    border = 'rounded',
    format = function(diagnostic)
      if diagnostic.code then
        return string.format('[%s: %s] %s', diagnostic.source, diagnostic.code, diagnostic.message)
      end

      return string.format('[%s] %s', diagnostic.source, diagnostic.message)
    end,
  },
  virtual_text = false,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = 'E',
      [vim.diagnostic.severity.WARN] = 'W',
      [vim.diagnostic.severity.INFO] = 'I',
      [vim.diagnostic.severity.HINT] = 'H',
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
    },
    numhl = {
      [vim.diagnostic.severity.WARN] = 'WarningMsg',
    }
  },
  jump = {
    float = true,
  },
})
