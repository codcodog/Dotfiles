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

" markdown编辑器及其实时查看
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}

" 前端emmet插件
Plug 'mattn/emmet-vim', {'for': 'html'}

" 查看目录结构
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}

" 源码函数列表
Plug 'vim-scripts/taglist.vim', {'on': 'TlistToggle'}

" fuzzy finding
Plug 'junegunn/fzf.vim'

" List ends here. Plugins become visible to Vim after this call.
call plug#end() 
"
" ============= Plug 配置 END =============


" ============= Options 配置 START =============
"
set expandtab                " 设置tab键换空格
set tabstop=4                " 设置tab键的宽度
set encoding=utf-8           " 设置字符编码
set shiftwidth=4             " 换行时行间交错使用4个空格
set autoindent               " 自动对齐
set cindent                  " 自动缩进4空格
set smartindent              " 智能自动缩进
set number                   " 显示行号
set incsearch                " 查找book时，当输入/b时会自动找到
set hlsearch                 " 开启高亮显示结果
set incsearch                " 开启实时搜索功能
set nowrapscan               " 搜索到文件两端时不重新搜索
set tags=tags;/              " 设置ctags, vim在当前目录找不到tags文件时请到上层目录查找。
set splitright               " 设置vsplit在右边
set laststatus=2             " 总是显示状态栏
set directory=/tmp           " 设置swp文件存储目录

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
iabbrev #s // ------------------------------------------------------------------------<CR><ESC>
iabbrev !- <!--more-->
"
" ============= 缩写配置 END =============


" ============= 映射键 配置 START =============
"
inoremap jj <ESC>
noremap <C-j> <C-w>j<CR>
noremap <C-k> <C-w>k<CR>
noremap <C-h> <C-w>W<CR>
noremap <C-l> <C-w>w<CR>
nnoremap <Left> :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>
nnoremap <Up> :resize -2<CR>
nnoremap <Down> :resize +2<CR>
cnoremap w!! <c-u>w !sudo tee > /dev/null %
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
"
" ============= <LEADER> 配置 END ==============


" ============= 插件配置 START =============
"
" fzf
set rtp+=~/.fzf
let g:fzf_layout = { 'down': '~20%' }
nnoremap <silent> <C-P> :Files<CR>
nnoremap <silent> <space><space> :Buffers<CR>

" fzf -> Ag
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)
nnoremap <silent> <Leader>a :Ag<CR>

" NERDTree
noremap <silent> <C-n> :NERDTreeToggle<CR>
let g:NERDTreeQuitOnOpen = 1

" Taglist
let Tlist_Show_One_File           = 1           " To display the tags for only the current active buffer
let Tlist_Close_On_Select         = 1           " close the taglist window when a file or tag is selected
let Tlist_GainFocus_On_ToggleOpen = 1           " the cursor moves to the taglist window after opening the taglist window.
let Tlist_Auto_Update = 1                       " When a new file is edited, the tags defined in the file are automatically processed and added to the taglist
noremap <silent> <leader>t :TlistToggle<CR>

" Python-syntax
let python_highlight_all = 1
syntax enable                " 打开语法高亮
syntax on                    " 开启文件类型侦测
"
" ============= 插件配置 END =============


" ============= 自定义配置 START =============
"
" PHP 函数补全
function! s:AddPHPFuncListCodcodog()
    set dictionary-=$HOME/.vim/doc/function.txt dictionary+=$HOME/.vim/doc/function.txt
    set complete-=k complete+=k
endfunction

" PHP 文件，启用补全
augroup filetype_php
    autocmd!
    autocmd FileType php call <SID>AddPHPFuncListCodcodog()
augroup END 

" python 文件的，缩进折叠
augroup filetype_python
    autocmd!
    autocmd FileType python setlocal foldmethod=indent
augroup END
"
" ============= 自定义配置 START =============
