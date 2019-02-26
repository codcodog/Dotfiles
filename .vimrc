"""""""""""""""""""""""""""""""""""""""""""""
" Cryven's vimrc
"
" Blog: https://github.com/codcodog/Blog/issues
" Note: 此配置仅为个人使用, 欢迎参考和交流.
" License: Vim License
"
"""""""""""""""""""""""""""""""""""""""""""""



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

" 源码函数列表
Plug 'vim-scripts/taglist.vim', {'on': 'TlistToggle'}

" fuzzy finding
Plug 'junegunn/fzf.vim'

" vue
Plug 'posva/vim-vue'

" theme
Plug 'morhetz/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }

" List ends here. Plugins become visible to Vim after this call.
call plug#end() 
"
" ============= Plug 配置 END =============



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
    autocmd WinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
    autocmd ColorScheme * highlight! link Visual CursorLine
    autocmd InsertEnter * highlight ColorColumn ctermbg=NONE guibg=#1a1b1d
    autocmd InsertLeave * highlight ColorColumn ctermbg=NONE guibg=NONE
    autocmd InsertEnter * let &colorcolumn=join(range(121, 999), ',')
    autocmd InsertLeave * let &colorcolumn=0
augroup END
"
" ============= Theme 配置 END =============



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
"
" ============= Options 配置 END =============



" ============= 缩写配置 START =============
"
iabbrev #s // ------------------------------------------------------------------------<ESC>
iabbrev ??? <?php<CR>/**<CR>@Author Cryven<CR>@Date   <ESC>:r! date "+\%Y-\%m-\%d \%H:\%M:\%S"<CR>kJA<CR><ESC>S*/<CR><CR><ESC>
iabbrev @@ /** @var **/<ESC>3hi
iabbrev #!! #!/usr/bin/env bash<CR><CR><ESC>
"
" ============= 缩写配置 END =============



" ============= 映射键 配置 START =============
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
cnoremap w!! <c-u>w !sudo tee > /dev/null %
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
exe "set <A-b>=\eb"
exe "set <A-f>=\ef"
cnoremap <A-b> <C-Left>
cnoremap <A-f> <C-Right>
tnoremap <Esc> <C-W>N
noremap <silent><C-]> :<C-u>MultiTag <C-r><C-w><CR>
"
" ============= 映射键 配置 END =============



" ============= <LEADER> 配置 START =============
"
let mapleader=','   " 设置 <leader> 键
noremap <silent> <leader>w :update<CR>
noremap <silent> <leader>o :only<CR>
noremap <silent> <leader>v :vsp<CR>
noremap <silent> <leader>s :sp<CR><C-W>k
noremap <silent> <leader>q :quit<CR>
noremap <silent> <leader>d :bw<CR>
vnoremap <silent> <leader>a :Tab/=<CR>
vnoremap <silent> <leader>> :Tab/=><CR>
noremap <silent> <leader>n :noh<CR>
noremap <silent> <leader>, :vsplit $MYVIMRC<CR>:normal 107Gzz<CR>
noremap <leader>. :source $MYVIMRC<CR>
noremap <silent> <leader>c :botright terminal ++rows=15<CR>

" fzf -> Ag
nnoremap <Leader>a :<C-u>Ag <C-r><C-w><CR>
" fzf -> History
noremap <silent> <leader>h :History<CR>
"
" ============= <LEADER> 配置 END ==============



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
    let cmd  = tmp[1]

    execute 'silent! e '.file.'|set ws|silent! '.cmd.'|normal! zz'
endfunction

" command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--ignore tags', {'options': '--delimiter : --nth 4..'}, <bang>0)
command! -bang -nargs=* Ag call fzf#vim#ag_raw(<q-args>, <bang>0)
"
" ============= 自定义命令配置 END =============



" ============= 插件配置 START =============
"
" fzf
set rtp+=~/.fzf
let g:fzf_layout = { 'down': '~20%' }

nnoremap <silent> <C-P> :Files<CR>
nnoremap <silent> <space><space> :Buffers<CR>

" NERDTree
noremap <silent> <C-n> :NERDTreeToggle<CR>
let g:NERDTreeQuitOnOpen = 1

" Taglist
let Tlist_Show_One_File           = 1           " To display the tags for only the current active buffer
let Tlist_Close_On_Select         = 1           " close the taglist window when a file or tag is selected
let Tlist_GainFocus_On_ToggleOpen = 1           " the cursor moves to the taglist window after opening the taglist window.
let Tlist_Auto_Update             = 1           " When a new file is edited, the tags defined in the file are automatically processed and added to the taglist
let tlist_php_settings            = 'php;c:class;f:function' " 仅显示函数和类，不显示变量
noremap <silent> <leader>t :TlistToggle<CR>

" Python-syntax
let python_highlight_all = 1
syntax enable                " 打开语法高亮
syntax on                    " 开启文件类型侦测

" indentLine 
let g:indentLine_enabled = 0 " 默认关闭
"
" ============= 插件配置 END =============



" ============= 自定义配置 START =============
"
" PHP 函数补全
function! s:AddPHPFuncListCodcodog()
    set dictionary-=$HOME/.vim/doc/function.txt dictionary+=$HOME/.vim/doc/function.txt
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

" Shell 文件，缩进修改为2个空格
augroup filetype_sh
    autocmd!
    autocmd FileType sh,yaml
                \ set tabstop=2 |
                \ set shiftwidth=2
augroup END

" python 文件，可视化缩进
augroup filetype_python
    autocmd!
    " indentLine 插件配置
    autocmd FileType python
                \ let g:indentLine_enabled=1 |
                \ let g:indentLine_char='·'
augroup END
"
" ============= 自定义配置 START =============
