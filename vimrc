" Make this configuration portable...
" Set system default runtime path.
let &runtimepath = printf('%s/vimfiles,%s,%s/vimfiles/after', $VIM, $VIMRUNTIME, $VIM)

" Detect where this vim config is (resolving symlinks).
let g:portable = fnamemodify(resolve(expand('<sfile>')), ':p:h')

" Now set runtime path accordingly.
let &runtimepath = printf('%s,%s,%s/after', g:portable, &runtimepath, g:portable)

let mapleader=","
let maplocalleader="\\"

set nocompatible
call plug#begin(printf('%s/plugged', g:portable))

" ALE!
Plug 'dense-analysis/ale'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

" Which plugins do we want?

" Local vimrc files.
Plug 'embear/vim-localvimrc'

" Colours...
Plug 'romainl/flattened'

" CtrlP!
Plug 'ctrlpvim/ctrlp.vim'
set wildignore+=*/tmp/*
set wildignore+=*/build/*
set wildignore+=*/node_modules/*
set wildignore+=*/__pycache__/*
set wildignore+=*.so
set wildignore+=*.o
set wildignore+=*.class
set wildignore+=*.swp
set wildignore+=*.pyc
set wildignore+=*.pyc

"let g:airline#extensions#tmuxline#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#hunks#non_zero_only = 1
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" let g:tmuxline_powerline_separators = 0
" let g:tmuxline_theme = "airline"
" let g:tmuxline_preset = "full"
" Plug 'edkolev/tmuxline.vim'

" Some buffer mappings.
nmap <leader>t :let &showtabline=(&showtabline + 1) % 3<cr>:echo "showtabline ="&showtabline<cr>
nmap <leader>b :b#<cr>

" Destroy the current buffer without closing the split.
nmap <leader>d :bp<bar>sp<bar>bn<bar>bd<cr>

" NERDTree stuff and TagList.
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'majutsushi/tagbar'
let g:NERDTreeWinPos="right"
let g:NERDTreeMinimalUI=1
let g:NERDTreeIgnore = ['\.pyc$', '__pycache__$']
nnoremap <leader>n :NERDTreeFocus<cr>

Plug 'sjl/gundo.vim'
let g:gundo_right=1
let g:gundo_return_on_revert=0
if has('python3')
    let g:gundo_prefer_python3 = 1
endif

" White space stuff.
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
Plug 'tpope/vim-sleuth'

" LaTeX stuff.
let g:tex_flavor = 'latex'
Plug 'lervag/vimtex'

" Syntax plugins.
Plug 'chr4/nginx.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'bfrg/vim-cpp-modern'
Plug 'lifepillar/pgsql.vim'
Plug 'slim-template/vim-slim'
Plug 'zaiste/tmux.vim'
Plug 'udalov/kotlin-vim'
Plug 'pangloss/vim-javascript'
Plug 'lepture/vim-jinja'
Plug 'HerringtonDarkholme/yats.vim'

" Python things.  Switch off folding from the python-syntax plugin; let SimpylFold handle it.
let g:python_highlight_all=1
Plug 'vim-python/python-syntax'
Plug 'hynek/vim-python-pep8-indent'
let g:SimpylFold_docstring_preview=1
Plug 'tmhedberg/SimpylFold'

" CSS.
Plug 'ap/vim-css-color'
Plug 'hail2u/vim-css3-syntax'
if version < 704
    Plug 'JulesWang/css.vim'
else
    Plug 'cakebaker/scss-syntax.vim'
end

" FastFold configuration.
Plug 'Konfekt/FastFold'
nmap zuz <Plug>(FastFoldUpdate)
let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes = ['x', 'X', 'a', 'A', 'o', 'O', 'c', 'C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']

" Convenience plugins.
let g:SuperTabDefaultCompletionType = '<c-n>'
Plug 'tommcdo/vim-exchange'
Plug 'ervandew/supertab'
Plug 'andymass/vim-matchup'
Plug 'christoomey/vim-tmux-navigator'
Plug 'kana/vim-fakeclip'

Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
let NERDSpaceDelims = 1
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'sukima/xmledit'

call plug#end()

" call deoplete#custom#source('ale', 'dup', v:true)
call deoplete#custom#option('sources', { '_': ['ale'], })

let g:ale_linters = {
\   'go': ['gopls'],
\}

" Colours.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch

    " Only set a nice colour scheme if the term supports it.
    if &t_Co >= 16 || has("gui_running")
        silent! colorscheme flattened_dark
    endif
endif

" Tell Vim that shell files should be interpreted as Bash by default.
let g:is_bash=1

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
set copyindent " Copy the indentation from the previous line; e.g., tabs and spaces.
set cinoptions=(0 " Correct line continuation indentation inside brackets.
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

" More intuitive split behaviour.
set splitbelow
set splitright

" Searches and stuff.
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

" Folding mappings.
nnoremap <silent> <CR> za
nnoremap <silent> <leader><CR> zA
nnoremap <silent> <C-LeftMouse> <LeftMouse>za

if has("autocmd") && !exists("autocommands_loaded")
    let autocommands_loaded = 1

    " Remapping <CR> can cause some problems in the command line and quickfix windows, so work around
    " this clash:
    autocmd CmdwinEnter * nnoremap <CR> <CR>
    autocmd BufReadPost quickfix nnoremap <CR> <CR>

    " Allow for tab-local working directories.
    autocmd TabEnter * if exists("t:wd") | exe "cd " . t:wd | endif
    autocmd TabLeave * let t:wd = getcwd()

    " Vim has a habit of clearing the clipboard on exit.  Undo this stupid behaviour.
    autocmd VimLeave * call system("xsel -ib", getreg("+"))

    " FIXME Verify this!
    autocmd BufReadPost * let [&tabstop, &softtabstop] = [&shiftwidth, &shiftwidth]

    " Sidebar mappings.
    autocmd VimEnter * nnoremap <silent> <Tab> :NERDTreeToggle<CR><c-w>=
    autocmd VimEnter * nnoremap <silent> <S-Tab> :TagbarToggle<CR>
    autocmd VimEnter * nnoremap <leader>g :GundoToggle<CR>

    " Make sure SimpylFold works properly.
    autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold#FoldExpr(v:lnum) foldmethod=expr
    autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<

    " Set syntax highlighting for Bash vim mode.
    autocmd BufRead,BufNewFile bash-fc-* set filetype=sh

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

" Camel/Pascal case identifier navigation.
nnoremap <silent> <C-Left> :call search('\<\<Bar>\u', 'bW')<CR>
nnoremap <silent> <C-Right> :call search('\<\<Bar>\u', 'W')<CR>
inoremap <silent> <C-Left> <C-o>:call search('\<\<Bar>\u', 'bW')<CR>
inoremap <silent> <C-Right> <C-o>:call search('\<\<Bar>\u', 'W')<CR>

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

if filereadable(printf("%s/.vimrc.local", $HOME))
    source $HOME/.vimrc.local
end
