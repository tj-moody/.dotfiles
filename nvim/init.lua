---via u/pseudometapseudo
---@param module string
---@return Nvimtree | Colorscheme | PluginLoader | nil
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

-- NOTE: Order irrelevant
plugins.add("colorscheme")
plugins.add("ui")
plugins.add("editing")
plugins.add("treesitter")
plugins.add("lsp")
plugins.add("search")
plugins.add("git")
plugins.add("languages")
plugins.add("project")
plugins.add("dap")

plugins.add("nvim-tree")
plugins.add("lualine")
plugins.add('bufferline')

plugins.add("fun")

plugins.load()

safe_require("mappings")
safe_require("plugin_autocmds")
safe_require("plugins.colorscheme").safe_reload()

function P(table)
    vim.notify(vim.inspect(table), 0)
end

if #vim.v.argv <= 4 then
    vim.cmd("AutoSession restore")
end
