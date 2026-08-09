vim.lsp.enable({ "lua_ls", "ts_ls", "clangd" })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client ~= nil and client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end

		vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover" })
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
		vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
	end,
})

vim.cmd("set completeopt+=noselect")
