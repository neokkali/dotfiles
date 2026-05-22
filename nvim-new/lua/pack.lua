-- lua/pack.lua
vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/akinsho/bufferline.nvim" },
	{ src = "https://github.com/folke/snacks.nvim" },

	-- Telescope
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },

	-- Themes
	{ src = "https://github.com/catppuccin/nvim" },
	{ src = "https://github.com/navarasu/onedark.nvim" },

	-- LSP Base
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },

	-- Autocompletion Engine & Sources
	{ src = "https://github.com/saghen/blink.lib" },
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	-- Autopairs
	{ src = "https://github.com/windwp/nvim-autopairs" },

	-- Formatter
	{ src = "https://github.com/stevearc/conform.nvim" },

	-- Treesitter
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

require("nvim-autopairs").setup()

---- Theme ----
require("onedark").setup({
	options = {
		transparency = true,
	},
})

---- Treesitter ----
require("nvim-treesitter").install({
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
	"zsh",
	"lua",
	"vim",
	"dockerfile",
	"gitignore",
	"query",
	"vimdoc",
	"c",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"lua",
		"javascript",
		"typescript",
		"typescriptreact",
		"javascriptreact",
		"tsx",
		"html",
		"css",
		"scss",
		"json",
		"yaml",
		"markdown",
		"python",
		"rust",
		"svelte",
		"graphql",
		"prisma",
		"bash",
		"zsh",
	},
	callback = function()
		-- syntax highlighting, provided by Neovim
		vim.treesitter.start()
		-- folds, provided by Neovim
		vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.wo.foldmethod = "expr"
		-- indentation, provided by nvim-treesitter
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99
	end,
})

---- LSP ---
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"ts_ls",
		"html",
		"cssls",
		"tailwindcss",
		"svelte",
		"lua_ls",
		"graphql",
		"emmet_ls",
		"prismals",
		"pyright",
		"eslint",
	},
})
require("mason-tool-installer").setup({
	ensure_installed = {
		"lua-language-server",
		"stylua",
		"prettierd",
		"isort",
		"black",
		"ruff",
		"eslint-lsp",
	},
})

vim.lsp.enable({
	"lua_ls",
	"ts_ls",
	"html",
	"cssls",
	"tailwindcss",
	"svelte",
	"graphql",
	"emmet_ls",
	"prismals",
	"pyright",
	"eslint",
})
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim", "requires" },
			},
		},
	},
})

require("conform").setup({
	formatters_by_ft = {
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		svelte = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		graphql = { "prettier" },
		liquid = { "prettier" },
		lua = { "stylua" },
		python = { "isort", "black" },
	},
	format_on_save = {
		lsp_fallback = true,
		async = false,
		timeout_ms = 1000,
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

require("luasnip.loaders.from_vscode").lazy_load()

require("blink.cmp").setup({
	fuzzy = {
		implementation = "prefer_rust",
	},

	signature = {
		enabled = true,
	},

	completion = {
		menu = {
			auto_show = true,
		},

		accept = {
			auto_brackets = {
				enabled = true,
			},
		},
	},

	keymap = {
		preset = "default",
		["<CR>"] = { "accept", "fallback" },
		["<Tab>"] = { "select_next", "fallback" },
		["<S-Tab>"] = { "select_prev", "fallback" },
	},
})

require("bufferline").setup({
	options = { mode = "tabs" },
})

require("which-key").setup()

-- require("snacks").setup()

local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		file_ignore_patterns = {
			"node_modules",
			".git/",
			"venv",
			"__pycache__",
			".next",
			"dist",
			"build",
		},
		path_display = { "smart" },
		preview = { treesitter = false },
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-q>"] = function(bufnr)
					actions.send_to_qflist(bufnr)
					vim.cmd("copen")
				end,
				["<Esc>"] = actions.close,
			},
		},
	},
})

vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>fr", builtin.oldfiles)
vim.keymap.set("n", "<leader>fs", builtin.live_grep)
vim.keymap.set("n", "<leader>fc", builtin.grep_string)
vim.keymap.set("n", "<leader>fh", builtin.help_tags)
vim.keymap.set("n", "<leader>ee", function()
	Snacks.explorer()
end)
vim.keymap.set("n", "<leader>ef", function()
	Snacks.explorer({ file = vim.api.nvim_buf_get_name(0) })
end)
