require('alternate-toggler').setup {
    alternates = {
        ["true"] = "false",
        ["True"] = "False",
        ["TRUE"] = "FALSE",
        ["Yes"] = "No",
        ["YES"] = "NO",
        ["1"] = "0",

        -- Use logical opposites for comparisons;
        -- > && <=, for example, are complementary,
        -- and encompass all cases
        ["<"] = ">=",
        [">"] = "<=",
        -- [">="] = "<",
        -- ["<="] = ">",

        -- Alternatively,
        -- ["<"] = ">",

        ["("] = ")",
        ["["] = "]",
        ["{"] = "}",
        ['"'] = "'",
        ['""'] = "''",
        ["+"] = "-",
        ["==="] = "!==",
        ["=="] = "!=",
        -- ["~="] = "==",
        ["++"] = "--",
        ["+="] = "-=",
        ["&&"] = "||",
    }
}
