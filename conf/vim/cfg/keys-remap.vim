" Now 'a jump you to line and column, and `a only to line
noremap <unique> ' `
noremap <unique> ` '
" noremap , <Nop>

" Pinky stretching soothing
cnoremap <unique> <C-o> <C-p>

" Faster $3 ex-cmds
noremap <unique> ;  :

" Move to <next|prev> [qf|loc] entry
noremap <unique> ]q :<C-U><C-R>=v:count1<CR>cnext!<CR>
noremap <unique> [q :<C-U><C-R>=v:count1<CR>cprevious!<CR>
noremap <unique> ]l :<C-U><C-R>=v:count1<CR>lnext!<CR>
noremap <unique> [l :<C-U><C-R>=v:count1<CR>lprevious!<CR>

" Show list of tags when there more then one entry:
noremap <unique> g] g<C-]>
noremap <unique> g<C-]> g]
noremap <unique> g[ :<C-U><C-R>=v:count1<CR>tnext<CR>
" noremap <C-]> g<C-]>
" ALSO:  Use [I or ]I -- to show matches of current work in this file

" No jump when joining
" nnoremap J mzJ`z

" Insert empty line before/after
noremap <unique> gO O <C-U><Esc>
noremap <unique> go o <C-U><Esc>

" Adequate replace tabs by parts, not entirely
noremap <unique> R gR

" history-window (when you mistakes) now on 'gq:'
" Use q for formatting the current paragraph (or selection)
" Ex-command availible by gQ
noremap <unique> ,q q

" retain relative cursor position when paging
nnoremap <unique> <PageUp>   <C-U>
nnoremap <unique> <PageDown> <C-D>

" swap vertical line motions with wrapped text
noremap <unique> j gj
noremap <unique> k gk
noremap <unique> gj j
noremap <unique> gk k

" more stretching comfort
noremap <unique> g0 ^
noremap <unique> ,4 $
noremap <unique> g4 A<Space><Esc>
noremap <unique> ,g %
" Swap v and CTRL-V was pitiful idea
noremap <unique> ,v  <C-V>

" Unused
" map - $
" map # %

"" VISUAL
"" select last paste in visual mode
noremap <unique> <expr> gv '`[' . strpart(getregtype(), 0, 1) . '`]'
" selects the last text edited/pasted in INSERT, and reselect of last VISUAL
noremap <unique> gV `[v`]
" visually select a search result (default: 'gn, gN' -- much better!)
nnoremap <unique> z/ //e<CR>v??<CR>
" reselect visual block after indent
vnoremap <unique> < <gv
vnoremap <unique> > >gv

" Visual block sorting. Restore text _outside_ block:  gvyugvp
command! -range VBSort <line1>,<line2>sort i /\ze\%V/

" works cool only with xkb map of arrows to C-hjkl
" nnoremap <C-PageUp>    <Esc>:tabprev<CR>
" nnoremap <C-PageDown>  <Esc>:tabnext<CR>
" nnoremap [t <Esc>:tabprev<CR>
" nnoremap ]t <Esc>:tabnext<CR>

" use Alt-Left and Alt-Right to move current tab to left or right
" nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
" nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>

" Tab is Next window
" nnoremap <Tab> <C-W>w
" nnoremap <S-Tab> <C-W>W
