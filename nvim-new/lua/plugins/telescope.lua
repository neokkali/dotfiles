local telescope = require("telescope")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local transform_mod = require("telescope.actions.mt").transform_mod

local custom_actions = transform_mod({
	open_in_smart_tab = function(prompt_bufnr)
		local selection = action_state.get_selected_entry()
		if not selection then
			return
		end

		local file_path = selection.path or selection.filename
		local bufnr = vim.fn.bufnr(file_path)

		-- جلب إحداثيات السطر والعمود (تليسكوب يستخدم 1-indexed للأسطر و 0-indexed للأعمدة غالباً)
		local lnum = selection.lnum
		local col = selection.col or 1

		local found = false
		if bufnr ~= -1 then
			for _, tabnr in ipairs(vim.api.nvim_list_tabpages()) do
				for _, winnr in ipairs(vim.api.nvim_tabpage_list_wins(tabnr)) do
					if vim.api.nvim_win_get_buf(winnr) == bufnr then
						-- إغلاق نافذة التليسكوب قبل التنقل
						actions.close(prompt_bufnr)

						-- الانتقال للتاب والنافذة
						vim.api.nvim_set_current_tabpage(tabnr)
						vim.api.nvim_set_current_win(winnr)

						-- توجيه المؤشر إلى مكان الخطأ بالتحديد إذا توفرت الإحداثيات
						if lnum then
							vim.api.nvim_win_set_cursor(winnr, { lnum, col })
						end

						found = true
						break
					end
				end
				if found then
					break
				end
			end
		end

		if not found then
			-- إذا لم يكن الملف مفتوحاً، نتركه لتليسكوب لفتحه في تاب جديد
			actions.select_tab(prompt_bufnr)
			-- بعد فتح التاب الجديد، نوجه المؤشر لمكان الخطأ
			if lnum then
				vim.api.nvim_win_set_cursor(0, { lnum, col })
			end
		end
	end,
})

telescope.setup({
	defaults = {
		file_ignore_patterns = { "node_modules", ".git", "venv", ".next" },
		path_display = { "smart" },
		preview = {
			treesitter = false,
		},
		mappings = {
			i = {
				["<CR>"] = custom_actions.open_in_smart_tab,
				["<C-k>"] = actions.move_selection_previous,
				["<C-j>"] = actions.move_selection_next,
			},
			n = {
				["<CR>"] = custom_actions.open_in_smart_tab,
			},
		},
	},
})

vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
vim.keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
-- إضافة اختصار الأخطاء أسفل الإعدادات للتأكد من عمله بشكل سليم
vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics<cr>", { desc = "Workspace Diagnostics" })
