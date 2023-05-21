-- defaults
require('flote').setup{
    q_to_quit = true,
    window_style = 'minimal',
    window_border = 'solid',
    window_title = true,
    notes_dir = vim.fn.stdpath('cache') .. '/flote',
    files = {
        global = 'flote-global.md',
        cwd = function ()
           return vim.fn.getcwd()
        end,
        file_name = function (cwd)
            local base_name = vim.fs.basename(cwd)
            local parent_base_name = vim.fs.basename(vim.fs.dirname(cwd))
            return parent_base_name .. '_' .. base_name .. '.md'
        end
    }

}
