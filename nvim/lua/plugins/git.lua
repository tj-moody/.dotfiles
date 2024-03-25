local M = {}
M.spec = {
    {
        'lewis6991/gitsigns.nvim',
        config = true,
        event = "LazyFile",
    },
    {
        'sindrets/diffview.nvim',
        cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory' },
        dependencies = 'nvim-lua/plenary.nvim',
    },
}
return M
