local M = {}

local lint_ns = vim.api.nvim_create_namespace("my_linter")

local markdown_config = vim.fs.joinpath(vim.fn.stdpath("data"), "markdownlint", "config.json")

M.linters = {
	markdown = { cmd = { "markdownlint", "--json", "-s", "-c", markdown_config }, output = "stderr" },
	javascript = { cmd = { "eslint_d", "--stdin", "--format", "json" }, output = "stdout" },
	typescript = { cmd = { "eslint_d", "--stdin", "--format", "json" }, output = "stdout" },
	javascriptreact = { cmd = { "eslint_d", "--stdin", "--format", "json" }, output = "stdout" },
	typescriptreact = { cmd = { "eslint_d", "--stdin", "--format", "json" }, output = "stdout" },
}

local function lint(bufnr)
	local ft = vim.bo[bufnr].filetype
	local config = M.linters[ft]

	if not config then
		return
	end

	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local input = table.concat(lines, "\n")

	local result = vim.system(config.cmd, {
		stdin = input,
		text = true,
	}):wait()

	local output

	if config.output == "stderr" then
		output = result.stderr
	else
		output = result.stdout
	end

	local ok, errors = pcall(vim.json.decode, output)

	if not ok or type(errors) ~= "table" then
		vim.diagnostic.set(lint_ns, bufnr, {})
		return
	end

	local diagnostics = {}

	if ft == "markdown" then
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
	elseif ft == "javascript" or ft == "typescript" or ft == "javascriptreact" or ft == "typescriptreact" then
		for _, file in ipairs(errors) do
			for _, err in ipairs(file.messages or {}) do
				local lnum = (err.line or 1) - 1
				local col = (err.column or 1) - 1
				local end_lnum = (err.endLine or err.line or 1) - 1
				local end_col = (err.endColumn or err.column or 1) - 1

				local severity = vim.diagnostic.severity.WARN

				if err.severity == 2 then
					severity = vim.diagnostic.severity.ERROR
				end

				table.insert(diagnostics, {
					lnum = lnum,
					end_lnum = end_lnum,
					col = col,
					end_col = end_col,
					severity = severity,
					message = string.format("[%s] %s", err.ruleId or "eslint", err.message or ""),
					source = "eslint_d",
				})
			end
		end
	end

	vim.diagnostic.set(lint_ns, bufnr, diagnostics)
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = vim.tbl_keys(M.linters),
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
