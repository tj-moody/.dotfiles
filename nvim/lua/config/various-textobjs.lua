local to = require('various-textobjs')
to.setup({ useDefaultKeymaps = false })

vim.keymap.set({ "o", "x" }, "as", function() to.subword(false) end)
vim.keymap.set({ "o", "x" }, "is", function() to.subword(true) end)

vim.keymap.set({ "o", "x" }, "ad", function() to.doubleSquareBrackets(false) end)
vim.keymap.set({ "o", "x" }, "id", function() to.doubleSquareBrackets(true) end)

vim.keymap.set({ "o", "x" }, "gG", function() to.entireBuffer() end)

-- vim.keymap.set({ "o", "x" }, "!", function() to.diagnostic() end)
