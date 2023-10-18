---via u/pseudometapseudo
---@param module string
---@return nil
function safe_require(module)
    local success, req = pcall(require, module)
    if success then return req end
    vim.cmd.echoerr('Error loading ' .. module)
end

safe_require('opts')
safe_require('startup_autocmds')
safe_require('config.lazy')
safe_require('mappings')
safe_require('plugin_autocmds')
safe_require('colorscheme').safe_reload()

function P(table)
    vim.notify(vim.inspect(table), 0)
end
