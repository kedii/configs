" using only git
let g:signify_vcs_list = [ 'git' ]
let g:signify_sign_change = '~'
let g:signify_sign_delete = '-'


let g:signify_mapping_next_hunk = '<leader>gj'
let g:signify_mapping_prev_hunk = '<leader>gk'
let g:signify_mapping_toggle_highlight = '<leader>gh'


" " highlight lines in Sy and vimdiff etc.)
"
" highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
" highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
" highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
"
" " highlight signs in Sy
"
" highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
" highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
" highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

highlight clear SignifySignAdd    ctermbg=237
highlight clear SignifySignDelete ctermbg=237
highlight clear SignifySignChange ctermbg=237
