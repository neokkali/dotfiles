return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		-- import nvim-treesitter plugin
		local treesitter = require("nvim-treesitter.configs")

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
			ensure_installed = {
				"json",
				"javascript",
				"typescript",
				"tsx",
				"yaml",
				"html",
				"css",
				"prisma",
				"markdown",
				"markdown_inline",
				"svelte",
				"graphql",
				"bash",
				"lua",
				"vim",
				"dockerfile",
				"gitignore",
				"query",
				"vimdoc",
				"c",
			},
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

		-- vim.keymap.set(
		-- 	"v",
		-- 	"<leader>z",
		-- 	":normal! za<CR>",
		-- 	{ desc = "Fold selected lines", noremap = true, silent = true }
		-- )
		-- vim.keymap.set("v", "<leader>z", "za", { desc = "Folding lines", noremap = true, silent = true })
	end,
}
