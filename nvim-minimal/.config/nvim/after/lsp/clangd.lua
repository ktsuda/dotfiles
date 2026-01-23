return {
  cmd = {
    -- see clangd --help-hidden
    'clangd',
    '--background-index',
    -- by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
    -- to add more checks, create .clang-tidy file in the root directory
    -- and add Checks key, see https://clang.llvm.org/extra/clang-tidy/
    '--clang-tidy',
    '--completion-style=bundled',
    '--header-insertion=iwyu',
  },
  filetypes = { 'c', 'cpp' },
  root_markers = { '.git' },
  init_options = {
    clangdFileStatus = true, -- Provides information about activity on clangd’s per-file worker thread
    usePlaceholders = true,
    completeUnimported = true,
    semanticHighlighting = true,
  },
  InlayHints = {
    Designators = true,
    Enabled = true,
    ParameterNames = true,
    DeducedTypes = true,
  },
  fallbackFlags = { '-std=c++20' },
}
