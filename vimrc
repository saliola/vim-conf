" let pathogen do its thing
execute pathogen#infect()

" shortcut to edit this file
map ,rc :tabnew $MYVIMRC<CR><C-W>
map ,src :source $MYVIMRC<CR>

" shorten an often typed command
imap <C-s> <esc>:w<CR>a

" command line editing
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>

" insert current date
nnoremap <D-D> "=strftime("%F")<CR>P
inoremap <D-D> <C-R>=strftime("%F")<CR>

" enable copy/paste on Mac OSX and tmux (see also notes/macosx.notes)
set clipboard=unnamed

" Pretty Colours
syntax enable " enable syntax highlighting
if has('gui_running')
    set background=light
    colorscheme solarized
else
    set background=light
    set t_Co=256
    let g:solarized_termtrans = 1
    let g:solarized_termcolors=256
    let g:solarized_italic=0 " disable display of italics (bgcolor is too dark)
    colorscheme solarized
endif

" colors for folded blocks
" -- defaults, except that I turned off underlining " in the terminal
hi Folded term=none cterm=none ctermfg=240 ctermbg=254 gui=underline guifg=#585858 guibg=#e4e4e4 guisp=#ffffd7


" Crosshair
hi CursorColumn ctermbg=187 guibg=#eee8d5
hi CursorLine ctermbg=187 guibg=#eee8d5
set cursorline
set cursorcolumn
set colorcolumn=80

" hybrid line numbers (requires 7.4)
set number " set number
set relativenumber " set relative line numbers

" General settings
set encoding=utf-8
set nowrap " don't wrap text ; I have a wide monitor
set textwidth=0 " set textwidth to 75 to cause wrapping
set hlsearch " hightlight search
set history=50 " 50 lines of command lines history
set viminfo='20,\"50 " read/write a .viminfo file with at most 50 lines
set ruler " show the cursor position all the time
set nojoinspaces " only put one space after periods
set incsearch " incremental search
set scrolloff=1 " always show n screen lines to above and below the cursor
set tabstop=4|set shiftwidth=4|set softtabstop=4|set expandtab " tab settings for all files
set laststatus=2
set statusline=%F%m%r%h%w\ [Type=%Y]\ [POS=%04l,%04v]\ [%p%%]\ [LEN=%L]
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set iskeyword=@,48-57,_,192-255
set formatoptions+=1n

" spell-checking
set nospell " no spell checking (in terminal only; it's reactivated in gvimrc)
set spellsuggest=5

" no swap files or backups
set nobackup         " no backup files
set nowritebackup    " only in case you don't want a backup file while editing
set noswapfile       " no swap files

" Set C-Tab to switch tabs
map <C-Tab> gt
map <C-S-Tab> gt

" Insert the current directory into a command-line path
" Notes:
" - if path contains whitespace, then ``escape`` will escape them
cmap <C-P> <C-R>=escape(expand("%:p:h"),' ') . "/"<CR>
" Insert the current filename into a command-line path
cmap %% <C-R>=escape(expand("%"),' ')<CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>t :tabnew
map <Leader>tp :tabnew <C-p>
map <Leader>tn :tabnew 
map <Leader>tN :tabnew ~/Dropbox/notes/
command! Notes :browse ~/Dropbox/notes/

" Fullscreen with 
" command! FullScreenEditing :vertical new readonly | :vertical resize 120 | :wincmd w
command! FullScreenEditing :vertical new | :vertical resize 120 | :wincmd w

" show trailing spaces as dots
set listchars=tab:>-,extends:»,precedes:«,trail:·
"set listchars=

" undo janus keybindings
"nunmap <C-k>
"nunmap <C-j>
"vunmap <C-k>
"vunmap <C-j>

" wild card settings
set wildmenu
set wildmode=list:full
" ignore these filenames during tab completion
set wildignore+=*.out,*.synctex.gz,*.aux,*.ilg,*.log,*.nls,*.idx,*.ind,*.blg,*.nlo,*.pdf,*.toc

" [old way] List of recent files
" :bro[wse] ol[dfiles][!]
" List file names as with |:oldfiles|, and then prompt
" for a number.  When the number is valid that file from
" the list is edited.
" If you get the |press-enter| prompt you can press "q"
" and still get the prompt to enter a file number.
"command! Recent :browse oldfiles

" List of recent files, using CtrlP <https://github.com/kien/ctrlp.vim>
let g:ctrlp_cmd = 'CtrlPMRUFiles'
let g:ctrlp_by_filename = 1 " toggle with <c-d>
let g:ctrlp_regexp = 0 " toggle with <c-r>
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }
nmap <C-p> :<C-U>CtrlPMRUFiles<CR>


" TaskList.vim --- activiate wtih :TaskList
"map <Leader>td <Plug>TaskList
let g:tlTokenList = ['TODO', 'FIXME', 'XXX']

" Use ReStructuredText syntax highlighting for .notes and .txt files
"autocmd BufRead,BufNewFile *.notes set filetype=rst
"autocmd BufRead,BufNewFile *.txt set filetype=rst | set nowrap

" Sage / Python settings
autocmd BufRead,BufNewFile *.sage set filetype=python
autocmd BufRead,BufNewFile *.chevie set filetype=python
autocmd BufRead,BufNewFile *.g set filetype=python

"" vim2sage
"if has("python")
"command! -range SageIt :py vim2sage(<line1>,<line2>)
"map <S-CR> :SageIt<CR><CR>
"imap <S-CR> <C-o><S-CR>
"python << EOL
"import vim
"def vim2sage(line1,line2):
"    import vim, subprocess
"    range = vim.current.buffer.range(line1,line2)
"    args = ['/usr/bin/screen', '-x', 'sagescreen', '-p', '0', '-X', 'stuff']
"    for line in range:
"        sp = subprocess.Popen(args+[line+r""""""])
"        ## For debugging : in order to read stdout and stderr
"        #sp = subprocess.Popen(args+["'%s%s'"%(line,"\n")],
"        #    stdout=subprocess.PIPE,
"        #    stderr=subprocess.PIPE,
"        #    close_fds=True)
"        #if not sp.poll():
"        #    b=vim.current.buffer
"        #    curline=vim.current.range.start
"        #    b.append(("STDOUT:\n"+sp.stdout.read()+"\nSTDERR:\n"+sp.stderr.read()).split("\n"), curline)
"EOL
"endif

" vim2sage
if has("python")
python << EOL
import vim
def vim2sage(line1,line2):
    import vim, subprocess
    if line1 == line2:
        range = list(vim.current.buffer.range(line1,line2))
    else:
        range = [r'%cpaste'] + list(vim.current.buffer.range(line1,line2)) + [r'''''']
    args = ['/usr/local/bin/tmux', 'send-keys', '-t', '0']
    for line in range:
        sp = subprocess.call(args+[line])
        sp = subprocess.call(args+["Enter"])
        if sp != 0:
           raise Exception("no appropriate tmux session found")
EOL
command! -range SageVisualMode :call SageVisualModeFunction(<line1>,<line2>)
function! SageVisualModeFunction(line1,line2)
    execute ":python vim2sage(" . a:line1 . "," . a:line2 . ")"
endfunction
map <S-CR> :SageVisualMode<CR><CR>
imap <S-CR> <C-o><S-CR>
endif

function! OpenRejectFile()
    " splits window and opens the %.rej
    let filename=expand('%')
    let rejectsfile = filename.'.rej'
    split
    exec 'edit '.rejectsfile
endfunction
command! Rejects :call OpenRejectFile()

" external make window
if has("python")
"command ExternalMakeWindow :py externalmakewindow
python << EOL
def externalmakewindow():
    import vim, subprocess
    # get current working directory
    filename = vim.current.buffer.name
    cwd = filename[:filename.rfind('/')]
    # change to directory and run make
    commands = ('cd %s; make' % cwd,)
    command_prefix = ['/usr/bin/screen', '-x', 'makewindow', '-p', '0', '-X', 'stuff']
    enter = r""""""
    for command in commands:
        args = command_prefix + [command+enter]
        sp = subprocess.Popen(args, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        # For debugging : in order to read stdout and stderr
        print sp.communicate()[0]
EOL
endif
"set makeprg=:py externalmakewindow


" Tasklist settings
autocmd BufRead,BufNewFile tasklist.rst set filetype=tasklist | imap <buffer> <S-CR> → | set comments=b:→ | set formatoptions+=o | set iskeyword+=#,@ | imap <buffer> -> →
command! Tasks :tabnew ~/Dropbox/tasklists/tasklist.rst

command! Notes :tabnew ~/Dropbox/notes/


" Scratchpad settings
command! ScratchPad :tabnew ~/Dropbox/scratchpad.rst

" LaTeX
"autocmd BufRead,BufNewFile *.tex source ~/Dropbox/configs/vim/vimrcfiles/latexsuite.vim

"""""""""""""""""""""""""""""""
" latexbox configuration on mac
"""""""""""""""""""""""""""""""
let g:LatexBox_output_type = "pdf"
" disable automatically openning the quickfix window post-compilation;
" use :copen to open the window; or use <Leader>le (latexbox errors)
let g:LatexBox_quickfix = 0
if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        let g:LatexBox_viewer = "open -a /Applications/Skim.app"
        let g:LatexBox_latexmk_async = 0
    else
        let g:LatexBox_latexmk_async = 1
    endif
endif
"let g:LatexBox_latexmk_options = '-pdfdvi'
let g:LatexBox_Folding = 1

" use SyncTeX with the Skim viewer
map <silent> <Leader>ls :silent
        \ !/Applications/Skim.app/Contents/SharedSupport/displayline
        \ <C-R>=line('.')<CR> "<C-R>=LatexBox_GetOutputFile()<CR>"
        \ "%:p" <CR>

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

" open a .tex file in TeXShop
function! TeXShop()
    let filename=expand('%')
    execute '!open -a /Applications/TeX/TeXShop.app '.filename
endfunction

" Run LaTeX through TexShop
function! RunTeXShop()
   if &ft != 'tex'
      echo "calling RunTeXShop from a non-tex file"
      return ''
   end

   "write the file
   :w

   "Previous Script:
   " tell app \"TeXShop\"
   "    set theDoc to open ((POSIX file \"'.expand("%:p").'\") as alias)
   "    tell theDoc to latexinteractive
   " end tell
   "let execString = 'osascript -e "tell app \"TeXShop\"" -e "set theDoc to open ((POSIX file \"'.expand("%:p").'\") as alias)" -e "tell theDoc to latexinteractive" -e "end tell"'


   "New Script:
   " tell app \"TeXShop\"
   "    set theDoc to open ((POSIX file \"'.thePath.'\") as alias)
   "    try
   "        tell theDoc to latexinteractive
   "    on error
   "        set theDoc to front document
   "        tell theDoc to latexinteractive
   "    end try
   "    end tell
   let thePath = getcwd() . '/'. expand("%")
   let execString = 'osascript -e "tell app \"TeXShop\"" -e "set theDoc to open ((POSIX file \"'.thePath.'\") as alias)" -e "try" -e "tell theDoc to latexinteractive" -e "on error" -e "set theDoc to front document" -e "tell theDoc to latexinteractive" -e "end try" -e "end tell"'
   
   exec 'silent! !' execString
   exec '!' execString
   return ''
endfunction

noremap  <D-t> :call RunTeXShop()<CR>
"inoremap <D-t> <C-o>:call RunTeXShop()<CR>
"noremap  <D-t> <Leader>ll

""""""""""""""
" TeXShop 2.47
""""""""""""""
"
" VimScript:
"
" exec '!osascript -e "tell app \"TeXShop\"" -e "set theDoc to open ((POSIX file \"'.expand("%:p").'\") as alias)" -e "tell theDoc to latexinteractive" -e "end tell"'
"
" AppleScript:
"
" tell application "TeXShop"
" 	set theDoc to open ((POSIX file "/Users/saliola/Dropbox/Mathematics/articles/NonCommutativeHallLittlewood/arXivDraftMNrule.tex") as alias)
" 	tell theDoc to latexinteractive
" end tell
"
" AppleScript Output:
"
" tell application "TeXShop"
" 	open alias "Macintosh HD:Users:saliola:Dropbox:Mathematics:articles:NonCommutativeHallLittlewood:arXivDraftMNrule.tex"
" 		--> document 1
" 	latexinteractive document 1
" end tell
"
""""""""""""""""""
" End TeXShop 2.47
""""""""""""""""""



" ConqueTerm
" leave Conque buffer using <C-w> commands while still in insert mode
"let s:ConqueTerm_CWInsert = 1
" send currently selected text to the most recently created Conque buffer
"let g:ConqueTerm_SendVisKey = <S-CR>
" toggle terminal input mode : pause terminal input and output display 
"let g:ConqueTerm_ToggleKey = '`<F8>`'
" Conque will continue to update after you've switched to another buffer
"let g:ConqueTerm_ReadUnfocused = 1
" close buffer when program exists
"let g:ConqueTerm_CloseOnEnd = 0

" Diff current file with the version on disk
" [From Hacking Vim, Chapter 4, by Kim Schulz]
function! DiffWithFileFromDisk()
    let filename=expand('%')
    let diffname = filename.'.fileFromBuffer'
    exec 'saveas! '.diffname
    diffthis
    vsplit
    exec 'edit '.filename
    diffthis
endfunction
" To execute this function:
":call DiffWithFileFromDisk()

""""" Mac OSX Specific
" For the French keyboard on the MacBook: map the key §/± key to `/~
map! § `
map! ± ~


""""""
"" From Hacking Vim, Chapter 4, by Kim Schulz
""
"" Try, in order:
""    - omni-completion
""    - dictionary-completion
""    - buffer-completion
"function! SuperCleverTab()
"    "check if at beginning of line or after a space
"    if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
"        return "\<Tab>"
"    else
"        " use known-word completion
"        return "\<C-N>"
"        "" do we have omni completion available
"        "if &omnifunc != ''
"        "    " try omni-completion
"        "    return "\<C-X>\<C-O>"
"        "elseif &dictionary != ''
"        "    " try dictionary completion
"        "    return "\<C-K>"
"        "else
"        "    " use known-word completion
"        "    return "\<C-N>"
"        "endif
"    endif
"endfunction
"" binds SuperCleverTab to Tab
"inoremap <Tab> <C-R>=SuperCleverTab()<CR>

" tasklist : filenames are added as :
function! HandleFilename()
  let s:uri = matchstr(getline("."), ' :[^ ]*')
  let s:uri = s:uri[2:]
  echo s:uri
  if s:uri != ""
      echo "found the filename " . s:uri
      execute "tabnew " . s:uri
  else
      echo "No filename found in line."
  endif
endfunction
map <Leader>gf :call HandleFilename()<CR><CR>

"" Mac OS X : open a url
"" http://vim.wikia.com/wiki/Open_a_web-browser_with_the_URL_in_the_current_line
"function! HandleURI()
"  let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;:]*')
"  echo s:uri
"  if s:uri != ""
"      exec "!open \"" . s:uri . "\""
"  else
"      echo "No URI found in line."
"  endif
"endfunction
"map <Leader>gw :call HandleURI()<CR><CR>

" OpenURL function
" http://www.vim.org/scripts/script.php?script_id=3291
function! OpenURL()
python << EOM
# coding=utf-8
import vim
import re
import webbrowser
re_obj = re.compile(r'https?://[a-zA-Z0-9-./"#$%&\':?=_+]+')
line = vim.current.line
match_obj = re_obj.search(line)
try:
    url = match_obj.group()
    webbrowser.open(url)
    print 'open URL : %s' % url
except:
    print 'failed! : open URL'
EOM
endfunction
" set a command for OpenURL function
map <Leader>gw :call OpenURL()<CR><CR>

" Syntastic Warning / Error codes, broken out by component.
" see: http://pypi.python.org/pypi/flake8
"
" pep8:
" E101: indentation contains mixed spaces and tabs
" E111: indentation is not a multiple of four
" E112: expected an indented block
" E113: unexpected indentation
" E201: whitespace after char
" E202: whitespace before char
" E203: whitespace before char
" E211: whitespace before text
" E223: tab / multiple spaces before operator
" E224: tab / multiple spaces after operator
" E225: missing whitespace around operator
" E225: missing whitespace around operator
" E231: missing whitespace after char
" E241: multiple spaces after separator
" E242: tab after separator
" E251: no spaces around keyword / parameter equals
" E262: inline comment should start with '# '
" E301: expected 1 blank line, found 0
" E302: expected 2 blank lines, found <n>
" E303: too many blank lines (<n>)
" E304: blank lines found after function decorator
" E401: multiple imports on one line
" E501: line too long (<n> characters)
" E701: multiple statements on one line (colon)
" E702: multiple statements on one line (semicolon)
" W191: indentation contains tabs
" W291: trailing whitespace
" W292: no newline at end of file
" W293: blank line contains whitespace
" W391: blank line at end of file
" W601: .has_key() is deprecated, use 'in'
" W602: deprecated form of raising exception
" W603: '<>' is deprecated, use '!='
" W604: backticks are deprecated, use 'repr()'
"
" pyflakes
" W402: <module> imported but unused
" W403: import <module> from line <n> shadowed by loop variable
" W404: 'from <module> import *' used; unable to detect undefined names
" W405: future import(s) <name> after other statements
" W801: redefinition of unused <name> from line <n>
" W802: undefined name <name>
" W803: undefined name <name> in __all__
" W804: local variable <name> (defined in enclosing scope on line <n>) referenced before assignment
" W805: duplicate argument <name> in function definition
" W806: redefinition of function <name> from line <n>
" W806: local variable <name> is assigned to but never used
"
" McCabe
" W901: '<function_name>' is too complex ('<complexity_level>')
let g:syntastic_python_checker_args='--ignore=E501,E302'

" Syntastic: disable marking of syntax errors for terminal (re-enabled in .gvimrc)
let g:syntastic_enable_signs=0

" Show the highlight group syntax under the cursor
" http://vim.wikia.com/wiki/Showing_syntax_highlight_group_in_statusline
function! ShowSyntaxHighlightGroup()
    echo synIDattr(synID(line("."),col("."),1),"name")
endfunction
