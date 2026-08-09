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

local search_cmd = ""
if vim.fn.executable("git") == 1 and vim.fn.isdirectory(".git") == 1 then
	search_cmd = "git ls-files --cached --others --exclude-standard"
elseif vim.fn.executable("fd") == 1 then
	search_cmd = "fd --type f --hidden --exclude .git"
elseif vim.fn.executable("fdfind") == 1 then
	search_cmd = "fdfind --type f --hidden --exclude .git"
end

if search_cmd ~= "" then
	_G.native_git_fd_find = function(cmdarg, _)
		local handle = io.popen(search_cmd)
		if not handle then
			return {}
		end

		local files = {}
		for line in handle:lines() do
			table.insert(files, line)
		end
		handle:close()

		if cmdarg == "" then
			return files
		end

		return vim.fn.matchfuzzy(files, cmdarg)
	end

	vim.opt.findfunc = "v:lua.native_git_fd_find"
end

vim.keymap.set("n", "<C-p>", ":find ", { silent = false })
