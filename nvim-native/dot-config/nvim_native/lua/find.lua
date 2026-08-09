local ignore_patterns = {
	"node_modules",
	"%.git",
	"%.cache",
	"dist",
	"build",
	"%.tmp",
	"%.log",
}

vim.o.wildmode = "noselect"

vim.api.nvim_create_autocmd("CmdlineChanged", {
	pattern = ":",
	callback = function()
		vim.fn.wildtrigger()
	end,
})

function _G.my_find(text, _)
	local files = vim.fn.glob("**/*", true, true)
	local result = {}
	for _, f in ipairs(files) do
		if vim.fn.isdirectory(f) == 0 then
			local skip = false
			for _, pat in ipairs(ignore_patterns) do
				if f:match(pat) then
					skip = true
					break
				end
			end
			if not skip then
				result[#result + 1] = f
			end
		end
	end
	return vim.fn.matchfuzzy(files, text)
end

vim.o.findfunc = "v:lua.my_find"

vim.keymap.set("n", "<C-p>", ":find ", { silent = false })
