set clipboard=unnamedplus,unnamed,autoselect

" Prevents vim from behaving like vi
set nocp

" Enable syntax highlighting
if has("syntax")
    syntax on
endif

map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-h> <C-w>h

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ','
let g:mapleader = ','

" Fast saving
nmap <leader>w :w!<cr>

" Fast quit
nmap <leader>q :q<cr>
nmap <leader>Q :q!<cr>

" Fast save and quit
" nmap <leader>wq :wq<cr>

" Fast quit all windows
nmap <leader>a :qa<cr>
nmap <leader>A :qa!<cr>

" Toggle paste mode on and off
map <leader>p :setlocal paste!<cr>

" Add a blank line above and below, respectively
nmap <leader>o o<Esc>
nmap <leader>O O<Esc>

" Turn off highlight after a search is done
nmap <leader>h :noh<cr>

" Add PDB above current line
nmap <leader>db Oimport pdb; pdb.set_trace()<Esc>
nmap <leader>pdb oimport pdb; pdb.set_trace()<Esc>

" Show tag list
nmap <leader>t :tselect <C-r><C-w><cr>

" Change two horizontally split windows to vertically split windows
nmap <leader>H <C-w>t<C-w>H<cr>

" Vertical split vim
nmap <leader>v :vsplit<cr>

" Reveal and Close all folds
nmap <leader>r zR
nmap <leader>m zM


nmap <leader>e :Explore<Esc>

" Set to auto read when a file is changed from the outside
set autoread

" Show command?
set showcmd

" Be smart about cases while searching
set smartcase

" Makes search act like search in modern browsers
set incsearch

" Highlight search results
set hlsearch

" Show matching brackets when text indicator is over them
set showmatch

" Ignore case while searching
set ignorecase

" Always show the ruler
set ruler

" Always show line numbers
set number

" Use spaces instead of tabs
set expandtab

" 1 tab = 4 spaces
set shiftwidth=4
set tabstop=4
"
" Enable filetype plugins
if has("autocmd")
    filetype plugin indent on
endif

" If the filetype is html, javascript or css set indentation to 2 spaces
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2
" Fold only Python files
autocmd FileType python setlocal foldmethod=indent

" Get backspace to work normally, instead of escaping insert mode and
" moving backward
set backspace=2

" Enable use of the mouse
" set mouse=a
" The above option does not allow you to select text from inside vim and paste
" it outside

" Enable wildmenu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction
" set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ \ Column:\ %c
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ \ \ Line:\ %l\ \ \ Column:\ %c


" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


colorscheme koehler

nnoremap <Tab> <Esc>
vnoremap <Tab> <Esc>gV
onoremap <Tab> <Esc>
inoremap <Tab> <Esc>`^
inoremap <S><Tab> <Tab>

set cursorline

set modeline
set ls=2

" Highlight extra whitespace at the end of a line
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Strip trailing whitespace
map <leader>s :%s/\s\+$//<cr>

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" Set fzf as a fuzzy finder for Vi
set rtp+=~/.fzf
map <leader>f :FZF -m<cr>
" map <leader>F :v<cr>:FZF<cr>

set tags=tags;/

noremap <leader>E :edit!<cr>
