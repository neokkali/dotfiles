-- custom/highlights.lua
local M = {}

function M.set_highlights()
	-- 💠 HTML و TSX: تلوين التاقات
	vim.api.nvim_set_hl(0, "@tag.html", { fg = "#7aa2f7", bold = true })
	vim.api.nvim_set_hl(0, "@tag.tsx", { fg = "#7aa2f7", bold = true })
	vim.api.nvim_set_hl(0, "@tag.builtin.tsx", { fg = "#7aa2f7", bold = true })
	vim.api.nvim_set_hl(0, "@_jsx_element.tsx", { fg = "#7aa2f7", bold = true })

	-- 💠 السمات (class, id, href ...)
	vim.api.nvim_set_hl(0, "@attribute.html", { fg = "#e0af68" })
	vim.api.nvim_set_hl(0, "@attribute.tsx", { fg = "#e0af68" })

	-- 💠 القيم النصية للسمات
	vim.api.nvim_set_hl(0, "@string.html", { fg = "#9ece6a" })
	vim.api.nvim_set_hl(0, "@string.tsx", { fg = "#9ece6a" })

	-- 💠 النصوص داخل العناصر
	vim.api.nvim_set_hl(0, "@text.html", { fg = "#c0caf5" })
	vim.api.nvim_set_hl(0, "@text.tsx", { fg = "#c0caf5" })

	-- 💠 المتغيرات داخل JSX
	vim.api.nvim_set_hl(0, "@variable.tsx", { fg = "#bb9af7" })

	-- (اختياري) تحسين وضوح النصوص الغامقة
	vim.api.nvim_set_hl(0, "Normal", { fg = "#c0caf5", bg = nil })
end

return M
