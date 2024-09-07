"tabs
setlocal expandtab "replace tabs with spaces
setlocal tabstop=4 "number of spaces to use
setlocal shiftwidth=4 "number of spaces used for indentation
setlocal softtabstop=4 " backspace treats 4 spaces as a tab
setlocal autoindent
setlocal nosmartindent

let g:python_indent = {}
let g:python_indent.open_paren = 'shiftwidth()'
let g:python_indent.nested_paren = 'shiftwidth()'
let g:python_indent.continue = 'shiftwidth() * 2'
let g:python_indent.closed_paren_align_last_line = v:false

"folding
setlocal foldmethod=indent
setlocal foldlevel=99

setlocal formatprg=ruff\ format\ -

setlocal path+=src

let python_highlight_all=1

let b:ale_fixers = ['isort', 'ruff_format']
let b:ale_linters = ['ruff', 'mypy']
