filetype plugin indent on

" fix truecolor support when in tmux
if !empty($TMUX)
	" The "^[" is a single character. You enter it by pressing Ctrl+v and then ESC.
	set t_8f=[38;2;%lu;%lu;%lum
	set t_8b=[48;2;%lu;%lu;%lum
else
	" show git info when not in tmux
	" set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P
endif
" enable truecolor
set termguicolors

syntax on
colorscheme monokai

" show matching brackets
set showmatch

" show line numbers
" set number
set relativenumber

" statusline
set laststatus=2
set statusline=%<%F\ %h%m%r%=%-14.(%l,%c%V%)\ %P

" have filename in titlebar
set title

" better searching
set incsearch
set hlsearch
set ignorecase
set smartcase

" remember position of file
if has("autocmd")
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
		\| exe "normal! g`\"" | endif
endif

" allow buffer switch without saving
set hidden

" keep swap files out of the way
" set directory=~/.vim/swap

" useful remaps
let mapleader = "\<Space>"
nnoremap <Leader>j :bp<CR>
nnoremap <Leader>k :bn<CR>
nnoremap <Leader>l <C-W><C-W>
" nnoremap <Leader>h :noh<CR>
nnoremap <Leader>h :set hlsearch!<CR>
nnoremap <Leader>c :set cuc!<CR>
nnoremap <Leader>v :vsplit<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>x :bp<bar>bd#<CR>
nnoremap <Leader>e :CtrlPMixed<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>ff :ALEFix<CR>
" nnoremap <Leader>b :ls<CR>:b<Space>
nnoremap <Leader>gs :Git<CR>
nnoremap <Leader>gd :Gdiffsplit<CR>
nnoremap <Leader>r :redraw!<CR>
nnoremap <Leader>t :NERDTreeToggle<CR>
inoremap <C-L> <C-X><C-L>
nnoremap qq <NOP>
" centre search results
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
" paste over selection without yanking
vnoremap p "_dP
vnoremap c "_c
nnoremap c "_c
" clipboard copy and paste
" vnoremap <C-C> :w !xsel -i -b<CR><CR>
" nnoremap <C-V> :r !xsel -o -b<CR>
vnoremap <C-C> :w !wl-copy <CR><CR>
nnoremap <C-V> :r !wl-paste<CR>

" normal tab complete
set wildmode=longest,list,full
set wildmenu
set wildignore+=*/.git/*
set wildignore+=*/node_modules/*,*/.emitted/*
set wildignore+=*/__pycache__/*,*.pyc,*.pyo,*/venv/*
set wildignore+=*/.cache/*

" default to regex search (not fuzzy)
let g:ctrlp_regexp = 1
" list untracked files as well, such as new ones not added yet
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files && git ls-files --others --exclude-standard']
let g:ctrlp_use_caching = 0
let g:ctrlp_mruf_exclude = '.git/COMMIT_EDITMSG'
let g:ctrlp_match_current_file = 1
let g:ctrlp_mruf_relative = 1

let g:coc_disable_startup_warning = 1
let g:coc_start_at_startup = 0

let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0

" let g:jedi#auto_initialization = 0
let g:jedi#goto_command = "gt"
let g:jedi#goto_assignments_command = ""
let g:jedi#goto_stubs_command = ""
let g:jedi#goto_definitions_command = ""
" let g:jedi#documentation_command = "K"
let g:jedi#usages_command = ""
" let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = ""
let g:jedi#rename_command_keep_name = ""

" set text width for wrapping comments with gq
set textwidth=80
" disable autowrap (still autowraps in comment blocks)
set formatoptions-=t

set path-=/usr/include
" gridshare
" set path+=shared,src

" use git-grep/ag for searching and file listing
if filereadable(".git/config")
	set grepprg=git\ grep\ -n\ --column
	set grepformat=%f:%l:%c:%m
elseif executable('ag')
	set grepprg=ag\ --vimgrep\ -s
	set grepformat=%f:%l:%c:%m
endif


" command -nargs=+ -complete=file -bar Grep silent! grep! <args>|cwindow|redraw!
command! -nargs=+ -complete=file Grep execute 'silent grep! <args>' | cwindow | redraw!
nnoremap \ :Grep<SPACE>

" binding to search files for word under cursor (also sets the buffer
" search to that word for highlighting)
nnoremap <Leader>ss /\<<C-R><C-W>\><CR><C-O>:Grep -w -F "<C-R><C-W>" <CR>

command! -nargs=* Make execute 'silent make! <args>' | cwindow | redraw!
