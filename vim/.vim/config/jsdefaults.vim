
"hidde quotes for json files
command! JsonHiddenQuotes execute "set conceallevel=2"

"show quotes for json files
command! JsonShowQuotes execute "set conceallevel=0"

"set the indent for js files
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab

"set typescript as tsx
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx


" dark red
hi tsxTagName guifg=#E06C75

" orange
hi tsxCloseString guifg=#F99575
hi tsxCloseTag guifg=#F99575
hi tsxCloseTagName guifg=#F99575
hi tsxAttributeBraces guifg=#F99575
hi tsxEqual guifg=#F99575

" yellow
hi tsxAttrib guifg=#F8BD7F cterm=italic
