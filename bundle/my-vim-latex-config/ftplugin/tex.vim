" LatexBox commands
"
" <LocalLeader>lt Table of Contents
" <LocalLeader>ll Compile with latexmk.
" <LocalLeader>lL Force compilation with latexmk.
" <LocalLeader>lc Clean temporary output from LaTeX.
" <LocalLeader>lC Clean all output from LaTeX.
" <LocalLeader>lk Kill latexmk if it is running.
" <LocalLeader>lg Show the running status of latexmk for the current buffer.
" <LocalLeader>lG Show the running status of latexmk for all buffers with process group ID's.
" <LocalLeader>le Load the log file for the current document and jump to the first error.
" <LocalLeader>lf Recalculate the folds.
"
" Custom commands
"
" <LocalLeader>lh  Load this (help) file
" <LocalLeader>lce Change the Environment
" <LocalLeader>lts Toggle Star environment
" <LocalLeader>lwc Wrap selection in a Command
" <LocalLeader>lwe Wrap selection in an Environment

" load this file
nmap <buffer> <LocalLeader>lh   :split $HOME/.vim/bundle/my-vim-latex-config/tex.vim<CR>

" LaTeX-box configurations
imap <buffer> ]]                <Plug>LatexCloseCurEnv
nmap <buffer> <LocalLeader>lce  <Plug>LatexChangeEnv
nmap <buffer> <LocalLeader>lts  <Plug>LatexToggleStarEnv
nmap <buffer> <LocalLeader>lwc  viw<Plug>LatexWrapSelection
vmap <buffer> <LocalLeader>lwc  <Plug>LatexWrapSelection
vmap <buffer> <LocalLeader>lwe  <Plug>LatexEnvWrapSelection

" open a \left parenthesis
inoremap <buffer> [[ \left[
inoremap <buffer> (( \left(
inoremap <buffer> {{ \left\{
inoremap <buffer> << \left\langle
inoremap <buffer> >> \right\rangle

" various mappings
inoremap <buffer> ... \dots
inoremap <buffer> ^-1 ^{-1}

" Greek Letters
" reference: http://www.giss.nasa.gov/latex/ltx-405.html
inoremap <buffer> `a \alpha
inoremap <buffer> `b \beta
inoremap <buffer> `c \chi
inoremap <buffer> `d \delta
inoremap <buffer> `e \varepsilon
inoremap <buffer> `f \varphi
inoremap <buffer> `g \gamma
inoremap <buffer> `h \eta
inoremap <buffer> `k \kappa
inoremap <buffer> `l \lambda
inoremap <buffer> `m \mu
inoremap <buffer> `n \nu
inoremap <buffer> `p \pi
inoremap <buffer> `q \theta
inoremap <buffer> `r \rho
inoremap <buffer> `s \sigma
inoremap <buffer> `t \tau
inoremap <buffer> `u \upsilon
inoremap <buffer> `v \varsigma
inoremap <buffer> `w \omega
inoremap <buffer> `w \wedge
inoremap <buffer> `x \xi
inoremap <buffer> `y \psi
inoremap <buffer> `z \zeta
inoremap <buffer> `D \Delta
inoremap <buffer> `F \Phi
inoremap <buffer> `G \Gamma
inoremap <buffer> `Q \Theta
inoremap <buffer> `L \Lambda
inoremap <buffer> `X \Xi
inoremap <buffer> `Y \Psi
inoremap <buffer> `S \Sigma
inoremap <buffer> `U \Upsilon
inoremap <buffer> `W \Omega

" various symbols
inoremap <buffer> `6 \partial
inoremap <buffer> `8 \infty
inoremap <buffer> `@ \circ
inoremap <buffer> `0 ^\circ
inoremap <buffer> `= \equiv
inoremap <buffer> `\ \setminus
inoremap <buffer> `. \cdot
inoremap <buffer> `* \times
inoremap <buffer> `& \wedge
inoremap <buffer> `- \bigcap
inoremap <buffer> `+ \bigcup
inoremap <buffer> `( \subseteq
inoremap <buffer> `) \supseteq
inoremap <buffer> `< \leq
inoremap <buffer> `> \geq
inoremap <buffer> `, \nonumber
inoremap <buffer> `\| \Big|
inoremap <buffer> `~ \widetilde
inoremap <buffer> `^ \widehat
inoremap <buffer> `_ \textunderscore


function! ToggleDisplaySolutions()
    " supposes that there is a line in the latex file of the following form:
    "
    "   \def\showsolutions{True}
    "   \def\showsolutions{False}

    let b:currentview = winsaveview()
    let l:searchpattern = '^\\def\\showsolutions{\(True\|False\)}$'
    let l:toggledict = '{"True":"False", "False":"True"}'
    execute 'g/' . l:searchpattern . '/'. 's/True\|False/\='.l:toggledict.'[submatch(0)]/g'
    write
    Latexmk
    call winrestview(b:currentview)
endfunction

command! -nargs=0 ShowSolutions call ToggleDisplaySolutions()


function! LatexAddItem()
    " add \item within a list-like environment (itemize/enumerate/etc) after
    " a carriage return provided that the previous and current lines are blank
    "
    " adapted from: http://stackoverflow.com/questions/2547739/auto-insert-text-at-a-newline-in-vim
    if getline(line('.')) =~ '^ *$' && getline(line('.') - 1) =~ '^$'
        if searchpair('\\begin{enumerate}', '', '\\end{enumerate}', '') ||
                    \ searchpair('\\begin{itemize}', '', '\\end{itemize}', '') ||
                    \ searchpair('\\begin{description}', '', '\\end{description}', '')
            return "\\item\r"
        endif
    endif
    return "\r"
endfunction

inoremap <expr><buffer> <CR> LatexAddItem()
