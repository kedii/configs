" vim:ts=2:sw=2:sts=2
" TODO:
"   call with arg of right ts in which file looks like
"   must be no error when file is already processed

" to replace all leading spaces as tabs but not to affect tabs after other characters. It assumes that 'ts' is set correctly. You can go a long way to making files that are misaligned better by doing something like this:

" :set ts=8     " Or whatever makes the file looks like right
" :set et       " Switch to 'space mode'
" :retab        " This makes everything spaces
" :set noet     " Switch back to 'tab mode'
" :RetabIndents " Change indentation (not alignment) to tabs
" :set ts=4     " Or whatever your coding convention says it should be

" You'll end up with a file where all the leading whitespace is tabs so people can look at it in whatever format they want, but where all the trailing whitespace is spaces so that all the end-of-line comments, tables etc line up properly with any tab width.


" Retab spaced file, but only indentation
command! -bar RetabIndents call RetabIndents()

" Retab spaced file, but only indentation
func! RetabIndents()
  let saved_view = winsaveview()
  execute '%s@^\( \{'.&ts.'}\)\+@\=repeat("\t", len(submatch(0))/'.&ts.')@'
  call winrestview(saved_view)
endfunc

" Explanation of the 'exe' line:
" execute '%s@^\( \{'.&ts.'}\)\+@\=repeat("\t", len(submatch(0))/'.&ts.')@'
" Execute the result of joining a few strings together:

" %s               " Search and replace over the whole file
" @....@....@      " Delimiters for search and replace
" ^                " Start of line
" \(...\)          " Match group
"  \{...}          " Match a space the number of times in the curly braces
" &ts              " The current value of 'tabstop' option, so:
"                  " 'string'.&ts.'string' becomes 'string4string' if tabstop is 4
"                  " Thus the bracket bit becomes \( \{4}\)
" \+               " Match one or more of the groups of 'tabstop' spaces (so if
"                  " tabstop is 4, match 4, 8, 12, 16 etc spaces
" @                " The middle delimiter
" \=               " Replace with the result of an expression:
" repeat(s,c)      " Make a string that is c copies of s, so repeat('xy',4) is 'xyxyxyxy'
" "\t"             " String consisting of a single tab character
" submatch(0)      " String that was matched by the first part (a number of multiples
"                  " of tabstop spaces)
" len(submatch(0)) " The length of the match
" /'.&ts.'         " This adds the string "/4" onto the expression (if tabstop is 4),
"                  " resulting in len(submatch(0))/4 which gives the number of tabs that
"                  " the line has been indented by
" )                " The end of the repeat() function call
"
" @                " End delimiter


set shiftround       " round indent to multiple of 'shiftwidth'
set expandtab        " insert spaces when TAB is pressed
set smarttab

let g:default_indent = 4
function! SetTabIndent(ntabs)
  let nt= a:ntabs>0 ? a:ntabs : g:default_indent
  let &tabstop=nt        " render TABs using this many spaces
  let &softtabstop=nt    " ... this many spaces
  let &shiftwidth=nt     " indentation amount for < and > commands
endfunc
function! ApplyTabIndent(ntabs)
  call RetabIndents()
  call SetTabIndent(a:ntabs)
  " retab
endfunc


call SetTabIndent(g:default_indent)
noremap <unique> <Leader>ti :<C-U>call ApplyTabIndent(v:count)<CR>
"noremap <leader>ct <Esc>:retab<CR>, :retab!
noremap <unique> <leader>ct :s:^\t\+:\=repeat(" ", len(submatch(0))*' . &ts . ')<CR>
noremap <unique> <leader>cT :s:^\( \{'.&ts.'\}\)\+:\=repeat("\t", len(submatch(0))/' . &ts . ')<CR>


" Indenting
if has("autocmd")
  " make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
  autocmd FileType python
    \ setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=79
  autocmd FileType make
    \ setlocal tabstop=4 shiftwidth=4 softtabstop=0 noexpandtab
endif

