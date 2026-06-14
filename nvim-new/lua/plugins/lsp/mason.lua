local mason = require("mason")

-- import mason-lspconfig
local mason_lspconfig = require("mason-lspconfig")

local mason_tool_installer = require("mason-tool-installer")

-- enable mason and configure icons
mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

mason_lspconfig.setup({
	-- list of servers for mason to install
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
		"gopls",
	},
})

mason_tool_installer.setup({
	ensure_installed = {
		"prettierd",
		"stylua",
		-- JavaScript/TypeScript
		"eslint_d",
		-- Go (اختياري)
		"gofumpt",
		"goimports",

		-- Python
		"pyright",
		"ruff",
		"isort",
	},
})
