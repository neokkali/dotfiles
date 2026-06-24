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

		-- [الحل المضاف]: إذا كان الاختيار عبارة عن Code Action (لا يحتوي على ملف أو بافر)
		-- نترك تليسكوب ينفذ الإجراء الافتراضي الخاص به فوراً ونخرج من الدالة لتجنب الانهيار
		local is_code_action = not selection.bufnr
			and not selection.path
			and not selection.filename
			and not selection[1]
		if is_code_action then
			actions.select_default(prompt_bufnr)
			return
		end

		-- جلب رقم البافر بأمان إن وجد (للأخطاء والملفات)
		local bufnr = selection.bufnr
		if not bufnr then
			local file_path = selection.path or selection.filename or selection[1]
			if type(file_path) == "string" then
				bufnr = vim.fn.bufnr(file_path)
			else
				bufnr = -1
			end
		end

		local lnum = selection.lnum
		local col = selection.col or 1

		local found = false
		-- التأكد من أن البافر صالح وموجود حالياً
		if bufnr and bufnr ~= -1 and vim.api.nvim_buf_is_valid(bufnr) then
			for _, tabnr in ipairs(vim.api.nvim_list_tabpages()) do
				for _, winnr in ipairs(vim.api.nvim_tabpage_list_wins(tabnr)) do
					if vim.api.nvim_win_get_buf(winnr) == bufnr then
						-- إغلاق نافذة التليسكوب قبل الانتقال
						actions.close(prompt_bufnr)

						-- الانتقال للتاب والنافذة المفتوحة مسبقاً
						vim.api.nvim_set_current_tabpage(tabnr)
						vim.api.nvim_set_current_win(winnr)

						-- توجيه المؤشر بأمان
						if lnum then
							pcall(vim.api.nvim_win_set_cursor, winnr, { lnum, col })
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

		-- إذا كان ملفاً حقيقياً ولكنه غير مفتوح في أي تاب، افتحه في تاب جديد
		if not found then
			actions.select_tab(prompt_bufnr)
			if lnum then
				pcall(vim.api.nvim_win_set_cursor, 0, { lnum, col })
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
vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics<cr>", { desc = "Workspace Diagnostics" })
