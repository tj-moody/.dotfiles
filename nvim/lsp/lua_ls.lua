return {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim", "P", "safe_require" },
                    disable = { "lowercase-global" },
                },
                hint = {
                    enable = true,
                    arrayIndex = "Disable",
                },
                workspace = {
                    checkThirdParty = false,
                    library = { vim.env.VIMRUNTIME },
                    -- Source all of `runtimepath`
                    -- library = vim.api.nvim_get_runtime_file("", true), -- WARN: Very slow
                    version = "LuaJIT",
                },
            },
        },
    }

