require('smart-splits').setup {
    -- During resize
    ignored_filetypes = {
        'nofile',
        'quickfix',
        'prompt',
    },
    ignored_events = {
        'BufEnter',
        'WinEnter',
    },
    ignored_buftypes = { 'NvimTree' },
    default_amount = 3,
    resize_mode = {
        quit_key = '<ESC>',
        resize_keys = { 'h', 'j', 'k', 'l' },
        silent = true,
        hooks = {
            on_enter = nil,
            on_leave = nil,
        },
    },

    move_cursor_same_row = false,

    multiplexer_integration = true,
    disable_multiplexer_nav_when_zoomed = true,
    at_edge = function(args)
        ({
            ["left"] = vim.cmd.NavigatorLeft,
            ["right"] = vim.cmd.NavigatorRight,
            ["up"] = vim.cmd.NavigatorUp,
            ["down"] = vim.cmd.NavigatorDown,
        })[args.direction]()
    end,
}
