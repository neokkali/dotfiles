-- ~/.config/nvim/lua/plugins/nvim-tree.lua
return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
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
			on_attach = function(bufnr)
				local opts = { buffer = bufnr, noremap = true, silent = true }

				-- إعادة تعيين Enter لفتح الملفات بشكل ذكي
				vim.keymap.set("n", "<CR>", function()
					local node = api.tree.get_node_under_cursor()
					if not node then
						return
					end

					if node.type == "file" then
						smart_open(node.absolute_path)
					elseif node.type == "directory" then
						api.node.open.edit() -- فتح/اغلاق المجلد
					end
				end, opts)
			end,
			filters = { custom = { ".DS_Store" } },
			git = { ignore = false },
		})

		-- اختصارات مفاتيح
		local keymap = vim.keymap
		keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
		keymap.set(
			"n",
			"<leader>ef",
			"<cmd>NvimTreeFindFileToggle<CR>",
			{ desc = "Toggle file explorer on current file" }
		)
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
	end,
}
