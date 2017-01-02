" Make this configuration portable...
" Set system default runtime path.
let &runtimepath = printf('%s/vimfiles,%s,%s/vimfiles/after', $VIM, $VIMRUNTIME, $VIM)

" Detect where this vim config is (resolving symlinks).
let g:portable = fnamemodify(resolve(expand('<sfile>')), ':p:h')

" Now set runtime path accordingly.
let &runtimepath = printf('%s,%s,%s/after', g:portable, &runtimepath, g:portable)

let mapleader=","
let maplocalleader="\\"

" Vundle stuff.
set nocompatible
filetype off
let s:vundle = printf('%s/bundle', g:portable)
let &runtimepath = printf('%s,%s/Vundle.vim', &runtimepath, s:vundle)
call vundle#begin(s:vundle)
Plugin 'willvousden/Vundle.vim'

" Which plugins do we want?

" Local vimrc files.
Plugin 'embear/vim-localvimrc'

" Colours...
Plugin 'altercation/vim-colors-solarized'

"let g:airline#extensions#tmuxline#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#hunks#non_zero_only = 1
"let g:tmuxline_powerline_separators = 0
"let g:tmuxline_theme = "airline"
"let g:tmuxline_preset = "full"
"let g:bufferline_rotate = 1
"let g:bufferline_fixed_index = -1
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Plugin 'bling/vim-bufferline'
"Plugin 'edkolev/tmuxline.vim'

" Some buffer mappings.
nmap <leader>t :let &showtabline=(&showtabline + 1) % 3<cr>:echo "showtabline ="&showtabline<cr>
nmap <leader>b :b#<cr>

" Destroy the current buffer without closing the split.
nmap <leader>d :bp<bar>sp<bar>bn<bar>bd<cr>

" NERDTree stuff and TagList.
Plugin 'scrooloose/nerdtree'
Plugin 'taglist.vim'
Plugin 'sjl/gundo.vim'
let g:gundo_right=1
let g:NERDTreeWinPos="right"
let g:Tlist_Use_Right_Window=1

" LaTeX stuff.
Plugin 'LaTeX-Box-Team/LaTeX-Box'

" Syntax plugins.
Plugin 'nginx.vim'
Plugin 'slim-template/vim-slim'
au BufRead,BufNewFile nginx.conf if &ft == '' | setfiletype nginx | endif
Plugin 'jquery'
Plugin 'tmatilai/gitolite.vim'
Plugin 'zaiste/tmux.vim'

" Python things.  Switch off folding from the python-syntax plugin; let SimpylFold handle it.
let python_folding=0
let python_highlight_all=1
Plugin 'hdima/python-syntax'
Plugin 'hynek/vim-python-pep8-indent'
let g:SimpylFold_docstring_preview=1
Plugin 'tmhedberg/SimpylFold'

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
Plugin 'tommcdo/vim-exchange'
Plugin 'ervandew/supertab'
Plugin 'IndentAnything'
Plugin 'matchit.zip'
Plugin 'christoomey/vim-tmux-navigator'

" Plugin 'Valloric/YouCompleteMe'

"Plugin 'sjl/splice.vim'
Plugin 'tpope/vim-git'
"Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
let NERDSpaceDelims = 1
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-surround'
Plugin 'sukima/xmledit'

" " Snippet stuff.
" Plugin 'MarcWeber/vim-addon-mw-utils'
" Plugin 'tomtom/tlib_vim'
" Plugin 'garbas/vim-snipmate'
" Plugin 'honza/vim-snippets'

call vundle#end()
filetype plugin indent on

" Colours (has to be done after vundle#end()).
set background=dark
let g:molokai_original=0
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
    if &t_Co >= 16 || has("gui_running")
        " Only set a nice colour scheme if the term supports it.
        silent! colorscheme solarized
    endif
endif

"" Fix buggy colours in gitgutter.
"hi clear SignColumn
"call gitgutter#highlight#define_highlights()

" Set bash-style autocomplete behaviour.
if has("wildmenu")
    set wildmenu
    set wildmode=longest,list
    set wildignore+=*.a,*.o
    set wildignore+=.DS_store,.git,.hg,.svn
    set wildignore+=*~,*.swp,*.tmp

    if has("wildignorecase")
        set wildignorecase
    endif
endif

" Basic stuff.
set encoding=utf-8
set hidden
set visualbell
set autoindent
set foldmethod=syntax
set foldopen-=block
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
set listchars=tab:▸·,eol:¬,trail:·,extends:«,precedes:»,nbsp:_

nmap <silent> <leader>u :syntax sync fromstart<CR>:redraw!<CR>
nmap <silent> <leader>l :set list!<CR>

" White space stuff.
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" More intuitive split behaviour.
set splitbelow
set splitright

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
set pastetoggle=<F6>

" Disable annoying ex mode key.
nnoremap Q <nop>

" It's really annoying when I type :W accidentally because I don't lift my finger off SHIFT quickly
" enough.
if !exists(":W")
    command W :w
endif

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
nmap <leader>y :call system('clip', @0)<CR>:exe ":echo 'Anonymous buffer sent to Clipper.'"<CR>

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
set dir=~/.tmp
set backupdir=~/.tmp
set backup

" Formatting options.
set textwidth=100
set formatoptions-=t " Don't wrap all lines.
set formatoptions+=c " Auto-wrap comments.
set formatoptions+=r " Insert comment leader on <Enter> in insert mode.
set formatoptions+=o " Insert comment leader after "o" or "O"
set formatoptions+=q " Comment formatting with "gq".
set formatoptions+=l " Don't break long lines automatically.
if has('patch-7.3.541')
    set formatoptions+=j " Remove comment leader from joined lines.
endif
if exists('&breakindent')
    set breakindent
end

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

    " Comply with PEP8.
    autocmd FileType python setlocal textwidth=79

    " Make sure SimpylFold works properly.
    autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
    autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<

    " Highlight "end" column.
    if exists('&colorcolumn')
        autocmd FileType * let &colorcolumn=&textwidth+1
    endif

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

    if exists('&relativenumber')
        " Automatically enable relative numbering.
        set relativenumber
        autocmd BufReadPost * set relativenumber
        autocmd BufNewFile * set relativenumber
        autocmd BufWinEnter * set relativenumber
    endif
endif

" Easy saving when lacking sudo permissions!
nnoremap <leader>W :w !sudo tee %<CR>

" Easy selection!
nnoremap <leader>A ggVG

" Easy wrap toggling!
set linebreak
nnoremap <leader>w :set nowrap!<CR>

" Folding mappings.
nnoremap <silent> <CR> za
nnoremap <silent> <leader><CR> zA
nnoremap <silent> <C-LeftMouse> <LeftMouse>za

" Remapping <CR> can cause some problems in the command line and quickfix windows, so work around
" this clash:
autocmd CmdwinEnter * nnoremap <CR> <CR>
autocmd BufReadPost quickfix nnoremap <CR> <CR>

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
    if has('mouse_sgr')
        " Enable mouse past 223 columns!
        set ttymouse=sgr
    else
        if &term =~ '^screen'
            " Enable better mouse support.
            set ttymouse=xterm2
        endif
    endif
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.  Only define it when not
" defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif
