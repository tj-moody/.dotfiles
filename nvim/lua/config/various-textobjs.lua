local to = require('various-textobjs')
to.setup({ useDefaultKeymaps = false })
local map = vim.keymap.set

map({ "o", "x" }, "as", function() to.subword("outer") end)
map({ "o", "x" }, "is", function() to.subword("inner") end)

map({ "o", "x" }, "ad", function() to.doubleSquareBrackets("outer") end)
map({ "o", "x" }, "id", function() to.doubleSquareBrackets("inner") end)

map({ "o", "x" }, "gG", function() to.entireBuffer() end)

-- map({ "o", "x" }, "!", function() to.diagnostic() end)
