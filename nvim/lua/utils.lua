local M = {}

-- u/Pocco81
local fn = vim.fn
function M.get_color(group, attr)
    return fn.synIDattr(fn.synIDtrans(fn.hlID(group)), attr)
end

return M
