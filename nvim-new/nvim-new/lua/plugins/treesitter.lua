local treesitter = require("nvim-treesitter")

-- import nvim-ts-autotag plugin
local nvim_ts_autotag = require("nvim-ts-autotag")

-- configure treesitter
treesitter.setup({ -- enable syntax highlighting
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	-- enable indentation
	indent = { enable = true },
	-- enable autotagging (w/ nvim-ts-autotag plugin)
	-- Removed from new update
	-- autotag = {
	-- 	enable = true,
	-- },
	-- ensure these language parsers are installed
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-space>",
			node_incremental = "<C-space>",
			scope_incremental = false,
			node_decremental = "<bs>",
		},
	},
})

local ensure_installed = {
	"json",
	"javascript",
	"typescript",
	"tsx",
	"go",
	"yaml",
	"html",
	"css",
	"prisma",
	"svelte",
	"graphql",
	"bash",
	"dockerfile",
	"gitignore",
}

treesitter.install(ensure_installed)

nvim_ts_autotag.setup({
	opts = {
		enable_close = true,
		enable_rename = true,
		enable_close_on_slash = true,
	},
})

-- vim.o.foldmethod = "manual"
-- vim.o.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.o.foldlevel = 99

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function(args)
		local buf = args.buf
		local ft = vim.bo[buf].filetype

		local lang = vim.treesitter.language.get_lang(ft)
		if not lang then
			return
		end

		local ok_add = pcall(vim.treesitter.language.add, lang)
		if not ok_add then
			return
		end

		pcall(vim.treesitter.start, buf, lang)
		vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

vim.keymap.set("v", "<leader>z", ":normal! za<CR>", { desc = "Fold selected lines", noremap = true, silent = true })
vim.keymap.set("v", "<leader>z", "za", { desc = "Folding lines", noremap = true, silent = true })
