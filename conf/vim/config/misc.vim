if has("autocmd")
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal g'\"" | endif
endif

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
autocmd BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} set ft=ruby

" add json syntax highlighting: deprecated. There are json-plugins
"autocmd BufNewFile,BufRead *.json set ft=javascript

" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
autocmd FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79


" The Vim Netrw plugin allows one to view the contents of an http hyperlink via CTRL-W_CTRL-F
" launch as $ agent tempfile url
let g:netrw_http_cmd = "elinks-for-vim"
" See: https://github.com/danchoi/elinks.vim
