local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local mason_tool_installer = require("mason-tool-installer")

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
	-- قائمة السيرفرات التي سيقوم ماسون بتثبيتها
	ensure_installed = {
		"ts_ls",
		"html",
		"cssls",
		"tailwindcss",
		"svelte",
		"lua_ls",
		"graphql",
		"emmet_language_server", -- توحيد الاسم هنا للاستقرار
		"prismals",
		"pyright",
		-- "eslint",
		"gopls",
	},
})

mason_tool_installer.setup({
	ensure_installed = {
		"prettierd",
		"stylua",
		"eslint_d",
		"gofumpt",
		"goimports",
		"emmet-language-server",
		"pyright",
		"ruff",
		"isort",
	},
})
