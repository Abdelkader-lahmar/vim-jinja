" Vim jinja plugin for syntax and indent support
" Last Change: 09 augest 2025
" Maintainer: Abdlekader Lahmar <lahmarabdelkader2006@gmail.com>
" License: MIT License

" stop plugin from loading twice and allow the user to disable loading the plugin
if exists("g:loaded_jinja")
  finish
endif
g:loaded_jinja = 1

function jinja#CheckJinja()
  let n = 1
  while n < 50 && n <= line("$")
    " check for jinja
    if getline(n) =~ '{{.*}}\|{%-\?\s*\(end.*\|extends\|block\|macro\|set\|if\|for\|include\|trans\)\>'
      call jinja#Start()
      return
    endif
    let n = n + 1
  endwhile
endfunction

function jinja#Start()
  call jinja#Syntax()
  call jinja#Indent()
endfunction

autocmd BufNewFile,BufRead *.html,*.htm call jinja#CheckJinja()
autocmd BufNewFile,BufRead *.jinja2,*.j2,*.jinja,*.nunjucks,*.nunjs,*.njk call jinja#Start()
