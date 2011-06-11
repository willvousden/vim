setlocal iskeyword+=:,-
setlocal makeprg=pdflatex\ -file-line-error\ -interaction=nonstopmode\ %

"inoremap <buffer> { {}<Esc>i
"inoremap <buffer> [ []<Esc>i

"iab <buffer> ,b \begin{
"iab <buffer> ,e \end{
