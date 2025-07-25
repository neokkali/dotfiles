return {
	"folke/tokyonight.nvim",
	priority = 1000,
	config = function()
		local transparent = false

		-- رمادي داكن بارد (مريح للعين)
		local bg = "#1c1e26"
		local bg_dark = "#1a1c23"
		local bg_highlight = "#2c2f38"
		local bg_search = "#3b4261"
		local bg_visual = "#3e4452"
		local fg = "#dcdfe4"
		local fg_dark = "#b6bccd"
		local fg_gutter = "#4b5261"
		local border = "#3c4454"

		require("tokyonight").setup({
			style = "night",
			transparent = transparent,
			styles = {
				sidebars = transparent and "transparent" or "dark",
				floats = transparent and "transparent" or "dark",
			},
			on_colors = function(colors)
				colors.bg = bg
				colors.bg_dark = transparent and colors.none or bg_dark
				colors.bg_float = transparent and colors.none or bg_dark
				colors.bg_highlight = bg_highlight
				colors.bg_popup = bg_dark
				colors.bg_search = bg_search
				colors.bg_sidebar = transparent and colors.none or bg_dark
				colors.bg_statusline = transparent and colors.none or bg_dark
				colors.bg_visual = bg_visual
				colors.border = border
				colors.fg = fg
				colors.fg_dark = fg_dark
				colors.fg_float = fg
				colors.fg_gutter = fg_gutter
				colors.fg_sidebar = fg_dark
			end,
		})

		vim.cmd("colorscheme tokyonight")
	end,
}
