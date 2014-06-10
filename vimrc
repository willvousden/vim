let mapleader=","
let maplocalleader="\\"

" Vundle stuff.
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" Which plugins do we want?

" Colours...
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'

let g:airline#extensions#tmuxline#enabled = 1
let g:tmuxline_powerline_separators = 0
let g:tmuxline_theme = "airline"
let g:tmuxline_preset = "full"
Plugin 'bling/vim-airline'
Plugin 'bling/vim-bufferline'
Plugin 'edkolev/tmuxline.vim'

" NERDTree stuff and TagList.
Plugin 'scrooloose/nerdtree'
Plugin 'taglist.vim'
Plugin 'sjl/gundo.vim'
let g:gundo_right=1
let g:NERDTreeWinPos="right"
let g:Tlist_Use_Right_Window=1

" Syntax plugins.
Plugin 'tmatilai/gitolite.vim'
Plugin 'zaiste/tmux.vim'
Plugin 'SimpylFold'
Plugin 'pangloss/vim-javascript'
Plugin 'lepture/vim-jinja'
if version < 704
    Plugin 'JulesWang/css.vim'
else
    Plugin 'cakebaker/scss-syntax.vim'
end

" Convenience plugins.
let g:space_no_search = 1
Plugin 'spiiph/vim-space'
Plugin 'ervandew/supertab'
Plugin 'IndentAnything'
Plugin 'matchit.zip'
Plugin 'christoomey/vim-tmux-navigator'

Plugin 'sjl/splice.vim'
Plugin 'msanders/snipmate.vim'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-surround'
Plugin 'sukima/xmledit'

call vundle#end()
filetype plugin indent on

" Colours (has to be done after vundle#end()).
let g:molokai_original=0
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
    if &t_Co > 16 || has("gui_running")
        " Only set a nice colour scheme if the term supports it.
        colorscheme solarized
    endif
endif

" Set bash-style autocomplete behaviour.
set wildmenu
set wildmode=list:longest

" Basic stuff.
set encoding=utf-8
set hidden
set vb
set ai
set background=dark
set foldmethod=syntax
set backspace=indent,eol,start
set modeline
set modelines=50

set history=50 " Keep 50 lines of command line history.
set ruler " Show the cursor position all the time.
set showcmd " Display incomplete commands.
set incsearch " Enable incremental searching.

set showmatch
set showmode
set scrolloff=3
set cursorline
set number
nmap <silent> <leader>l :set list!<CR>
set listchars=tab:▸·,eol:¬,trail:·,extends:«,precedes:»,nbsp:_

" White space stuff.
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Searches and stuff.
"nnoremap / /\v
"vnoremap / /\v
set magic
set smartcase
set ignorecase
set gdefault " Invert global subsitute behaviour.
nnoremap <silent> <leader>k :nohl<CR><C-l>

" Paste mode shortcut.
nnoremap <silent> <leader>p :set paste!<CR>

" Navigation.
map <Up> gk
map <Down> gj
map <PageUp> <C-u>
map <PageDown> <C-d>
imap <PageUp> <C-o><C-u>
imap <PageDown> <C-o><C-d>
nmap <C-b> g;
nmap <C-n> g,

" Disable automatic jump to next result on word search.
nmap <silent> * /\<<C-r><C-w>\><CR>N
nmap <silent> # ?\<<C-r><C-w>\><CR>N

" Replace word under cursor.
nmap <leader>S :%s/\<<C-r><C-w>\>/

" Search for/replace selection.
vmap <leader>s y/<C-r>"<CR>
vmap <leader>S y:%s/<C-r>"/

" Yank to end of line.
map <silent> Y y$

" Send previus yank to clipboard (via Clipper).
nmap <leader>y :call system('clip', @0)<CR>

" Session managment.
set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize

" Tag stuff.
let tlist_tex_settings='tex;b:bibitem;c:command;l:label'

" Mappings for editing and reloading vimrc.
map <leader>v :sp<CR>:e $MYVIMRC<CR><C-w>_
map <silent> <leader>V :source $MYVIMRC<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" Mappings for session managment.
map <leader>q :mksession! $HOME/.vimsession<CR>:exe ":echo 'Session saved!'"<CR>
map <leader>Q :source $HOME/.vimsession<CR>:exe ":echo 'Session loaded!'"<CR>

" Set backup and history things.
set dir=/tmp
set backupdir=/tmp
set backup

" Formatting options.
set textwidth=100
set formatoptions-=t
set formatoptions+=c " Auto-wrap comments.
set formatoptions+=r " Insert comment leader on <Enter> in insert mode.
set formatoptions+=o " Insert comment leader after "o" or "O"
set formatoptions+=q " Comment formatting with "gq".
set formatoptions+=l " Don't break long lines automatically.
if version >= 703
    set formatoptions+=j " Remove comment leader from joined lines.
endif

" Always enable status line.
set laststatus=2

if has("autocmd") && !exists("autocommands_loaded")
    let autocommands_loaded = 1

    " FIXME Verify this!
    autocmd BufReadPost * let [&tabstop, &softtabstop] = [&shiftwidth, &shiftwidth]

    " JavaScript stuff.
    let javaScript_fold=1
    autocmd BufRead,BufNewFile *.js set ft=javascript syntax=jquery

    " Sidebar mappings.
    autocmd VimEnter * nnoremap <silent> <Tab> :NERDTreeToggle<CR>
    autocmd VimEnter * nnoremap <silent> <S-Tab> :Tlist<CR>
    autocmd VimEnter * nnoremap <leader>g :GundoToggle<CR>

    " For all text files, set 'textwidth' to 80 characters.
    autocmd FileType text,tex setlocal textwidth=80 formatoptions+=t

    autocmd Filetype html,xml,csl source ~/.vim/scripts/closetag.vim

    " Remember positions in files with some Git-specific exceptions.
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$")
        \     && expand("%") !~ "COMMIT_EDITMSG"
        \     && expand("%") !~ "ADD_EDIT.patch"
        \     && expand("%") !~ "addp-hunk-edit.diff"
        \     && expand("%") !~ "git-rebase-todo" |
        \     exe "normal! g`\"" |
        \ endif

    " No line numbers when viewing help.
    autocmd FileType help set nonumber

    " Enter selects the current tag and backspace goes back.
    autocmd FileType help nnoremap <CR> <C-]>
    autocmd FileType help nnoremap <buffer><BS> <C-T>

    " Stuff for 7.0.3.
    if version >= 703
        " Automatically enable relative numbering.
        set relativenumber
        autocmd BufReadPost * set relativenumber
        autocmd BufNewFile * set relativenumber
        autocmd BufWinEnter * set relativenumber
    endif
else
    " Just settle for having normal autoindenting.
    set autoindent
endif

" Easy saving when lacking sudo permissions!
nnoremap <leader>W :w !sudo tee %<CR>

" Easy selection!
nnoremap <leader>A ggVG

" Easy wrap toggling!
set linebreak
nnoremap <leader>w :set nowrap!<CR>

"" Tab navigation mappings.
"nmap <silent> <C-j> :bN!<CR>
"nmap <silent> <C-k> :bn!<CR>
"imap <silent> <C-j> <C-o>:bN!<CR>
"imap <silent> <C-k> <C-o>:bn!<CR>

" Folding mappings.
nnoremap <silent> <C-LeftMouse> <LeftMouse>za

" Word search mappings.
nnoremap <silent> <S-LeftMouse> <LeftMouse>*

" Camel/Pascal case identifier navigation.
nnoremap <silent> <C-Left> :call search('\<\<Bar>\u', 'bW')<CR>
nnoremap <silent> <C-Right> :call search('\<\<Bar>\u', 'W')<CR>
inoremap <silent> <C-Left> <C-o>:call search('\<\<Bar>\u', 'bW')<CR>
inoremap <silent> <C-Right> <C-o>:call search('\<\<Bar>\u', 'W')<CR>

" When deleting lines or words, insert an undo break first to avoid loss.
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>


" Enable mouse support.
if has('mouse')
    set mouse=a
    if &term =~ '^screen'
        " Enable better mouse support.
        set ttymouse=xterm2
    endif
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.  Only define it when not
" defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif
