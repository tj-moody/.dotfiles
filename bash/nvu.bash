#!/opt/homebrew/bin/bash

 nvim +"lua require('bufferline').setup({options={always_show_bufferline = false}})" +"set nonumber" +"set norelativenumber" +"lua require('lazy').sync()" +"lua vim.fn.input('Exit?')" +qa
