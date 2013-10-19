" some new highlight groups
hi Prompt ctermfg=33 guifg=#80a0ff
"hi PyDocString ctermfg=245 guifg=DarkGray
hi link PyDocString Comment
hi SageDocStringKeywords cterm=bold,underline ctermfg=245 ctermbg=187 guifg=LightGray gui=underline,bold

"""""" BEGIN VERSION 7.3
"" Load the ReST syntax file; but first we clear the current syntax
"" definition, as rst.vim does nothing if b:current_syntax is defined.
"let s:current_syntax=b:current_syntax
"unlet b:current_syntax
"" Load the ReST syntax file
"syntax include @ReST $VIMRUNTIME/syntax/rst.vim
"let b:current_syntax=s:current_syntax
"unlet s:current_syntax
"" clear the rstLiteralBlock
"" TODO: improve this; this should apply to all
"" pythonDocString regions but the sageDoctest regions
"syntax clear rstLiteralBlock
"""""" END VERSION 7.3

"""""" BEGIN VERSION 7.4
" Load the ReST syntax file; this is just a copy of $VIMRUNTIME/syntax/rst.vim
" with the test exists("b:current_syntax") disables.
syntax include @ReST <sfile>:p:h/rst.vim
" Clear the rstLiteralBlock so that our highlighting applies
syntax clear rstLiteralBlock
"""""" END VERSION 7.4

" By using the nextgroup argument below, we are giving priority to
" pythonDocString over all other groups. This means that a pythonDocString
" can only begin a :
syntax match beginPythonBlock ":$" nextgroup=pythonDocString skipempty skipwhite
hi link beginPythonBlock None

syntax region pythonDocString
    \ start=+[uUr]\='+
    \ end=+'+
    \ contains=sageDoctest,pythonEscape,@Spell,@ReST,SageDocStringKeywords,sageTodo
    \ contained
    \ fold
syntax region pythonDocString
    \ start=+[uUr]\="+
    \ end=+"+ 
    \ contains=sageDoctest,pythonEscape,@Spell,@ReST,SageDocStringKeywords,sageTodo
    \ contained
    \ fold
syntax region pythonDocString
    \ matchgroup=PyDocString
    \ start=+[uUr]\="""+
    \ end=+"""+
    \ contains=sageDoctest,pythonEscape,@Spell,@ReST,SageDocStringKeywords,sageTodo
    \ contained
    \ skipempty
    \ skipwhite
    \ keepend
    \ fold
syntax region pythonDocString
    \ matchgroup=PyDocString
    \ start=+[uUr]\='''+
    \ end=+'''+
    \ contains=sageDoctest,pythonEscape,@Spell,@ReST,SageDocStringKeywords,sageTodo
    \ contained
    \ skipempty
    \ skipwhite
    \ keepend
    \ fold
hi link pythonDocString PyDocString

" clear the pythonDoctest and pythonDoctestValue syntax groups
if hlexists("pythonDoctest")
    syntax clear pythonDoctest
    syntax clear pythonDoctestValue
endif

syntax region sageDoctest
    \ start=+^\s*sage:\s+
    \ end=+\%(^\s*$\|^\s*"""$\)+
    \ contains=ALLBUT,sageDoctest,@ReST,@Spell
    \ contained 
    \ nextgroup=sageDoctestValue
"hi link sageDoctest Statement

syntax region sageDoctestValue
    \ start=+^\s*\%(sage:\s\|>>>\s\|\.\.\.\)\@!\S\++
    \ end="$"
    \ contains=NONE
    \ contained 
hi link sageDoctestValue Underlined

syntax match sagePrompt "sage:" containedin=sageDoctest contained
syntax match sagePrompt "....:" containedin=sageDoctest contained
hi link sagePrompt Prompt

syntax case match
syntax keyword sageDocStringKeywords INPUT OUTPUT AUTHORS EXAMPLES TESTS REFERENCES
hi link sageDocStringKeywords SageDocStringKeywords

syntax keyword sageTodo FIXME TODO XXX NOTE
hi link sageTodo Todo

" Look back at least 200 lines to compute the syntax highlighting
syntax sync minlines=200

