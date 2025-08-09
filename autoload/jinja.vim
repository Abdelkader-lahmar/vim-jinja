" Vim indent file
" Language:	Jinja HTML template
" Maintainer:	Evan Hammer <evan@evanhammer.com>
" Last Change:	2025 augest 09
" Made by Abdelkader Lahmar <lahmarabdelkader2006@gmail.com>


" Define indent function
" Made by Steve Losh <steve@stevelosh.com>
function! GetDjangoIndent(...)
    if a:0 && a:1 == '.'
        let v:lnum = line('.')
    elseif a:0 && a:1 =~ '^\d'
        let v:lnum = a:1
    endif
    let vcol = col('.')

    call cursor(v:lnum,vcol)

    exe "let ind = ".b:html_indentexpr

    let lnum = prevnonblank(v:lnum-1)
    let pnb = getline(lnum)
    let cur = getline(v:lnum)

    let tagstart = '.*' . '{%-\?\s*'
    let tagend = '.*-\?%}' . '.*'

    let blocktags = '\(block\|for\|if\|with\|autoescape\|comment\|filter\|spaceless\|macro\)'
    let midtags = '\(empty\|else\|elif\)'

    let pnb_blockstart = pnb =~# tagstart . blocktags . tagend
    let pnb_blockend   = pnb =~# tagstart . 'end' . blocktags . tagend
    let pnb_blockmid   = pnb =~# tagstart . midtags . tagend

    let cur_blockstart = cur =~# tagstart . blocktags . tagend
    let cur_blockend   = cur =~# tagstart . 'end' . blocktags . tagend
    let cur_blockmid   = cur =~# tagstart . midtags . tagend

    if pnb_blockstart && !pnb_blockend
        let ind = ind + &sw
    elseif pnb_blockmid && !pnb_blockend
        let ind = ind + &sw
    endif

    if cur_blockend && !cur_blockstart
        let ind = ind - &sw
    elseif cur_blockmid
        let ind = ind - &sw
    endif

    return ind
endfunction

" Define Syntax function
function! jinja#Syntax()
    "Check global syntax if enabled
    if !exists("g:syntax_on")
        return
    endif

    if !exists("main_syntax")
      let main_syntax = 'html'
      execute 'runtime! syntax/html.vim'
      unlet b:current_syntax
    endif

    runtime! syntax/jinja.vim

endfunction

function! jinja#Indent()
    " Function to triger the indentation
    if &l:indentexpr == ''
        if &l:cindent
            let &l:indentexpr = 'cindent(v:lnum)'
        else
            let &l:indentexpr = 'indent(prevnonblank(v:lnum-1))'
        endif
    endif

    setlocal indentexpr=GetDjangoIndent()
    setlocal indentkeys=o,O,*<Return>,{,},o,O,!^F,<>>

endfunction
