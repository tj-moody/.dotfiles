-- via u/pseudometapseudo
function safe_require(module)
    local success, req = pcall(require, module)
    if success then return req end
    vim.cmd.echoerr('Error loading ' .. module)
end

safe_require('opts')
safe_require('config.lazy')
safe_require('mappings')
safe_require('autocmds')

function P(table)
    vim.notify(vim.inspect(table), 0)
end
