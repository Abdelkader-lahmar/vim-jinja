
" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif

" Use HTML formatting rules.
let b:did_indent = 1

" Indent within the jinja tags
" Made by Steve Losh <steve@stevelosh.com>
if &l:indentexpr == ''
    if &l:cindent
        let &l:indentexpr = 'cindent(v:lnum)'
    else
        let &l:indentexpr = 'indent(prevnonblank(v:lnum-1))'
    endif
endif
let b:html_indentexpr = &l:indentexpr

"Define indent funcion
" load indent function
