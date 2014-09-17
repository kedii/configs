set foldenable
"set foldmethod=manual syntax  syntax defines folds
set foldlevelstart=99 " close folds below this depth, initially
"set foldopen=all

" Слева появится колонка шириной в 3 символа, обозначающая где какие фолдинги и какого уровня.
" По ней можно будет кликать для сворачивания-разворачивания.
set foldcolumn=2

" Concealing
set concealcursor=cv " hide in command and visual modes.
" concealed text is completely hidden unless it has a custom replacement character defined.
set conceallevel=2

" Тут есть как сделать мануальный и автоматический фолдинг одновременно
"  http://vim.wikia.com/wiki/Folding