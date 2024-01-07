local o = vim.opt
function _G.custom_fold_text()
    local commentstring = vim.bo.commentstring:sub(1, -4)
    local escaped_commentstring = string.gsub(commentstring, '-', '%%-')
    local pos = vim.v.foldstart
    local line = vim.api.nvim_buf_get_lines(0, pos - 1, pos, false)[1]
    local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
    local parser = vim.treesitter.get_parser(0, lang)
    local query = vim.treesitter.query.get(parser:lang(), "highlights")

    if query == nil then
        return vim.fn.foldtext()
    end

    local tree = parser:parse({ pos - 1, pos })[1]
    local result = {}

    local line_pos = 0

    local prev_range = nil

    for id, node, _ in query:iter_captures(tree:root(), 0, pos - 1, pos) do
        local name = query.captures[id]
        local start_row, start_col, end_row, end_col = node:range()
        if start_row == pos - 1 and end_row == pos - 1 then
            local range = { start_col, end_col }
            if start_col > line_pos then
                table.insert(result, { line:sub(line_pos + 1, start_col), "Folded" })
            end
            line_pos = end_col
            local text = vim.treesitter.get_node_text(node, 0)
            if prev_range ~= nil and range[1] == prev_range[1] and range[2] == prev_range[2] then
                result[#result] = { text, "@" .. name }
            else
                table.insert(result, { text, "@" .. name })
            end
            prev_range = range
        end
    end
    result[#result][1] = string.gsub(result[#result][1], "%s*" .. escaped_commentstring .. "%s*", "") -- .. "[% {]*$", "")
    result[#result][1] = string.gsub(result[#result][1], "%s*{{{%d*", "")                             -- .. "[% {]*$", "")
    result[#result][1] = string.gsub(result[#result][1], "%s*}}}%d*", "")                             -- .. "[% {]*$", "")
    for _ = 0, 1 do
        if result[#result][1] == "" or result[#result][1] == " " then
            result[#result] = nil
        end
    end
    result[#result + 1] = { " … ", "@operator" }
    if result[#result - 1] and result[#result - 1][1] == "{" then
        table.insert(result, { "}", result[#result - 1][2] })
    end

    return result
end
o.foldtext = 'v:lua.custom_fold_text()'

o.fillchars = { --{{{
    stl = ' ',
    stlnc = ' ',
    foldopen = '',
    foldclose = '',
    fold = ' ',
    foldsep = ' ',
    diff = '╱',
    eob = ' ',
} -- }}}
o.listchars = {
    tab = '▸ ',
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
o.smoothscroll = true
o.textwidth = 80
o.formatoptions = "rjql"
o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,localoptions"
o.grepprg = "rg --vimgrep --smart-case --follow"
o.showtabline = 2
o.tabline = " "

vim.g.bufferline_show_all = true
vim.g.lualine_verbose = false
vim.g.have_fun = false
vim.g.zen_mode = false

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_node_provider = 0
