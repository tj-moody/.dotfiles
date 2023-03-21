require('opts')
require('config.lazy')
require('mappings')
require('autocmds')

function P(table)
    -- print(vim.inspect(table))
    vim.notify(vim.inspect(table), 0)
end
