return {
    'iamcco/markdown-preview.nvim',
    cond = function()
        return vim.fn.executable('npm') == 1
    end,
    build = 'cd app && npm install',
    ft = { 'markdown' },
    config = function()
        vim.g.mkdp_filetypes = { 'markdown' }
        vim.g.mkdp_auto_start = 0
        vim.g.mkdp_auto_close = 1
        vim.g.mkdp_refresh_slow = 0
        vim.keymap.set('n', '<leader>mp', vim.cmd.MarkdownPreview, {})
    end,
}
