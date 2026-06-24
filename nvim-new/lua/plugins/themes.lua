require("rose-pine").setup({})

require("catppuccin").setup({
	background = { -- :h background
		light = "latte",
		dark = "mocha",
	},
	transparent_background = true, -- disables setting the background color.
	float = {
		transparent = false, -- enable transparent floating windows
		solid = false, -- use solid styling for floating windows, see |winborder|
	},

	-- custom_highlights = function(colors)
	-- 	local bright_red = "#ff657a"
	-- 	local delimiter_red = "#ff4a5a"
	--
	-- 	return {
	-- 		Tag = { fg = bright_red, style = { "bold" } },
	-- 		htmlTag = { fg = bright_red },
	-- 		htmlTagName = { fg = bright_red, style = { "bold" } },
	--
	-- 		["@tag"] = { fg = bright_red, style = { "bold" } },
	-- 		["@tag.builtin"] = { fg = bright_red, style = { "bold" } },
	-- 		["@tag.attribute"] = { fg = colors.peach },
	--
	-- 		["@tag.delimiter"] = { fg = delimiter_red },
	-- 		htmlEndTag = { fg = delimiter_red },
	-- 	}
	-- end,
})

require("github-theme").setup({
	options = {
		transparent = true,
	},
})

-- TODO:
require("kanagawa").setup({
	transparent = true, -- do not set background color
	dimInactive = false, -- dim inactive window `:h hl-NormalNC`
	terminalColors = true, -- define vim.g.terminal_color_{0,17}
	colors = { -- add/modify theme and palette colors
		palette = {},
		theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
	},

	-- === تعديل الألوان هنا لجعل عمود الأرقام مدمجاً ===
	overrides = function(colors)
		local theme = colors.theme
		return {
			-- جعل خلفية عمود الأرقام شفافة (أو بنفس لون الخلفية الأساسية)
			LineNr = { bg = "NONE", fg = theme.ui.fg_dim },
			-- جعل عمود الإشارات الجانبي (SignColumn) شفافاً تماماً لمنع الخط المزعج
			SignColumn = { bg = "NONE" },
			-- لون رقم السطر الحالي الذي تقف عليه (تستطيع تغييره للون الأكسنت إذا أردت)
			CursorLineNr = { fg = theme.ui.fg, bold = true },
			-- اختياري: إذا كنت تستخدم التظليل للسطر الحالي وتريد إلغاء خلفيته المزعجة في الأرقام
			CursorLineSign = { bg = "NONE" },
		}
	end,

	theme = "wave", -- Load "wave" theme
	background = { -- map the value of 'background' option to a theme
		dark = "wave", -- try "dragon" !
		light = "lotus",
	},
})
