local luasnip = require("luasnip")
local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(
        0, line - 1, line, true
    )[1]:sub(col, col):match("%s") == nil
end

-- local symbol_map = {
--     Text = "",
--     Method = "",
--     Function = "",
--     Constructor = "",
--     Field = "ﰠ",
--     Variable = "",
--     Class = "ﴯ",
--     Interface = "",
--     Module = "",
--     Property = "ﰠ",
--     Unit = "塞",
--     Value = "",
--     Enum = "",
--     Keyword = "",
--     Snippet = "",
--     Color = "",
--     File = "",
--     Reference = "",
--     Folder = "",
--     EnumMember = "",
--     Constant = "",
--     Struct = "פּ",
--     Event = "",
--     Operator = "",
--     TypeParameter = "",
-- }

local cmp = require('cmp')

---@diagnostic disable missing-fields
cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    window = {
        completion = {
            col_offset = -3,
            side_padding = 0,
        },
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.cmdline {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        -- ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.confirm({ select = false }),
        -- Accept currently selected item. Set `select`
        -- to `false` to only confirm explicitly selected items.
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            -- Don't allow tab to cycle while
            -- able to jump to next snippet location
            if cmp.visible() and not luasnip.expand_or_jumpable() then
                cmp.select_next_item()
                -- You could replace the expand_or_jumpable()
                -- calls with expand_or_locally_jumpable()
                -- that way you will only jump inside the snippet region
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<C-N>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<C-P>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    sources = cmp.config.sources(
        {
            { name = 'nvim_lsp' },
            { name = 'luasnip' }, -- For luasnip users.
            { name = 'path' },
        },
        {
            { name = 'buffer' },
            -- { name = 'cmdline' },
        }
    ),
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            -- Kind icons
            local kind = require("lspkind").cmp_format({
                mode = "symbol_text",
                maxwidth = 50,
            })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            -- kind.menu = "    (" .. (strings[2] or "") .. ")"
            kind.menu = ({
                buffer = "(Buf)",
                nvim_lsp = "(LSP)",
                luasnip = "(SNP)",
                nvim_lua = "(Lua)",
                latex_symbols = "(Text)",
                cmdline = "(Cmd)"
            })[entry.source.name]
            return kind
        end,
    },
    completion = {
        keyword_length = 2,
    },
    experimental = {
        -- ghost_text = { hl_group = 'Comment' },
        ghost_text = true,
    },
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        -- You can specify the `cmp_git` source if you were installed it.
        { name = 'cmp_git' },
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?`
-- (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':'
-- (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

vim.diagnostic.config {
    virtual_text = true,
    virtual_lines = false,
    underline = true,
}

require("lsp_lines").setup()

local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn",  text = "" },
    { name = "DiagnosticSignHint",  text = "" },
    { name = "DiagnosticSignInfo",  text = "" },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, {
        texthl = sign.name,
        text = sign.text,
        numhl = "",
    })
end

-- local cmp_colors = {
--     { "PmenuSel",                 { bg = "#282C34", fg = "NONE" }, },
--     { "Pmenu",                    { fg = "#C5CDD9", bg = "#22252A" }, },
--     { "CmpItemAbbrDeprecated",    { fg = "#7E8294", bg = "NONE", strikethrough = true, }, },
--     { "CmpItemAbbrMatch",         { fg = "#82AAFF", bg = "NONE", bold = true, }, },
--     { "CmpItemAbbrMatchFuzzy",    { fg = "#82AAFF", bg = "NONE", bold = true, }, },
--     { "CmpItemMenu",              { fg = "#C792EA", bg = "NONE", italic = true, }, },
--     { "CmpItemKindField",         { fg = "#EED8DA", bg = "#B5585F" }, },
--     { "CmpItemKindProperty",      { fg = "#EED8DA", bg = "#B5585F" }, },
--     { "CmpItemKindEvent",         { fg = "#EED8DA", bg = "#B5585F" }, },
--     -- { "CmpItemKindText",          { fg = "#C3E88D", bg = "#9FBD73" }, },
--     -- { "CmpItemKindEnum",          { fg = "#C3E88D", bg = "#9FBD73" }, },
--     -- { "CmpItemKindKeyword",       { fg = "#C3E88D", bg = "#9FBD73" }, },
--     { "CmpItemKindText",          { fg = "#EADFF0", bg = "#9FBD73" }, },
--     { "CmpItemKindEnum",          { fg = "#EADFF0", bg = "#9FBD73" }, },
--     { "CmpItemKindKeyword",       { fg = "#EADFF0", bg = "#9FBD73" }, },
--     { "CmpItemKindConstant",      { fg = "#FFE082", bg = "#D4BB6C" }, },
--     { "CmpItemKindConstructor",   { fg = "#FFE082", bg = "#D4BB6C" }, },
--     { "CmpItemKindReference",     { fg = "#FFE082", bg = "#D4BB6C" }, },
--     { "CmpItemKindFunction",      { fg = "#EADFF0", bg = "#A377BF" }, },
--     { "CmpItemKindStruct",        { fg = "#EADFF0", bg = "#A377BF" }, },
--     { "CmpItemKindClass",         { fg = "#EADFF0", bg = "#A377BF" }, },
--     { "CmpItemKindModule",        { fg = "#EADFF0", bg = "#A377BF" }, },
--     { "CmpItemKindOperator",      { fg = "#EADFF0", bg = "#A377BF" }, },
--     { "CmpItemKindVariable",      { fg = "#C5CDD9", bg = "#7E8294" }, },
--     { "CmpItemKindFile",          { fg = "#C5CDD9", bg = "#7E8294" }, },
--     { "CmpItemKindUnit",          { fg = "#F5EBD9", bg = "#D4A959" }, },
--     { "CmpItemKindSnippet",       { fg = "#F5EBD9", bg = "#D4A959" }, },
--     { "CmpItemKindFolder",        { fg = "#F5EBD9", bg = "#D4A959" }, },
--     { "CmpItemKindMethod",        { fg = "#DDE5F5", bg = "#6C8ED4" }, },
--     { "CmpItemKindValue",         { fg = "#DDE5F5", bg = "#6C8ED4" }, },
--     { "CmpItemKindEnumMember",    { fg = "#DDE5F5", bg = "#6C8ED4" }, },
--     { "CmpItemKindInterface",     { fg = "#D8EEEB", bg = "#58B5A8" }, },
--     { "CmpItemKindColor",         { fg = "#D8EEEB", bg = "#58B5A8" }, },
--     { "CmpItemKindTypeParameter", { fg = "#D8EEEB", bg = "#58B5A8" }, },
-- }
-- for _, v in ipairs(cmp_colors) do
--     vim.api.nvim_set_hl(0, v[1], v[2])
-- end
