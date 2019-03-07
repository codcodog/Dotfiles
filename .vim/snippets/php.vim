" PHP snippets
augroup php
    autocmd!
    autocmd FileType php call <SID>snippets()
augroup END

function! s:snippets()
    inoreabbrev <buffer> #s // ------------------------------------------------------------------------<ESC>
    inoreabbrev <buffer> @@ /** @var **/<ESC>3hi
    inoreabbrev <buffer> ??? <?php<CR>/**<CR>@Author Cryven<CR>@Date   <ESC>:r! date "+\%Y-\%m-\%d \%H:\%M:\%S"<CR>kJA<CR><ESC>S*/<CR><CR><ESC>
    inoreabbrev <buffer> if if () {<CR>}<ESC>kf)
    inoreabbrev <buffer> while while () {<CR>}<ESC>kf)
    inoreabbrev <buffer> switch switch () {<CR>}<ESC>Ocase word:<ESC>>>osomething;<ESC>obreak;<ESC>odefault:<ESC>osomething;<ESC>5k0f);
    inoreabbrev <buffer> foreach foreach ($result as $v) {<CR>}<ESC>kfr;
    inoreabbrev <buffer> for for ($i = 0; $i < $length; $i++) {<CR>}<ESC>kfi
    inoreabbrev <buffer> try try {<CR>}<ESC>Osomething;<ESC>ja catch (\Exception $e) {<CR>}<ESC>Osomething;<ESC>2k^
    inoreabbrev <buffer> function function name()<CR>{<CR>}<ESC>2k$Fn
endfunction
