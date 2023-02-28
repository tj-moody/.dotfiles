require("mason").setup {}
require("mason-lspconfig").setup {
    ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "bashls",
        "clangd",
        "cssls",
        "html",
        "jsonls",
        "jdtls",
        "tsserver",
        "marksman",
        "pyright",
        "vimls",
    },
    automatic_installation = false,
}
