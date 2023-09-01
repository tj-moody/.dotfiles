local o = vim.opt
function _G.custom_fold_text()
    local line = vim.fn.getline(vim.v.foldstart)
    line = string.gsub(line, '{{{%d?', "")-- }}}

    local commentstring = vim.bo.commentstring:sub(1, -3)
    local escaped_commentstring = string.gsub(commentstring, '-', '%%-')

    line = string.gsub(line, escaped_commentstring .. "[% {]*$", "")

    line = string.gsub(line, '[ \t]+%f[\r\n%z]', '')
    -- remove trailing whitespace (via cyclaminist on stackoverflow)

    line = line .. (line:sub(-1) == '{' and ' … }' or ' …')

    return line .. ' '
end

o.foldtext = 'v:lua.custom_fold_text()'
o.fillchars = {
    stl = ' ',
    stlnc = ' ',
    foldopen = '',
    foldclose = '',
    fold = ' ',
    foldsep = ' ',
    diff = '╱',
    eob = ' ',
}
o.foldtext = 'v:lua.custom_fold_text()'
o.listchars = {
    tab = '▸ ▸',
}
o.list = true
o.foldcolumn = '3'
o.numberwidth = 3
o.signcolumn = 'yes:1'
o.number = true
o.relativenumber = true
o.breakindent = true
o.mouse = 'a'
o.hidden = true
o.autoindent = true
o.wildmenu = true
o.smartcase = true
o.ignorecase = true
o.termguicolors = true
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.splitbelow = true
o.splitright = true
o.laststatus = 3
o.scrolloff = 3
o.incsearch = true
o.wrap = false
o.showmode = false
o.cursorline = true
o.foldmethod = 'marker'
o.background = 'dark'
o.virtualedit = 'block'
o.matchpairs = '(:),{:},[:],<:>'
o.undofile = true
-- o.smoothscroll = true
o.textwidth = 80
o.formatoptions = "crjql"

vim.g.bufferline_show_all = false
vim.g.lualine_verbose = false
vim.g.have_fun = false
