" Activate auto filetype detection
syntax on
filetype plugin indent on
filetype on
filetype plugin on
syntax enable


" http://stackoverflow.com/questions/58774/how-do-you-paste-multiple-tabbed-lines-into-vi
set pastetoggle=<F6>    " F6 toggles paste mode
set ignorecase          " Don't care about case...
set smartcase		" ... unless the query contains upper case characters
set autoindent		" Enable automatic indenting for files with ft set
set nowrap		" No fake carriage returns
set showcmd		" Show command in statusline as it's being typed
set showmatch		" Jump to matching bracket
set ruler		" Show row,col %progress through file
set laststatus=2	" Always show filename (2 is always)
set hidden	    	" Let us move between buffers without writing them.  Don't :q! or :qa! frivolously!
set softtabstop=4	" Vim sees 4 spaces as a tab
set shiftwidth=4	" < and > uses spaces
set expandtab		" Tabs mutate into spaces
set foldmethod=indent	" Default folding
set backspace=indent,eol,start  " Make backspace work like other editors.
" set tabstop=4		" 4-space indents
" set smarttab		" <TAB> width determined by shiftwidth instead of tabstop.  
set fileencoding=utf8
set fileencodings=utf8,cp1251
set hlsearch            " highlight search terms
set incsearch           " show search matches as you type

" http://nvie.com/posts/how-i-boosted-my-vim/
set nobackup            " do not write backup and swap files
set noswapfile


au BufNewFile,BufRead *.txt setf text
" http://go-lang.cat-v.org/text-editors/vim/
au BufRead,BufNewFile *.go set filetype=go
au FileType text set wrap 


" abbreviate seting rus for keyboard
abb rru set keymap=rus
abb uuk set keymap=ukr


" http://stackoverflow.com/questions/563616/vim-and-ctags-tips-and-tricks
" C-\ - Open the definition in a new tab
" A-] - Open the definition in a vertical split
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>


" F-keys mappings

" insert current date and time
nnoremap <F2> "=strftime("%c")<CR>P
inoremap <F2> <C-R>=strftime("%c")<CR>
nnoremap <F3> :call Browser ()<CR>
nnoremap <F4> :call Evince()<CR>
nnoremap <F5> :GundoToggle<CR>
nmap <F8> :TagbarToggle<CR>
nmap <F9> :NERDTreeFind<CR>
nmap <F10> :NERDTreeToggle<CR>
nnoremap <F12> :set go-=m go-=T go-=l go-=L go-=r go-=R go-=b go-=F<CR> :set lines=999 columns=999 <CR>


" change local directory to file directory
abb flcd lcd %:p:h

let g:SaveUndoLevels = &undolevels
let g:BufSizeThreshold = 1000000
if has("autocmd")
  " Store preferred undo levels
  au VimEnter * let g:SaveUndoLevels = &undolevels
  " Don't use a swap file for big files
  au BufReadPre * if getfsize(expand("<afile>")) >= g:BufSizeThreshold | setlocal noswapfile | endif
  " Upon entering a buffer, set or restore the number of undo levels
  au BufEnter * if getfsize(expand("<afile>")) < g:BufSizeThreshold | let &undolevels=g:SaveUndoLevels | hi Cursor term=reverse ctermbg=black guibg=black | else | set undolevels=-1 | hi Cursor term=underline ctermbg=red guibg=red | endif
endif

set vb t_vb=

set foldignore=''

" Quickly edit/reload the vimrc file
" http://nvie.com/posts/how-i-boosted-my-vim/
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" clear search highlighting with <leader>/
nmap <silent> <leader>/ :nohlsearch<CR>


" plugin settings

" ctrlp

let g:ctrlp_custom_ignore = {'file': '\v(\.pyc|\.swp)$'}

" pathogen

call pathogen#infect()
call pathogen#helptags()

" NERDTree

" ignore in NERDTree files that end with pyc and ~
let NERDTreeIgnore=['\.pyc$', '\~$']

" solarized (it should be at the end)

if has('gui_running')
    colorscheme solarized
    set background=light
else
    set background=dark
endif

se guioptions=agim

if has("gui_macvim")
    source ~/.vim/mvimrc
endif

" python
autocmd FileType python setlocal et sta sw=4 sts=4
autocmd FileType python setlocal foldmethod=indent
set foldlevel=99

" pyflakes
" do not use quickfix with pyflakes
let g:pyflakes_use_quickfix = 0

" flake8
" ignore white space of empty line warning for flake8
let g:flake8_ignore="W293"
let g:flake8_max_line_length=99
" autorun flake8 on save
autocmd BufWritePost *.py call Flake8()


