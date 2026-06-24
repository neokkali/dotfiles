local lint = require("lint")

lint.linters_by_ft = {
	-- INFO: Return this if anything not working correctly
	-- javascript = { "eslint_d" },
	-- typescript = { "eslint_d" },
	-- javascriptreact = { "eslint_d" },
	-- typescriptreact = { "eslint_d" },
	-- svelte = { "eslint_d" },
	-- python = { "ruff" },

	javascript = {},
	typescript = {},
	javascriptreact = {},
	typescriptreact = {},
	svelte = {},
	python = { "ruff" },

	-- python = { "pyright" },
	-- python = { "flake8" },
	-- python = { "flake8", "pylint" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

-- INFO: Return this if anything not working correctly
-- vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = lint_augroup,
	callback = function()
		lint.try_lint()
	end,
})

vim.keymap.set("n", "<leader>l", function()
	lint.try_lint()
end, { desc = "Trigger linting for current file" })
