" set liter for python
let g:ale_linters={'python': ['flake8', 'autopep8', 'mypy', 'pydocstyle'],'javascript':['prettier', 'eslint']}

"set fixer for python
let g:ale_fixers={'python': ['autopep8','remove_trailing_lines','yapf','isort'],'javascript': ['prettier', 'eslint', 'trim_whitespace','remove_trailing_lines']}

"set indent for python file
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab

"remove spaces in and of file for python
autocmd BufWritePre *.py %s/\s\+$//e

"run ctags for python files
autocmd BufWritePre *.py :!ctags -R --kinds-python=+l+m+c --sort=yes --languages=python

"add comamnd for run pytest with pipenv
command! PyTestEnv execute "!pipenv run pytest"

"add comamnd for run pytest
command! PyTest execute "!pipenv run pytest"

"set python highlight all syntax
let python_highlight_all=1

"call linter when save python
augroup write_cmd
    autocmd BufWritePre *.py call s:write_cmd('yapf')
augroup end
