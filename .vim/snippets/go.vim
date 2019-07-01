" go snippets
augroup go
    autocmd!
    autocmd FileType go call <SID>snippets()
augroup END

function! s:snippets()
    inoreabbrev <buffer> ee if err != nil {<CR>}<ESC>kfe
    inoreabbrev <buffer> pp fmt.Println()<ESC>
    inoreabbrev <buffer> exit os.Exit(1)<ESC>h
    inoreabbrev <buffer> debug fmt.Println()<CR>os.Exit(1)<ESC>kf)
endfunction
