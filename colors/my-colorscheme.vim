hi clear
if exists("syntax_on")
    syntax reset
endif

syntax enable

" Load base colorscheme {{{ "

let g:nord_underline=0
runtime colors/nord.vim
let g:colors_name = "my-colorscheme"

" }}} Load base colorscheme "

" General Appearance {{{ "

highlight Folded cterm=None ctermbg=0 ctermfg=2
highlight Comment cterm=None ctermbg=None ctermfg=11

" }}} General Appearance "

" Gutter / SignColumn {{{ "

highlight SignColumn        ctermbg=None
highlight SignifySignAdd    ctermfg=119
highlight SignifySignDelete ctermfg=167
highlight SignifySignChange ctermfg=227

" }}} Gutter / SignColumn "

" Highlight Word {{{
"
" Source: Steve Losh
" This mini-plugin provides a few mappings for highlighting words temporarily.
"
" Sometimes you're looking at a hairy piece of code and would like a certain
" word or two to stand out temporarily.  You can search for it, but that only
" gives you one color of highlighting.  Now you can use <leader>N where N is
" a number from 1-6 to highlight the current word in a specific color.
"
" <leader>0 will clear the highlighting.

function! HighlightInterestingWord(n) " {{{
    if a:n == 0
        for m in range(1, 9)
            let mid = 86750 + m
            silent! call matchdelete(mid)
        endfor

    else
        " Save our location.
        normal! mz

        " Yank the current word into the z register.
        normal! "zyiw

        " Calculate an arbitrary match ID.  Hopefully nothing else is using it.
        let mid = 86750 + a:n

        " Clear existing matches, but don't worry if they don't exist.
        silent! call matchdelete(mid)

        " Construct a literal pattern that has to match at boundaries.
        let pat = '\V\<' . escape(@z, '\') . '\>'

        " Actually match the words.
        call matchadd("InterestingWord" . a:n, pat, 1, mid)

        " Move back to our original location.
        normal! `z
    endif
endfunction " }}}

" Mappings {{{

nnoremap <silent> <leader>1 :call HighlightInterestingWord(1)<cr>
nnoremap <silent> <leader>2 :call HighlightInterestingWord(2)<cr>
nnoremap <silent> <leader>3 :call HighlightInterestingWord(3)<cr>
nnoremap <silent> <leader>4 :call HighlightInterestingWord(4)<cr>
nnoremap <silent> <leader>5 :call HighlightInterestingWord(5)<cr>
nnoremap <silent> <leader>6 :call HighlightInterestingWord(6)<cr>
nnoremap <silent> <leader>7 :call HighlightInterestingWord(7)<cr>
nnoremap <silent> <leader>8 :call HighlightInterestingWord(8)<cr>
nnoremap <silent> <leader>9 :call HighlightInterestingWord(9)<cr>
nnoremap <silent> <leader>0 :call HighlightInterestingWord(0)<cr>

" }}}

" Default Highlights {{{

hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=1
hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=2
hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=3
hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=4
hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=5
hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=6
hi def InterestingWord7 guifg=#000000 ctermfg=16 guibg=#d75faf ctermbg=7
hi def InterestingWord8 guifg=#000000 ctermfg=16 guibg=#ff005f ctermbg=8
hi def InterestingWord9 guifg=#000000 ctermfg=16 guibg=#ffd7ff ctermbg=9

" }}}

" }}}
