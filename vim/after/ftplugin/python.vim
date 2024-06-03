"tabs
setlocal expandtab "replace tabs with spaces
setlocal tabstop=4 "number of spaces to use
setlocal shiftwidth=4 "number of spaces used for indentation
setlocal softtabstop=4 " backspace treats 4 spaces as a tab
setlocal autoindent
setlocal nosmartindent

"folding
setlocal foldmethod=indent
setlocal foldlevel=99

"format code on write
" autocmd BufWritePre <buffer> Black
" let g:autopep8_ignore="E501"
" let g:autopep8_disable_show_diff=1

setlocal formatprg=black\ --quiet\ -

" gridshare
setlocal path+=src

let python_highlight_all=1

let b:ale_fixers = ['isort', 'black']
let b:ale_linters = ['pyflakes', 'mypy']
