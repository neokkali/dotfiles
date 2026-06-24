local ibl = require("ibl")
local hooks = require("ibl.hooks")

-- تعريف ألوان قوس قزح للمجال النشط (Scope)
local highlight = {
	"RainbowRed",
	"RainbowYellow",
	"RainbowBlue",
	"RainbowOrange",
	"RainbowGreen",
	"RainbowViolet",
	"RainbowCyan",
}

hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	-- تم تخفيض سطوع ألوان قوس قزح للمجال النشط لتصبح خافتة جداً وشبحية
	vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#4C3235" })
	vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#4C4532" })
	vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#323D4C" })
	vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#4C3B32" })
	vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#354C32" })
	vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#45324C" })
	vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#324C48" })

	-- لون رمادي داكن جداً للخطوط العادية غير النشطة لتبدو شبه مخفية
	vim.api.nvim_set_hl(0, "SimpleIndent", { fg = "#242A35" })
end)

ibl.setup({
	whitespace = {
		remove_blankline_trail = false,
	},
	indent = {
		-- استخدام الرمز المنقط الأكثر نعومة وخفة
		char = "┊",
		tab_char = "┊",
		highlight = "SimpleIndent", -- تطبيق اللون الرمادي شبه المخفي
	},
	scope = {
		enabled = true,
		char = "┊", -- جعل خط المجال النشط منقطاً أيضاً ليبقى المظهر متناسقاً وخفيفاً
		show_start = false,
		show_end = false,
		injected_languages = true,
		highlight = highlight, -- تطبيق ألوان قوس قزح المخففة جداً
	},
})
