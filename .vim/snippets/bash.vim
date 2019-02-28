" Bash snippets
augroup bash
    autocmd!
    autocmd FileType sh call <SID>snippets()
augroup END

function! s:snippets()
    inoreabbrev #! #!/bin/bash<CR>#<CR># A brief overview of script.<ESC>FA
endfunction

