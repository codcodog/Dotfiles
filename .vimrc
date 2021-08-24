"""""""""""""""""""""""""""""""""""""""""""""
" Cryven's vimrc
"
" Copyright (c) 2019 Cryven Codcodog
"
" Note: 此配置仅为个人使用, 欢迎参考和交流.
" License: Vim License
"
"""""""""""""""""""""""""""""""""""""""""""""
"
"
"
" ============= Plug 配置 END =============
"
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" tab对齐
Plug 'godlygeek/tabular'

" 括号成对
Plug 'chun-yang/auto-pairs'

" Python 语法高亮
Plug 'hdima/python-syntax', {'for': 'python'}
" Python 缩进
Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}
" Python 查看缩进
Plug 'Yggdroot/indentLine'

" markdown编辑器及其实时查看
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}

" 前端emmet插件
Plug 'mattn/emmet-vim', {'for': ['html', 'vue']}

" 查看目录结构
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}

" 函数列表
Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}

" fuzzy finding
Plug 'junegunn/fzf.vim'

" vue
Plug 'posva/vim-vue'

Plug 'SirVer/ultisnips'

" theme
Plug 'morhetz/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }

" go
Plug 'fatih/vim-go', {'for': 'go'}

Plug 'Valloric/YouCompleteMe'
"
" List ends here. Plugins become visible to Vim after this call.
call plug#end() 
"
" ============= Plug 配置 END =============
"
"
"
" ============= Theme 配置 START ==========
"
set termguicolors
syntax on

syntax sync minlines=50
set synmaxcol=300  " stop syntax highlighting this many columns out
nnoremap <silent> <F5> :syntax sync fromstart<CR>

let g:gruvbox_contrast_dark = 'hard'
set background=dark
colorscheme gruvbox

" 覆盖 gruvbox 主题颜色设置
augroup DIY
    autocmd!
    autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=#1d1f21
    autocmd ColorScheme * highlight CursorLine ctermbg=NONE guibg=#26292b
    autocmd WinEnter    * setlocal cursorline
    autocmd WinLeave    * setlocal nocursorline
    autocmd ColorScheme * highlight! link Visual CursorLine
    autocmd InsertEnter * highlight ColorColumn ctermbg=NONE guibg=#1a1b1d
    autocmd InsertLeave * highlight ColorColumn ctermbg=NONE guibg=NONE
    autocmd InsertEnter * let &colorcolumn=join(range(121, 999), ',')
    autocmd InsertLeave * let &colorcolumn=0
augroup END
"
" ============= Theme 配置 END =============
"
"
"
" ============= Options 配置 START =============
"
set expandtab                " 设置tab键换空格
set tabstop=4                " 设置tab键的宽度
set encoding=utf-8           " 设置字符编码
set shiftwidth=4             " 换行时行间交错使用4个空格
set autoindent               " 自动对齐
set cindent                  " 自动缩进4空格
set smartindent              " 智能自动缩进
set number                   " 设置行号
set rnu                      " 相对行号
set hlsearch                 " 开启高亮显示结果
set noincsearch              " 不实时查找
set wrapscan                 " 查找到底部重新回到头部
set tags=tags;/              " 设置ctags, vim在当前目录找不到tags文件时请到上层目录查找。
set splitright               " 设置vsplit在右边
set laststatus=2             " 总是显示状态栏
set directory=/tmp           " 设置swp文件存储目录
set cscopetag                " 开启 cscope
set cursorline               " 高亮当前行

set statusline=%t                                           " 文件名
set statusline+=%4m%r%w                                     " modified flag, Modified, Readonly ?
set statusline+=%=                                          " 切换到右边
set statusline+=%{toupper(&ff).'·'}                         " file format
set statusline+=%{toupper(strlen(&fenc)?&fenc:'none')}      " file encoding
set statusline+=%8(%l,%c%)                                  " line and column
set statusline+=%5P                                         " Percentage through file of displayed window
set maxmempattern=9999
"
" ============= Options 配置 END =============
"
"
"
" =============  BASIC 映射键 配置 START =============
inoremap jj <ESC>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
noremap <C-j> <C-w>j<CR>
noremap <C-k> <C-w>k<CR>
noremap <C-h> <C-w>W<CR>
noremap <C-l> <C-w>w<CR>
nnoremap <Left> :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>
nnoremap <Up> :resize -2<CR>
nnoremap <Down> :resize +2<CR>
cnoremap w!! <c-u>w !sudo tee > /dev/null %<CR>
cnoremap jf <c-u>%!python -m json.tool<CR>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
exe "set <A-b>=\eb"
exe "set <A-f>=\ef"
cnoremap <A-b> <C-Left>
cnoremap <A-f> <C-Right>
tnoremap <ESC> <C-W>N
noremap <silent><C-]> :<C-u>MultiTag <C-r><C-w><CR>
noremap <silent><C-p> <C-x><C-o>
vnoremap cc "+y
"
" ============= BASIC 映射键 配置 END =============
"
"
"
" ============= <LEADER> 配置 START =============
"
let mapleader=','   " 设置 <leader> 键
noremap <silent> <leader>w :update<CR>
noremap <silent> <leader>o :only<CR>
noremap <silent> <leader>v :vsp<CR>
noremap <silent> <leader>s :sp<CR><C-W>k
noremap <silent> <leader>q :quit<CR>
noremap <silent> <leader>d :bw<CR>
noremap <silent> <leader>n :noh<CR>
noremap <silent> <leader>, :vsplit $MYVIMRC<CR>:normal 107Gzz<CR>
noremap <leader>. :source $MYVIMRC<CR>
noremap <silent> <leader>c :botright terminal<CR>
"
" ============= <LEADER> 配置 END ==============
"
"
"
" ============= 自定义命令配置 START =============
"
" buffers management
command! Only  call <SID>OnlyCurrentBufferCodcodog()

" dependent on fzf plugin
command! -bang -nargs=* MultiTag call <SID>multitag(<q-args>)

function! s:multitag(query)
    let pattern = '^'.a:query.'$'
    let tags    = taglist(pattern)
    let qfl     = []

    " only one tag name
    if (len(tags) == 1)
        silent execute 'silent! tag '.a:query.'|normal! zz'
        return
    " no tags
    elseif (len(tags) == 0)
        echohl WarningMsg
        echo 'Tags Not Found.'
        echohl None
        return
    endif

    " multiple tag names
    for tag in tags
        let filename = tag['filename']
        let pattern  = tag['cmd']
        let des      = filename . '|' . pattern

        call add(qfl, des)
    endfor

    call fzf#run({'source': qfl, 'sink': function('s:tagsink'), 'down': '~20%'})
endfunction

function! s:tagsink(tag)
    let tmp  = split(a:tag, '|')
    let file = tmp[0]
    " 关闭 pattern magic, 防止函数有特殊字符没法匹配，例如：`* .` 这些字符
    let cmd  = '/\M'.tmp[1][1:]
    echom cmd

    execute 'silent! e '.file.'|set ws|silent! '.cmd.'|normal! zz'
endfunction

" command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--ignore tags', {'options': '--delimiter : --nth 4..'}, <bang>0)
command! -bang -nargs=* Ag call fzf#vim#ag_raw(<q-args>, <bang>0)
"
" ============= 自定义命令配置 END =============
"
"
"
" ============= 插件配置 START =============
"
" tabular
vnoremap <silent> <leader>a :Tab/=<CR>
vnoremap <silent> <leader>> :Tab/=><CR>

" fzf
set rtp+=~/.fzf

if executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -U -g ""'
endif

let g:fzf_layout = { 'down': '~20%' }
nnoremap <Leader>a :<C-u>Ag -U -w <C-r><C-w><CR>
nnoremap <silent> <leader>h :History<CR>
nnoremap <Leader>m :Marks<CR>
nnoremap <silent> <C-P> :Files<CR>
nnoremap <silent> <space><space> :Buffers<CR>

" NERDTree
let g:NERDTreeQuitOnOpen = 1
let NERDTreeShowLineNumbers = 1
noremap <silent> <C-n> :NERDTreeToggle<CR>

" tagbar
let g:tagbar_left = 0
let g:tagbar_autoclose = 1
let g:tagbar_show_linenumbers = 2
let g:tagbar_sort = 0
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

noremap <silent> <leader>t :TagbarToggle<CR>
noremap <silent> <leader>f :BTags<CR>

" Python-syntax
let python_highlight_all = 1
syntax enable                " 打开语法高亮
syntax on                    " 开启文件类型侦测

" indentLine 
let g:indentLine_enabled = 0 " 默认关闭

" golang
let g:go_fmt_command = "goimports"
let g:go_gopls_complete_unimported = 1

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1

let g:go_def_mapping_enabled = 0
let g:go_def_mode = 'gopls'
" let g:go_debug=['lsp']

au FileType go noremap <silent> gd :GoDef<CR>
au FileType go inoremap <silent> <C-j> <ESC>3b:<C-u>GoImport <C-r><C-w><CR>zz3ea
au FileType go cnoremap GG <C-u>GoImport 

" YCM
set completeopt=longest,menu
let g:ycm_auto_hover=''
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_filetype_blacklist = {
      \ 'tagbar' : 1,
      \ 'nerdtree' : 1,
      \}
let g:ycm_auto_trigger = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_key_invoke_completion = '<C-o>'
"let g:ycm_collect_identifiers_from_comments_and_strings = 1

" UltiSnips 
let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/mysnippets']
"
" ============= 插件配置 END =============
"
"
"
" ============= 自定义配置 START =============
"
" 字典补全
set dictionary+=$HOME/.vim/doc/dict.txt
set complete+=k

" PHP 函数补全
function! s:AddPHPFuncListCodcodog()
    set dictionary-=$HOME/.vim/doc/php.txt dictionary+=$HOME/.vim/doc/php.txt
    set complete-=k complete+=k
endfunction

" golang 补全
function! s:GoCompletionCodcodog()
    set dictionary-=$HOME/.vim/doc/go.txt dictionary+=$HOME/.vim/doc/go.txt
    set complete-=k complete+=k
endfunction

" python 补全
function! s:PythonCompletionCodcodog()
    set dictionary-=$HOME/.vim/doc/python.txt dictionary+=$HOME/.vim/doc/python.txt
    set complete-=k complete+=k
endfunction

" 保留当前可见 buffer, wipe out 其他不可见 buffers
function! s:OnlyCurrentBufferCodcodog()
    " list of *all* buffer numbers
    let l:buffers = range(1, bufnr('$'))

    " what tab page are we in?
    let l:currentTab = tabpagenr()
    try
        " go through all tab pages
        let l:tab = 0
        while l:tab < tabpagenr('$')
            let l:tab += 1

            " go through all windows
            let l:win = 0
            while l:win < winnr('$')
                let l:win += 1
                " whatever buffer is in this window in this tab, remove it from
                " l:buffers list
                let l:thisbuf = winbufnr(l:win)
                call remove(l:buffers, index(l:buffers, l:thisbuf))
            endwhile
        endwhile

        " if there are any buffers left, delete them
        if len(l:buffers)
            execute 'bwipeout' join(l:buffers)
        endif
    finally
        " go back to our original tab page
        execute 'tabnext' l:currentTab
    endtry
endfunction

" PHP 文件，启用补全
augroup filetype_php
    autocmd!
    autocmd FileType php call <SID>AddPHPFuncListCodcodog()
augroup END 

augroup filetype_go
    autocmd!
    autocmd FileType go call <SID>GoCompletionCodcodog()
augroup END 

" Shell 文件，缩进修改为2个空格
augroup filetype_sh
    autocmd!
    autocmd FileType sh,yaml
                \ set tabstop=2 |
                \ set shiftwidth=2
augroup END

" python 文件，可视化缩进
" 加载补全
augroup filetype_python
    autocmd!
    " indentLine 插件配置
    autocmd FileType python
                \ let g:indentLine_enabled=1 |
                \ let g:indentLine_char='·'
    autocmd FileType python call <SID>PythonCompletionCodcodog()
augroup END
"
" ============= 自定义配置 START =============
