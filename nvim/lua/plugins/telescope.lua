return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",

		-- Optional: Fuzzy finder performance boost (requires make)
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			"nvim-tree/nvim-web-devicons",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
	},
	config = function()
		require("telescope").setup({
			defaults = {
				file_ignore_patterns = { "node_modules", ".git/", ".next" },
			},
			pickers = {
				find_files = {
					hidden = true,
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		})
		-- BUG: fix

		-- Load the extension if compiled
		pcall(require("telescope").load_extension, "fzf")

		local keymap = vim.keymap.set

		keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		--keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		keymap("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
		--keymap("n", "<leader>fs", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
		--keymap("n", "<leader>fs", "<cmd>Telescope TodoTelescope<cr>", { desc = "Find todos" })
	end,
}
