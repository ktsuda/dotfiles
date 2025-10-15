return {
  settings = {
    python = {
      analysis = { typeCheckingMode = 'off' },
    },
  },
  single_file_support = false,
  cmd = { 'bash', '-c', 'source ./.venv/bin/activate && ./.venv/bin/pyright-langserver --stdio' },
}
