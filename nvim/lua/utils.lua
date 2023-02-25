local M = {}

-- u/Pocco81
local fn = vim.fn
function M.getcolor()
    local function get_color(group, attr)
        return fn.synIDattr(fn.synIDtrans(fn.hlID(group)), attr)
    end
end

return M
