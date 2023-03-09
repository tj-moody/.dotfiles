local to = require('various-textobjs')
to.setup({ useDefaultKeymaps = true })

vim.keymap.set({ "o", "x" }, "as", function() to.subword(false) end)
vim.keymap.set({ "o", "x" }, "is", function() to.subword(true) end)

vim.keymap.set({ "o", "x" }, "ad", function() to.doubleSquareBrackets(false) end)
vim.keymap.set({ "o", "x" }, "id", function() to.doubleSquareBrackets(true) end)

-- vim.keymap.set({ "o", "x" }, "d", function() to.diagnostic() end)
