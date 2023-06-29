local opts = {
	fillchars = {
        stl = " ",
        stlnc = " ",
		foldopen = "",
		foldclose = "",
		fold = " ",
		foldsep = " ",
		diff = "╱",
		eob = " ",

        -- -- horiz = ' ',
        -- horizup = '─',
        -- horizdown = '─',
        -- -- horizup = ' ',
        -- -- horizdown = ' ',
        -- vert = ' ',
        -- vertleft = ' ',
        -- vertright = ' ',
        -- verthoriz = ' ',

	},
	foldcolumn = "2",
	signcolumn = "yes:1",
	number = true,
	relativenumber = true,
    breakindent = true,
	mouse = "a",
	hidden = true,
	autoindent = true,
	wildmenu = true,
	smartcase = true,
	ignorecase = true,
	termguicolors = true,
	tabstop = 4,
	shiftwidth = 4,
	expandtab = true,
	splitbelow = true,
	splitright = true,
    laststatus = 3,
    scrolloff = 3,
    incsearch = true,
    wrap = false,
    showmode = false,
    cursorline = true,
    foldmethod = "marker",
    background = 'dark',
    -- smoothscroll = true,
}
for k, v in pairs(opts) do
	vim.opt[k] = v
end

vim.g.bufferline_show_all = false
vim.g.have_fun = false

vim.cmd [[set formatoptions-=cro]]
