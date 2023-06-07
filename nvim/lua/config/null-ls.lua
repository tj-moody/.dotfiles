local null_ls = require('null-ls')
local sources = {
    -- python
    null_ls.builtins.formatting.black.with({
        extra_args = { "--line-length=120" }
    }),
    null_ls.builtins.formatting.isort,
}

null_ls.setup({ sources = sources })
