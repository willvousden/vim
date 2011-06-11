let mapleader = ","

" Basic stuff.
set encoding=utf-8
set vb
set ai
set background=dark
"set gfn=Consolas:h10
set foldmethod=syntax
set backspace=indent,eol,start
set nocompatible

set showmatch
set showmode
set scrolloff=3
set cursorline
set number
set relativenumber
nmap <silent> <leader>l :set list!<CR>
set listchars=tab:▸·,eol:¬,trail:·,extends:«,precedes:»,nbsp:_
if has("gui_running")
    let g:molokai_original=1
    colorscheme molokai
endif

set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab

" Searches and stuff.
"nnoremap / /\v
"vnoremap / /\v
set magic
set smartcase
set ignorecase
set gdefault " Invert global subsitute behaviour.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" Navigation.
nnoremap j gj
nnoremap k gk
map <PageUp> <C-u>
map <PageDown> <C-d>
imap <PageUp> <C-o><C-u>
imap <PageDown> <C-o><C-d>

map <silent> Y y$

" Session managment.
set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize

" Plugin stuff with Pathogen.
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" Orgmode stuff.
"filetype on
"filetype plugin on
"filetype indent on

" Tag stuff.
let tlist_tex_settings='tex;b:bibitem;c:command;l:label'

" Mappings for editing and reloading vimrc.
map <leader>v :sp<CR>:e $MYVIMRC<CR><C-w>_
map <silent> <leader>V :source $MYVIMRC<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" Mappings for session managment.
map <leader>q :mksession! $VIM/.session<CR>:exe ":echo 'Session saved!'"<CR>
map <leader>s :source $VIM/.session<CR>:exe ":echo 'Session loaded!'"<CR>

if has("gui_running")
	" Assume we're running in portable mode.
	set nobackup
	set nowritebackup
	if has("win32") || has("win64")
		let viminfopath=$VIM."\\.viminfo"
		set directory=$TMP
	else
		let viminfopath=$VIM."/.viminfo"
		"set directory=~/tmp
	end
	"execute "set viminfo='1000,n".escape(viminfopath, ' ')
	
	" Disable toolbar.
	set guioptions-=T
	
	" Mappings for external programs.
	map <silent> <leader>n :!start "F:\Programs\Notepad++\notepad++.exe" %<CR>
	map <silent> <leader>e :!start explorer.exe %:h<CR>
endif

if has("autocmd")
	" Remember positions in files with some Git-specific exceptions.
	autocmd BufReadPost *
	  \ if line("'\"") > 0 && line("'\"") <= line("$")
	  \           && expand("%") !~ "COMMIT_EDITMSG"
	  \           && expand("%") !~ "ADD_EDIT.patch"
	  \           && expand("%") !~ "addp-hunk-edit.diff"
	  \           && expand("%") !~ "git-rebase-todo" |
	  \   exe "normal! g`\"" |
	  \ endif

	" No line numbers when viewing help
	autocmd FileType help set nonumber
	
	" Enter selects the current tag and backspace goes back.
	autocmd FileType help nnoremap <CR> <C-]>
	autocmd FileType help nnoremap <buffer><BS> <C-T>

    " Automatically enable relative numbering.
    autocmd BufReadPost * set relativenumber
    autocmd BufNewFile * set relativenumber
    autocmd BufWinEnter * set relativenumber
	
    if has("win32") || has("win64")
        " Maximize window.
        autocmd GUIEnter * simalt ~x
    endif
endif

" Auto-centre on find!
nmap n nzz
nmap N Nzz

" Easy saving!
nnoremap <leader>w :w<CR>
nnoremap <leader>W :w !sudo tee %<CR>

" Easy selection!
nnoremap <leader>A ggVG

" Tab navigation mappings.
nmap <silent> <C-j> :tabprev<CR>
nmap <silent> <C-k> :tabnext<CR>
imap <silent> <C-j> <C-o>:tabprev<CR>
imap <silent> <C-k> <C-o>:tabnext<CR>

" Folding mappings.
nnoremap <silent> <C-LeftMouse> <LeftMouse>za

" Word search mappings.
nnoremap <silent> <S-LeftMouse> <LeftMouse>*

" Camel/Pascal case identifier navigation.
nnoremap <C-Left> :call search('\<\<Bar>\u', 'bW')<CR>
nnoremap <C-Right> :call search('\<\<Bar>\u', 'W')<CR>
inoremap <C-Left> <C-o>:call search('\<\<Bar>\u', 'bW')<CR>
inoremap <C-Right> <C-o>:call search('\<\<Bar>\u', 'W')<CR>

" NERDTree stuff.
autocmd VimEnter * nnoremap <silent> <Tab> :NERDTreeToggle<CR>
"autocmd VimEnter * exe 'NERDTree' | wincmd l
"autocmd BufEnter * NERDTreeMirror

" JavaScript stuff.
let javaScript_fold=1
autocmd BufRead,BufNewFile *.js set ft=javascript syntax=jquery


" Pre-defined stuff follows!

" An example for a vimrc file.

" Maintainer:    Bram Moolenaar <Bram@vim.org>
" Last change:    2008 Jul 02
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"          for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"        for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

if has("vms")
  set nobackup        " do not keep a backup file, use versions instead
else
  " set backup        " keep a backup file
endif
set history=50        " keep 50 lines of command line history
set ruler        " show the cursor position all the time
set showcmd        " display incomplete commands
set incsearch        " do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  " EDIT: This is taken care of above!
  "autocmd BufReadPost *
	"\ if line("'\"") > 1 && line("'\"") <= line("$") |
	"\   exe "normal! g`\"" |
	"\ endif

  augroup END

else

  set autoindent        " always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
