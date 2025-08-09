" Vim indent file for HTML + Jinja/Django templates
" Combines default HTML indentation with Jinja template support
" Maintains HTML indentation while adding rules for {% ... %}, {{ ... }}, etc.

if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

" Save the original HTML indentexpr
if exists('&indentexpr')
  let s:html_indentexpr = &l:indentexpr
else
  let s:html_indentexpr = ''
endif

" Our main indentation function
function! GetJinjaIndent() abort
  " Start with the HTML indentation
  let l:html_indent = 0
  if !empty(s:html_indentexpr)
    let l:html_indent = eval(s:html_indentexpr)
  endif

  " Current line
  let l:line = getline(v:lnum)

  " If current line starts a Jinja block tag, increase indent
  if l:line =~ '{%\s*\(if\|for\|block\|macro\|filter\|while\|with\|elif\)\>'
    return l:html_indent + &shiftwidth
  endif

  " If current line closes a Jinja block tag, decrease indent
  if l:line =~ '{%\s*end\(if\|for\|block\|macro\|filter\|while\|with\)\>'
    return l:html_indent - &shiftwidth
  endif

  " If current line is inside {{ ... }} or {% ... %}, keep HTML indent
  return l:html_indent
endfunction

" Use our custom indent function
setlocal indentexpr=GetJinjaIndent()
setlocal indentkeys=o,O,*<Return>,{,},o,O,!^F,<>>,{%,%}

