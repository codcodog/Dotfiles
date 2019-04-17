" go snippets
augroup go
    autocmd!
    autocmd FileType go call <SID>snippets()
augroup END

function! s:snippets()
    inoreabbrev <buffer> ee if err != nil {<CR>}<ESC>kfe
    inoreabbrev <buffer> pp fmt.Println()<ESC>
endfunction
