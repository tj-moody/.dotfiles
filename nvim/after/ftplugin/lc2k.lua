vim.bo.tabstop = 8
vim.bo.expandtab = false

vim.keymap.set("n", "<leader>df", function()
    local before = vim.fn.sha256(table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n"))

    vim.cmd.norm([[mf]])
    vim.cmd([[%s/^\(add\|nor\|lw\|sw\|jalr\|beq\|noop\|halt\|\.fill\)/ \1/e]])
    vim.cmd([[silent! %s/^\([^;]*\)/\=substitute(submatch(1), '[\t ]\+', '\t', 'g')/]])
    vim.cmd([[nohlsearch]])
    vim.cmd.norm([[`f`]])

    local after = vim.fn.sha256(table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n"))
    if before == after then
        vim.bo.modified = false
    end
end, { buffer = true, remap = false, desc = "Format an lc2k file (must have `;` prepended comments)" })
