require('projtasks').setup {
    terminal_config = {
        direction = "vertical",
    },
    output = "terminal",
    defaults = {
        ["rust"] = {
            ["build"] = [[cargo build]],
            ["run"] = [[cargo run]],
            ["test"] = [[cargo nextest run]],
        }
    }
}
