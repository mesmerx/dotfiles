"set type csv for that files
au! BufRead,BufNewFile *.csv,*.dat	setfiletype csv


"color csv by defaults
let g:csv_highlight_column='y'

"set custom colors for csv
hi CSVColumnEven term=bold ctermbg=4 guibg=DarkBlue
hi CSVColumnOdd  term=bold ctermbg=5 guibg=DarkMagenta
hi CSVColumnHeaderEven term=bold ctermbg=4 guibg=DarkBlue

hi CSVColumnHeaderOdd term=bold ctermbg=5 guibg=DarkMagenta

