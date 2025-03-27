setlocal expandtab
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal autoindent
setlocal nosmartindent

" if (coc#rpd#ready())
" nnoremap <buffer> <silent> gt <plug>(coc-definition)
" nnoremap <buffer> <silent> K :call CocActionAsync('definitionHover')<CR>
nnoremap <buffer> <silent> gt :ALEGoToDefinition<CR>
nnoremap <buffer> <Leader>fi :ALEOrganizeImports<CR>

" nnoremap <buffer> K :ALEHover<CR>
" HACK to trigger CursorHold event which updates cmd line with info about type
" under the cursor. Avoids ALEHover opening a new window.
nnoremap <buffer> K <CursorHold>

let b:ale_fixers = ['eslint', 'prettier']
let b:ale_linters = ['tsserver', 'eslint']

" let g:ale_typescript_tsserver_executable = 'tsserver'

setlocal matchpairs+=<:>

setlocal include=\\sfrom\\s
" setlocal define=\\\(const\\\|type\\\)\\s
setlocal define=^\\s*\\(export\\)\\?\\s*\\(const\\\|type\\\|interface\\)

" gridshare
" setlocal path+=shared

setlocal formatexpr=
setlocal formatprg=npx\ prettier\ --parser\ typescript

setlocal makeprg=tsc\ -b
setlocal errorformat=%+A\ %#%f\ %#(%l\\\,%c):\ %m,%C%m

" always append '.' so we match foo.ts instead of the foo/ dir
" (remove '.' from suffixes to check as well)
setlocal includeexpr=simplify(v:fname.'.')
setlocal suffixesadd=ts,d.ts,tsx,js,jsx,cjs,mjs,json
