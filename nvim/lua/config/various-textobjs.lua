local to = require('various-textobjs')
to.setup({ useDefaultKeymaps = false })
local map = vim.keymap.set

map({ "o", "x" }, "as", function() to.subword(false) end)
map({ "o", "x" }, "is", function() to.subword(true) end)

map({ "o", "x" }, "ad", function() to.doubleSquareBrackets(false) end)
map({ "o", "x" }, "id", function() to.doubleSquareBrackets(true) end)

map({ "o", "x" }, "gG", function() to.entireBuffer() end)

-- map({ "o", "x" }, "!", function() to.diagnostic() end)
