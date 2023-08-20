function _G.custom_fold_text()
    local line = vim.fn.getline(vim.v.foldstart)
    line = string.gsub(line, '{{{', "") --}}}

    local commentstring = vim.bo.commentstring:sub(1, -3)
    commentstring = string.gsub(commentstring, '-', '%%-') -- escape commentstring
    line = string.gsub(line, commentstring, "")

    line = string.gsub(line, '[ \t]+%f[\r\n%z]', '') -- remove trailing whitespace (via cyclaminist on stackoverflow)

    -- if line:sub(-1) == '{' then
    --     line = line .. '...}'
    -- else
    --     line = line .. ' ...'
    -- end

    line = line .. (line:sub(-1) == '{' and '...}' or ' ...')

    return line .. ' '
end

vim.opt.foldtext = 'v:lua.custom_fold_text()'
local opts = {
    fillchars = { -- {{{
        stl = ' ',
        stlnc = ' ',
        foldopen = '',
        foldclose = '',
        fold = ' ',
        foldsep = ' ',
        diff = '╱',
        eob = ' ',

        -- -- horiz = ' ',
        -- horizup = '─',
        -- horizdown = '─',
        -- -- horizup = ' ',
        -- -- horizdown = ' ',
        -- vert = ' ',
        -- vertleft = ' ',
        -- vertright = ' ',
        -- verthoriz = ' ',

    }, -- }}}
    foldtext = 'v:lua.custom_fold_text()',
    listchars = {
        tab = '▸ ',
    },
    list = true,
    foldcolumn = '2',
    signcolumn = 'yes:1',
    number = true,
    relativenumber = true,
    breakindent = true,
    mouse = 'a',
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
    foldmethod = 'marker',
    background = 'dark',
    virtualedit = 'block',
    matchpairs = '(:),{:},[:],<:>',
    undofile = true,
    -- smoothscroll = true,
}
for k, v in pairs(opts) do
    vim.opt[k] = v
end

vim.g.bufferline_show_all = false
vim.g.lualine_verbose = false
vim.g.have_fun = false

vim.cmd [[set formatoptions-=cro]]
vim.cmd [[set formatoptions+=j]]
