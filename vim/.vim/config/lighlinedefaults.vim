
let g:lightline = {}

"expand lightline to add linter
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

 let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }


"set what lightline will show
let g:lightline.active = {'left': [ ['mode', 'paste' ],[ 'gitbranch', 'readonly', 'relativepath', 'modified' ] ] ,
            \             'right': [[ 'lineinfo' ],[ 'percent' ],
            \                       [ 'fileformat', 'fileencoding', 'filetype' ],
            \                       [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]] }


"refresh status
augroup MyGutentagsStatusLineRefresher
    autocmd!
    autocmd User GutentagsUpdating call lightline#update()
    autocmd User GutentagsUpdated call lightline#update()
augroup END
