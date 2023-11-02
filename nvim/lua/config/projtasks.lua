require('projtasks').setup {
    direction = "vertical",
    defaults = {
        ["rust"] = {
            ["build"] = [[cargo build]],
            ["run"] = [[cargo run]],
            ["test"] = [[cargo nextest run]],
        }
    }
}
