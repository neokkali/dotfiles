local nvimtree = require("nvim-tree")
local api = require("nvim-tree.api")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- دالة ذكية لفتح الملفات
local function smart_open(filepath)
	local buffers = vim.fn.getbufinfo({ buflisted = 1 })
	local buf_count = #buffers

	if buf_count <= 1 then
		-- أول ملف: افتح في buffer الحالي
		vim.cmd("edit " .. filepath)
	else
		-- ملفات أخرى: افتح في tab جديد
		vim.cmd("tabnew " .. filepath)
	end
end

nvimtree.setup({
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
		open_file = { window_picker = { enable = false }, quit_on_open = false },
	},
	filters = { custom = { ".DS_Store" } },
	git = { ignore = false },
})

vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })
vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
