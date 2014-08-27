"""""""""""""""""""
" latexbox commands
"""""""""""""""""""
" \lt Table of Contents
" \ll Compile with latexmk.
" \lL Force compilation with latexmk.
" \lc Clean temporary output from LaTeX.
" \lC Clean all output from LaTeX.
" \lk Kill latexmk if it is running.
" \lg Show the running status of latexmk for the current buffer.
" \lG Show the running status of latexmk for all buffers with process group ID's.
" \le Load the log file for the current document and jump to the first error.
"
" Custom commands
" \lce Change the Environment
" \lts Toggle Star environment
" \lwc Wrap selection in a Command
" \lwe Wrap selection in an Environment

if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        let g:LatexBox_viewer = "open -a /Applications/Skim.app"
        " use SyncTeX with the Skim viewer
        map <silent> <Leader>ls :silent
                \ !/Applications/Skim.app/Contents/SharedSupport/displayline
                \ <C-R>=line('.')<CR> "<C-R>=LatexBox_GetOutputFile()<CR>"
                \ "%:p" <CR>
    else
        let g:LatexBox_viewer = "gvfs-open"
    endif
endif

let g:LatexBox_output_type = "pdf"
"let g:LatexBox_latexmk_options = '-pdfdvi'
"
let g:LatexBox_Folding = 1

" disable async compile since it requires a vim server (complains in terminal)
let g:LatexBox_latexmk_async = 0

" disable automatic opening the quickfix window post-compilation;
" use :copen to open the window; or use <Leader>le (latexbox errors)
let g:LatexBox_quickfix = 2

" Turn off folding of all environments, but insist that abstract, figure and
" frame environments are folded.
let g:LatexBox_fold_envs = 0
let g:LatexBox_fold_envs_force = [
            \ "abstract",
            \ "figure",
            \ "frame"
            \ ]

let g:LatexBox_show_warnings = 1
let g:LatexBox_ignore_warnings = [
            \ 'Underfull',
            \ 'Overfull',
            \ 'specifier changed to',
            \ 'LaTeX Font Warning: Font shape',
            \ 'Package xcolor Warning: Incompatible color definition on input line',
            \ ]

