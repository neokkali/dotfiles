vim.cmd("let g:netrw_liststyle = 3")

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.scrolloff = 10 -- Keep 10 lines above/below cursor
vim.opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor
vim.opt.cmdheight = 1 -- Command line height
vim.opt.spelllang = { "en", "ar" } -- Set language for spellchecking

vim.opt.wrap = true -- Wrap the content of the screen
vim.opt.linebreak = true
vim.opt.breakindent = true
-- vim.opt.cursorline = true

-- tabs & indentation
vim.opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
vim.opt.shiftwidth = 2 -- 2 spaces for indent width
vim.opt.expandtab = true -- expand tab to spaces
vim.opt.smartindent = true
vim.opt.autoindent = true -- copy indent from current line when starting new one

-- search settings
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive
vim.opt.incsearch = true
vim.opt.inccommand = "split"

vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
-- opt.colorcolumn = "80"

-- turn on termguicolors for tokyonight colorscheme to work
-- (have to use iterm2 or any other true color terminal)
vim.opt.termguicolors = true
vim.opt.background = "dark" -- colorschemes that can be light or dark will be made dark
vim.opt.signcolumn = "yes" -- show sign column so that text doesn't shift
vim.opt.showmatch = true -- Hightlight matching brackets

-- backspace
vim.opt.backspace = { "indent", "eol", "start" } -- allow backspace on indent, end of line or insert mode start position

-- clipboard
vim.opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
vim.opt.splitright = true -- split vertical window to the right
vim.opt.splitbelow = true -- split horizontal window to the bottom

vim.opt.encoding = "utf-8"
vim.g.arabicshape = true

-- turn off swapfile
-- vim.g.fileformat = "unix"
vim.opt.swapfile = false
vim.opt.mouse = "a"
vim.g.editorconfig = true
-- undo
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = false
