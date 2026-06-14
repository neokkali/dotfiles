local auto_session = require("auto-session")
auto_session.setup({
	auto_restore = false,
	suppressed_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
})

vim.keymap.set("n", "<leader>wr", "<cmd>AutoSession restore<CR>", { desc = "Restore session for cwd" }) -- restore last workspace session for current directory
vim.keymap.set("n", "<leader>ws", "<cmd>AutoSession save<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory
vim.keymap.set("n", "<leader>wl", "<cmd>SessionSearch<CR>", { desc = "Search for session" }) -- save workspace session for current working directory
