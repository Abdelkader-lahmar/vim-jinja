" Vim indent file
" Language:	Jinja HTML template
" Maintainer:	Evan Hammer <evan@evanhammer.com>
" Last Change:	2025 augest 09
" Made by Abdelkader Lahmar <lahmarabdelkader2006@gmail.com>


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
