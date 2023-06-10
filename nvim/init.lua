require('opts')
require('config.lazy')
require('mappings')
require('autocmds')

function P(table)
    vim.notify(vim.inspect(table), 0)
end
