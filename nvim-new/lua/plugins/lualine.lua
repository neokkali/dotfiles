local lualine = require("lualine")

-- دالة مساعدة لجعل الكود أنظف
local colors = {
	bg = "#202328",
	fg = "#bbc2cf",
	yellow = "#ECBE7B",
	cyan = "#008080",
	darkblue = "#081633",
	green = "#98be65",
	orange = "#FF8800",
	violet = "#a9a1e1",
	magenta = "#c678dd",
	blue = "#51afef",
	red = "#ec5f67",
}

lualine.setup({
	options = {
		theme = "auto",
		icons_enabled = true,
		component_separators = { left = "", right = "" }, -- إزالة الفواصل لجعلها تندمج مع الخلفية
		section_separators = { left = "", right = "" }, --  للبداية و  للنهاية يعطي شكلاً احترافياً
		global_status = true,
	},
	sections = {
		lualine_a = { { "mode", icon = "" } },
		lualine_b = {
			{ "branch", icon = "" },
			{ "diff", symbols = { added = " ", modified = " ", removed = " " } },
		},
		lualine_c = {
			{ "filename", path = 1, symbols = { modified = " ", readonly = " " } },
		},
		lualine_x = {
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = { error = " ", warn = " ", info = " " },
			},
			"filetype",
		},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
})
