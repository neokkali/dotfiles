-- in your plugins file or dressing.lua
return {
	"stevearc/dressing.nvim",
	event = "VeryLazy",
	-- lazy = false, -- or event = "VeryLazy"
	priority = 1000, -- high priority to load early
	opts = {}, -- your configuration options
}
