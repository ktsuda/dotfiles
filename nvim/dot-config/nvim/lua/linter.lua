local M = {}

M.linters = {
	markdown = { "markdownlint", "--json", "-s" },
}

local lint_ns = vim.api.nvim_create_namespace("my_linter")

local function lint(bufnr)
	local ft = vim.bo[bufnr].filetype
	local cmd = M.linters[ft]

	if not cmd then
		return
	end

	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local input = table.concat(lines, "\n")

	local result = vim.system(cmd, {
		stdin = input,
		text = true,
	}):wait()

	local output = result.stderr

	local ok, errors = pcall(vim.json.decode, output)

	if not ok or type(errors) ~= "table" then
		vim.diagnostic.set(lint_ns, bufnr, {})
		return
	end

	local diagnostics = {}

	for _, err in ipairs(errors) do
		local lnum = (err.lineNumber or 1) - 1
		local col = 0

		table.insert(diagnostics, {
			lnum = lnum,
			end_lnum = lnum,
			col = col,
			end_col = col,
			severity = vim.diagnostic.severity.WARN,
			message = string.format(
				"[%s] %s (%s)",
				table.concat(err.ruleNames, ", "),
				err.ruleDescription,
				err.errorDetail or ""
			),
			source = "markdownlint",
		})
	end

	vim.diagnostic.set(lint_ns, bufnr, diagnostics)
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function(args)
		lint(args.buf)
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	callback = function(args)
		lint(args.buf)
	end,
})

return M
