local nvimtree = require("nvim-tree")
local api = require("nvim-tree.api")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local function my_on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- Default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- Override Enter to open in a new tab
	vim.keymap.set({ "i", "n" }, "t", api.node.open.tab, opts("Open: New Tab"))
end

nvimtree.setup({

	on_attach = my_on_attach,
	view = { width = 35 },
	renderer = {
		indent_markers = { enable = true },
		icons = {
			glyphs = {
				folder = { arrow_closed = "", arrow_open = "" },
			},
		},
	},
	actions = {
		open_file = { window_picker = { enable = true }, quit_on_open = true },
	},
	filters = { custom = { ".DS_Store" } },
	git = { enable = false, ignore = false },
})

-- require("nvim-tree").setup({
--   git = {
--     enable = true, -- Leaves background processing on
--   },
--   renderer = {
--     highlight_git = false, -- Disables filename color changes
--     icons = {
--       show = {
--         git = false, -- Hides the git icons (e.g., [✗], [✓], [★])
--       },
--     },
--   },
-- })

vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })
vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
