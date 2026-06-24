local lspconfig = require("lspconfig")

-- import mason_lspconfig plugin
local mason_lspconfig = require("mason-lspconfig")

-- import cmp-nvim-lsp plugin
local cmp_nvim_lsp = require("cmp_nvim_lsp")

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf, silent = true }

		-- set keybinds
		opts.desc = "Show LSP references"
		vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

		opts.desc = "Go to declaration"
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

		opts.desc = "Show LSP definitions"
		vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

		opts.desc = "Show LSP implementations"
		vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

		opts.desc = "Show LSP type definitions"
		vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

		opts.desc = "See available code actions"
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

		opts.desc = "Smart rename"
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

		opts.desc = "Show buffer diagnostics"
		vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

		opts.desc = "Show line diagnostics"
		vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

		opts.desc = "Go to previous diagnostic"
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

		opts.desc = "Go to next diagnostic"
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

		opts.desc = "Show documentation for what is under cursor"
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

		opts.desc = "Restart LSP"
		vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
	end,
})

local capabilities = cmp_nvim_lsp.default_capabilities()

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "󰠠",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
	virtual_text = false, -- تعطيل النصوص الافتراضية بجانب السطر
	signs = false, -- تعطيل العلامات الجانبية
	underline = true, -- إبقاء التسطير (اختياري)
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "always",
	},
})

mason_lspconfig.setup({
	handlers = { -- mason_lspconfig.setup_handlers doesn't exist but mason_lspconfig.setup({handlers = {}}) exists
		-- default handler for installed servers
		function(server_name)
			lspconfig[server_name].setup({
				capabilities = capabilities,
			})
		end,

		["eslint"] = function()
			lspconfig["eslint"].setup({
				capabilities = capabilities,
				settings = {
					-- إعدادات متوافقة مع ESLint v9 الحديث
					workingDirectory = { mode = "auto" },
					codeAction = {
						disableRuleComment = { enable = true, location = "separateLine" },
						showDocumentation = { enable = true },
					},
					format = { enable = true },
				},
				on_attach = function(client, bufnr)
					-- إنشاء مجموعة تنظيف لمنع تكرار الـ autocmd عند إعادة فتح الملفات
					local eslint_group = vim.api.nvim_create_augroup("EslintFormat", { clear = false })
					vim.api.nvim_clear_autocmds({ group = eslint_group, buffer = bufnr })

					-- تصحيح تلقائي عند الحفظ بشكل آمن ومستقر
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = eslint_group,
						buffer = bufnr,
						-- WARN: Maybe here will cause problem
						-- command = "EslintFixAll",
						command = "LspEslintFixAll",

						desc = "Fix all ESLint errors before saving",
					})
				end,
			})
		end,
		["gopls"] = function()
			lspconfig.gopls.setup({
				capabilities = capabilities,
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
							nilness = true,
							unusedwrite = true,
							useany = true,
						},
						staticcheck = true,
						gofumpt = true,
						completeUnimported = true,
						usePlaceholders = true,
					},
				},
			})
		end,
		["pyright"] = function()
			lspconfig.pyright.setup({
				capabilities = capabilities,
				settings = {
					python = {
						analysis = {
							-- maxLineLength = 120,
							typeCheckingMode = "basic",
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
						},
					},
				},
			})
		end,
		["svelte"] = function()
			-- configure svelte server
			lspconfig["svelte"].setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePost", {
						pattern = { "*.js", "*.ts" },
						callback = function(ctx)
							-- Here use ctx.match instead of ctx.file
							client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
						end,
					})
				end,
			})
		end,
		["graphql"] = function()
			-- configure graphql language server
			lspconfig["graphql"].setup({
				capabilities = capabilities,
				filetypes = { "graphql", "gql" },
				-- INFO: Return this if you want write gql inside the tsx or jsx files
				-- filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
			})
		end,
		["emmet_language_server"] = function()
			-- configure the new emmet language server
			lspconfig["emmet_language_server"].setup({
				capabilities = capabilities,
				filetypes = {
					"html",
					"typescriptreact",
					"javascriptreact",
					"css",
					"sass",
					"scss",
					"less",
					"svelte",
				},
				init_options = {
					preferences = {
						["jsx.enforceAttributeNameAsClassname"] = true,
					},
				},
			})
		end,

		-- ["emmet_ls"] = function()
		-- 	-- configure emmet language server
		-- 	lspconfig["emmet_ls"].setup({
		-- 		capabilities = capabilities,
		-- 		filetypes = {
		-- 			"html",
		-- 			"typescriptreact",
		-- 			"javascriptreact",
		-- 			"css",
		-- 			"sass",
		-- 			"scss",
		-- 			"less",
		-- 			"svelte",
		-- 		},
		-- 	})
		-- end,
		["lua_ls"] = function()
			-- configure lua server (with special settings)
			lspconfig["lua_ls"].setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							-- ✅ الطريقة الحديثة والآمنة لجلب ملفات النيوفيم دون مسح النظام بالكامل وبسرعة فائقة
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
							},
							maxPreload = 1000,
							preloadFileSize = 150,
						},
						completion = {
							callSnippet = "Replace",
						},
						hint = { enable = true },
					},
				},
			})
		end,
		-- ["lua_ls"] = function()
		-- 	-- configure lua server (with special settings)
		-- 	lspconfig["lua_ls"].setup({
		-- 		capabilities = capabilities,
		-- 		settings = {
		-- 			Lua = {
		-- 				-- make the language server recognize "vim" global
		-- 				diagnostics = {
		-- 					globals = { "vim" },
		-- 				},
		-- 				-- BUG: If any error this the cause
		-- 				workspace = {
		-- 					-- Make the server aware of Neovim runtime files
		-- 					library = vim.api.nvim_get_runtime_file("", true),
		-- 				},
		-- 				completion = {
		-- 					callSnippet = "Replace",
		-- 				},
		--
		-- 				hint = { enable = true },
		-- 			},
		-- 		},
		-- 	})
		-- end,
	},
})
