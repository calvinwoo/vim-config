if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'morhetz/gruvbox'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-sleuth'
Plug 'sheerun/vim-polyglot'
"Plug 'lifepillar/vim-mucomplete'
"Plug 'w0rp/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'wincent/terminus'

" Add plugins to &runtimepath
call plug#end()

""""""
" General VIM Settings

" Font
set guifont=Menlo:h16

" Pane
set splitbelow
set splitright

" Cursor Highlight Target
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline cursorcolumn

" Highlight all search results
set hlsearch

" Always show status line
set laststatus=2

" Color Scheme
syntax enable
set termguicolors
" set background=dark
set background=light
colorscheme gruvbox

" Local vimrc
set exrc
set secure

set undofile
set ruler

""""""
" General Key Mappings
"

" Map leader
let mapleader = "\<Space>"

" Pane actions
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <Leader>v :vsplit<CR>

""""""

" Indent and File Settings
set autoindent
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set smarttab

set number
set ignorecase
set smartcase
set backspace=indent,eol,start

""""""
" CTRLP
let g:ctrlp_working_path_mode = ''
" let g:ctrlp_custom_ignore = '\v[\/](node_modules|bower_components|build|dev|lending/dist|jestCache|coverage)|(\.(swp|git))$'

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

nnoremap <Tab> :CtrlP<CR>
nnoremap <S-Tab> :CtrlPBuffer<CR>

""""""
" Omnicomplete
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Completion for relative file
" https://superuser.com/questions/604122/vim-file-name-completion-relative-to-current-file
:autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
:autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

""""""
" MuComplete
let g:mucomplete#enable_auto_at_startup = 1
set completeopt+=menuone
set completeopt+=noselect
set completeopt+=noinsert

""""""
" Coc
let g:coc_global_config="$HOME/.config/coc/coc-settings.json"

""""""
" FileType settings
autocmd FileType html setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType css setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType python setlocal expandtab
autocmd Filetype gitcommit setlocal spell textwidth=72
au BufRead *.md setlocal spell

au BufNewFile,BufRead *.handlebars set filetype=html
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.jsx
au BufNewFile,BufRead *.mcss set filetype=css

""""""
" Ale

"let g:ale_fixers = {
"\   'javascript': ['prettier'],
"\   'typescript': ['tslint', 'prettier'],
"\   'typescript.jsx': ['tslint', 'prettier']
"\}

let g:ale_linters = {
\   'typescript': ['tsserver', 'typecheck', 'tslint'],
\   'typescript.jsx': ['tsserver', 'typecheck', 'tslint'],
\   'python': ['flake8']
\}

" let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_python_auto_pipenv = 1

nnoremap <Leader>af :ALEGoToDefinition<CR>
nnoremap <Leader>ad :ALEDetail<CR>
nnoremap <Leader>ae :ALEFindReferences<CR>
nnoremap <Leader>ai :ALEHover<CR>
nmap <Leader>aj :ALENext<CR>
nmap <Leader>ak :ALEPrevious<CR>
