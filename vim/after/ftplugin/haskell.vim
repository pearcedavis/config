setlocal tabstop=4
setlocal expandtab
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal shiftround
setlocal autoindent
setlocal nosmartindent

" multi-package repos (e.g. wai)
setlocal path+=*/
" match 'someFunc ::', 'data SomeThing', 'type SomeType'
setlocal define=^\\s*\\\(\\ze\\i\\+\\s*\\:\\:\\\|data\\\|type\\\)\\s*

" TODO build relevant package only (find parent cabal file?)
setlocal makeprg=stack\ build\ --fast
" TODO
" setlocal errorformat=%+A\ %#%f\ %#(%l\\\,%c):\ %m,%C%m

setlocal include=^import\\s*\\(qualified\\)\\?\\s*
" always append '.' to match foo.hs instead of foo/ dir
" (also remove leading '.' from suffixes)
setlocal includeexpr=substitute(v:fname,'\\.','/','g').'.'
setlocal suffixesadd=hs,lhs,hsc

" open in split window?
setlocal keywordprg=stack\ hoogle\ --\ --info
