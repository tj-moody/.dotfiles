local opts = {
	fillchars = {
		foldopen = "",
		foldclose = "",
		fold = " ",
		foldsep = " ",
		diff = "╱",
		eob = " ",

        -- horiz = ' ',
        horizup = '─',
        horizdown = '─',
        -- horizup = ' ',
        -- horizdown = ' ',
        vert = ' ',
        vertleft = ' ',
        vertright = ' ',
        verthoriz = ' ',

	},
	foldcolumn = "2",
	signcolumn = "yes:1",
	number = true,
	relativenumber = true,
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
}
for k, v in pairs(opts) do
	vim.opt[k] = v
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd [[set formatoptions-=cro]]
