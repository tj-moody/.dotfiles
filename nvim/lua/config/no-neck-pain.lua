local nnp = require('no-neck-pain')
nnp.setup({
    debug = false,
    width = 100,
    minSideBufferWidth = 10,
    disableOnLastBuffer = false,
    killAllBuffersOnDisable = false,
    buffers = {
        setNames = true,
        scratchPad = {
            enabled = true,
            fileName = "projpad",
            location = "~/.local/share/no-neck-pain/"
        },
        -- colors to apply to both side buffers, for buffer scopped options @see |NoNeckPain.bufferOptions|
        --- see |NoNeckPain.bufferOptionsColors|
        colors = {},
        bo = {
            filetype = "projpad"
        },
        wo = {},
        right = { enabled = false, },
    },
    -- Supported integrations that might clash with `no-neck-pain.nvim`'s behavior.
    --- @type table
    integrations = {
        NvimTree = { reopen = false, },
        NeoTree = { reopen = false, },
        undotree = { reopen = true, },
    },
})
