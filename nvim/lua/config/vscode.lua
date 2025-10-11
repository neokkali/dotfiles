vim.g.mapleader = " "

if vim.g.vscode then
	vim.keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
	local opts = { noremap = true, silent = true }

	local mappings = {
		{ "n", "<leader>re", "editor.action.rename" },
		-- { "i", "<leader>jk", "editor.action.escape" },

		{ "n", "<leader>gd", "editor.action.revealDefinition" },
		{ "n", "<leader>gy", "editor.action.goToTypeDefinition" },
		{ "n", "<leader>gi", "editor.action.goToImplementation" },
		{ "n", "<leader>gr", "editor.action.goToReferences" },
		{ "n", "<leader>gs", "workbench.action.goToSymbol" },
		{ "n", "<leader>gl", "workbench.action.goToLine" },

		{ "n", "<leader>nf", "workbench.action.navigateForward" },
		{ "n", "<leader>nb", "workbench.action.navigateBack" },
		{ "n", "<leader>je", "workbench.action.navigateToLastEditLocation" },

		{ "n", "<leader>ss", "workbench.action.showAllSymbols" },
	}

	for _, mapping in ipairs(mappings) do
		local mode, key, command = mapping[1], mapping[2], mapping[3]

		vim.keymap.set(mode, key, function()
			vim.fn.VSCodeNotify(command)
		end, opts)
	end
end
