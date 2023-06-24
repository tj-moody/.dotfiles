require('opts')
require('config.lazy')
require('mappings')
require('autocmds')

function P(table)
    vim.notify(vim.inspect(table), 0)
end

-- TODO: Add extmark to hide folds
-- TODO: Make external file format to automatically run/test code
