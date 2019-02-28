" PHP snippets
augroup php
    autocmd!
    autocmd FileType php call <SID>snippets()
augroup END

function! s:snippets()
    inoreabbrev #s // ------------------------------------------------------------------------<ESC>
    inoreabbrev @@ /** @var **/<ESC>3hi
    inoreabbrev ??? <?php<CR>/**<CR>@Author Cryven<CR>@Date   <ESC>:r! date "+\%Y-\%m-\%d \%H:\%M:\%S"<CR>kJA<CR><ESC>S*/<CR><CR><ESC>
    inoreabbrev if if () {<CR>}<ESC>kf)
    inoreabbrev while while () {<CR>}<ESC>kf)
    inoreabbrev switch switch () {<CR>}<ESC>Ocase word:<ESC>>>osomething;<ESC>obreak;<ESC>odefault:<ESC>osomething;<ESC>5k0f);
    inoreabbrev foreach foreach ($result as $v) {<CR>}<ESC>kfr;
    inoreabbrev try try {<CR>}<ESC>Osomething;<ESC>ja catch (\Exception $e) {<CR>}<ESC>Osomething;<ESC>2k^
endfunction
