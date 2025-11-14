---via u/pseudometapseudo
---@param module string
function safe_require(module)
    local success, req = pcall(require, module)
    if success then
        return req
    end
    vim.cmd.echoerr("Error loading " .. module)
end

safe_require("opts")
safe_require("startup_autocmds")

local plugins = safe_require("plugins")
if plugins == nil then
    return
end

vim.loader.enable()

plugins.add({
    "colorscheme",
    "ui",
    "editing",
    "treesitter",
    "lsp",
    "search",
    "git",
    "languages",
    "project",
    "dap",

    "nvim-tree",
    "lualine",
    'bufferline',

    "fun",
})

plugins.load()

safe_require("mappings")
safe_require("plugin_autocmds")
safe_require("plugins.colorscheme").safe_reload()

function P(table)
    vim.notify(vim.inspect(table), 0)
end

if #vim.v.argv <= 2 then
    vim.cmd("AutoSession restore")
end
