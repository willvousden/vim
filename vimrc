" First, make this configuration portable...

" Detect where this vim config is (resolving symlinks).
let g:portable = fnamemodify(resolve(expand('<sfile>')), ':p:h')

" Now update runtime path accordingly.
let &runtimepath = printf('%s,%s,%s/after', g:portable, &runtimepath, g:portable)

set nocompatible
call plug#begin(printf('%s/plugged', g:portable))

execute 'source ' . printf('%s/vimrc-basic', g:portable)
if !exists('g:vscode')
    execute 'source ' . printf('%s/vimrc-extended', g:portable)
else
    call plug#end()
endif

if filereadable(printf("%s/.vimrc.local", $HOME))
    source $HOME/.vimrc.local
end
