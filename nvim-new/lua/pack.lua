vim.pack.add({
	--- telescope
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	-- { src =  "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },

	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-tree.lua" },
	{ src = "https://github.com/akinsho/bufferline.nvim" },
	{ src = "https://github.com/stevearc/dressing.nvim" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/projekt0n/github-nvim-theme" },

	--- auto seesion
	{ src = "https://github.com/rmagatti/auto-session" },
	{ src = "https://github.com/christoomey/vim-tmux-navigator" },

	--- treesitter
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" },
	{ src = "https://github.com/windwp/nvim-ts-autotag" },

	--- lsp
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
	{ src = "https://github.com/antosha417/nvim-lsp-file-operations" },
	{ src = "https://github.com/j-hui/fidget.nvim" },

	--- autocomplete
	{ src = "https://github.com/hrsh7th/nvim-cmp" },
	{ src = "https://github.com/hrsh7th/nvim-cmp" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
	{ src = "https://github.com/hrsh7th/cmp-buffer" },
	{ src = "https://github.com/hrsh7th/cmp-path" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/saadparwaiz1/cmp_luasnip" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },

	{ src = "https://github.com/kylechui/nvim-surround" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/mfussenegger/nvim-lint" },

	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/lukas-reineke/indent-blankline.nvim", main = "ibl" },
})

require("plugins.nvim-tree")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.lsp.mason")
require("plugins.lsp.lsp-config")
require("plugins.conform")
require("plugins.autopairs")
require("plugins.autocomplete")
require("plugins.nvim-lint")
require("plugins.lualine")
require("plugins.auto-session")

require("nvim-surround").setup()

require("which-key").setup()
require("fidget").setup()
require("dressing").setup()
require("bufferline").setup({
	options = {
		mode = "tabs",
	},
})
require("ibl").setup({
	indent = { char = "▏" },
})

-- اختصارات التنقل بين Neovim و Tmux
vim.keymap.set("n", "<c-h>", "<cmd>TmuxNavigateLeft<cr>", { silent = true })
vim.keymap.set("n", "<c-j>", "<cmd>TmuxNavigateDown<cr>", { silent = true })
vim.keymap.set("n", "<c-k>", "<cmd>TmuxNavigateUp<cr>", { silent = true })
vim.keymap.set("n", "<c-l>", "<cmd>TmuxNavigateRight<cr>", { silent = true })
vim.keymap.set("n", "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>", { silent = true })
