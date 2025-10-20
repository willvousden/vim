" Don't comply with PEP8.
setlocal textwidth=100

lua vim.treesitter.start()
highlight link @type.builtin Type
highlight link @function.builtin Identifier
