local ibl = require("ibl")
local hooks = require("ibl.hooks")

-- تعريف ألوان قوس قزح للمجال النشط (Scope) فقط
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
	-- ألوان قوس قزح للمجال النشط
	vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
	vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
	vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
	vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
	vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
	vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
	vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })

	-- لون رمادي بسيط وواضح للخطوط العادية (غير النشطة)
	vim.api.nvim_set_hl(0, "SimpleIndent", { fg = "#3E4452" })
end)

ibl.setup({
	indent = {
		-- رموز منقطة ممتازة (اختر واحدًا يناسبك وضعه في char و tab_char)
		-- خيارات متاح لك تجربتها: "┊" (منقط خفيف) أو "┆" (مقطع) أو "┋" (منقط سميك)
		char = "┊",
		tab_char = "┊",
		highlight = "SimpleIndent", -- تطبيق اللون الرمادي البسيط على كل الخطوط العادية
	},
	scope = {
		enabled = true,
		char = "│",
		show_start = false,
		show_end = false,
		injected_languages = true,
		highlight = highlight, -- تلوين المجال النشط فقط بألوان قوس قزح
	},
})
