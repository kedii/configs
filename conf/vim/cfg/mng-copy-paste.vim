" vim:ts=2:sw=2:sts=2
" NOTE: cmap: C-R,C-G inserts current file name
":s;|;\\^M|;g  | split pipe on multiline
"To comment (instead of C-V): select by S-V, then type : s/^/#
" list all occurrences of word under cursor in current buffer: [I
" SEE: http://www.ibm.com/developerworks/library/l-vim-script-2/

""" Helpers
function! CountLinesInRegister(reg, msg)
  let l = split(getreg(a:reg), '^.\{-}\zs\n')  " -- w/o,  '\n\zs' -- with
  let h = a:msg . len(l) . 'L> '
  let maxlen = min([ len(l[0]), &columns - len(h) - 13 ])
  echo h . substitute(l[0][0:l:maxlen], "\t", " ", 'g')
endfunction

function! GetVisualSelection(...)
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return a:0 >= 1 ? join(lines, a:1) : lines
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""

function! ShortestIndent(s1, s2)
  let m=strlen(a:s1) | let n=strlen(a:s2)
  return m == n ? 0 : m > n ? 1 : -1
endfunc

function! TrimLines(str)
  return substitute(a:str, '\v^\s*\_[ \t]\n?(.{-})\_[ \t\n]*$', '\1', 'g')
endfunction

function! TrimIndents(str,...)
  let tlst=map(split(a:str, '\n'), 'matchstr(v:val, "^\\s*")')
  " BUG: when lines are mixed tabs with spaces
  let tir=sort(l:tlst, "ShortestIndent")[0]
  let rgx='\v\_^' . l:tir . '(.{-})\s*\_$'
  let feach='substitute(v:val,"^'.l:tir.'","","")'
  return join(map(split(a:str, '\n'),l:feach), (a:0>0?a:1 :'')."\n")
  " return substitute(a:str, l:rgx, (a:0>0?a:1:'').'\1', 'g')
  " return l:tir
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""

function! CopyStringInReg(r1, str)
  call setreg('9',  a:r1,  'c') " Preserve previous buffer
  call setreg(a:r1, a:str, 'c')
  call CountLinesInRegister(a:r1, '@'.a:r1.':')
endfunction

function! GetLineBookmark(tid, text, ...)
  let path= a:0>=1 ? expand('%:p') : @%
  let tab="\t"
  "" Can't use, as values must be extracted from dst, not from src
  "repeat(&et ? repeat(" ", &ts) : "\t", a:tid)
  let prf= repeat(l:tab, a:tid)
  let str=l:prf . path . ":" . line(".")
  let str=l:str . (empty(a:text) ? "" : "\n" . l:prf . l:tab . a:text)
  call CopyStringInReg('+', l:str)
  " TODO: Add re-indenting of several lines (like 'for' or 'function' part)
  " NOTE: we can add mechanics to insert strings directly to file! or xmind.otl!
endfunction


" Be consistent with C and D which reach the end of line
nnoremap Y y$
" Prevent Paste loosing the register source. Deleted available by "- reg.
"   http://stackoverflow.com/a/7797434/1147859
vnoremap p pgvy
vnoremap P Pgvy
noremap  zp "0p
noremap  zP "0P

" Operator mappings
map <leader>y "+y
map <leader>p "+p
map <leader>P "+P
map <leader>l "+d
map <leader>L "+D
" Send shizzle to the black hole (Remove)
map <leader>r "_d
map <leader>R "_D

" Append to copy buffer
" nnoremap <leader><leader>y :<C-U>call CopyStringInReg('+', @+ . @")<CR>
vnoremap gy :<C-U>call CopyStringInReg('"', @" . GetVisualSelection("\n"))<CR>

" Duplicate unnamed and copy registers
nnoremap <C-y> :<C-U>call CopyStringInReg('+', @")<CR>
vnoremap <C-y> :<C-U>call CopyStringInReg('+', GetVisualSelection("\n"))<CR>
nnoremap <C-p> :<C-U>call CopyStringInReg('"', @+)<CR>
vnoremap <C-p> :<C-U>call CopyStringInReg('"', @+)<CR>gv"+P

nnoremap <leader><C-y> :<C-U>call CopyStringInReg('+', TrimLines(@"))<CR>
vnoremap <leader><C-y> :<C-U>call CopyStringInReg('+', TrimLines(GetVisualSelection("\n")))<CR>
nnoremap <leader><C-p> :<C-U>call CopyStringInReg('"', TrimLines(@+))<CR>
vnoremap <leader><C-p> :<C-U>call CopyStringInReg('"', TrimLines(@+))<CR>gv"+P

" Yank full line w/o newline and surrounded spaces
nnoremap <leader>Y mz^vg_:<C-U>call CopyStringInReg('+', GetVisualSelection("\n"))<CR>`z
" Copy from prompt ':' or '/'. Paste in them by <C-R>+ or <C-R>".
cnoremap <C-y> <C-R>=CopyStringInReg('+', getcmdline())<CR><C-H>
" To be able copy/paste regex snippets into vim/snippets/vim_regex.otl
nnoremap <leader><Space>/ :<C-U>call CopyStringInReg('+', @/)<CR>
vnoremap <leader><Space>/ :<C-U><C-R>=TrimLines(GetVisualSelection('\n')))<CR>
nnoremap <leader>/ :<C-U>call CopyStringInReg('/', @+)<CR>
noremap  <leader><Space>% :<C-U>call CopyStringInReg('+', @%)<CR>
" Open commandline with copied text
nnoremap <leader>; :<C-R>"
vnoremap <leader>; :<C-U><C-R>=GetVisualSelection(" ")<CR>


let s:leader = g:mapleader
let mapleader = "\\"
  nnoremap <leader>Y :<C-U>call GetLineBookmark(v:count,'')<CR>
  nnoremap <leader>t :<C-U>call GetLineBookmark(v:count1, TrimIndents(getline('.')))<CR>
  vnoremap <leader>t :<C-U>call GetLineBookmark(v:count1, TrimIndents(GetVisualSelection("\n"),"\t"))<CR>
let mapleader = s:leader

" UNUSED:
" Swap registry
" noremap  <M-c> :let @a=@" \| let @"=@+ \| let @+=@a \| reg "+<CR><CR>
"" Don't use paste in cmap as I use C-n, C-p for navigation in command line
"cmap <F7> <C-\>eescape(getcmdline(), ' \')<CR> "setreg(''+'', getreg('':''))
