set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.

" tab对齐
Plugin 'godlygeek/tabular'
" 括号成对
Plugin 'chun-yang/auto-pairs'

" python对齐, pe8 格式
Plugin 'Vimjas/vim-python-pep8-indent'
" Python 语法高亮
Plugin 'hdima/python-syntax'

" markdown编辑器及其实时查看
Plugin 'plasticboy/vim-markdown'
Plugin 'suan/vim-instant-markdown'

" 前端emmet插件
Plugin 'mattn/emmet-vim'

" 语法检查
Plugin 'scrooloose/syntastic'

" 查看目录结构
Plugin 'scrooloose/nerdtree'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" 插件配置项


" 自定义
set expandtab                " 设置tab键换空格
set tabstop=4                " 设置tab键的宽度
set shiftwidth=4             " 换行时行间交错使用4个空格
set autoindent               " 自动对齐
set cindent shiftwidth=4     " 自动缩进4空格
set smartindent              " 智能自动缩进
set ai!                      " 设置自动缩进
set nu!                      " 显示行号
set incsearch                " 查找book时，当输入/b时会自动找到
set hlsearch                 " 开启高亮显示结果
set incsearch                " 开启实时搜索功能
set nowrapscan               " 搜索到文件两端时不重新搜索

" 设置ctags, vim在当前目录找不到tags文件时请到上层目录查找。
set tags=tags;/

let python_highlight_all = 1
syntax enable                " 打开语法高亮
syntax on                    " 开启文件类型侦测

set encoding=utf-8
 
" 映射键
inoremap jj <ESC>
" inoremap <space><space> <ESC>
noremap <C-j> <C-w>j<CR>
noremap <C-k> <C-w>k<CR>
noremap <C-h> <C-w>h<CR>
noremap <C-l> <C-w>l<CR>

" 设置 ctrl+n 打开目录结构
map <C-n> :NERDTreeToggle<CR>

"只有在是PHP文件时，才启用PHP补全
au FileType php call AddPHPFuncList()
function AddPHPFuncList()
    set dictionary-=$HOME/.vim/function.txt dictionary+=$HOME/.vim/function.txt
    set complete-=k complete+=k
endfunction

" ctrlp
set runtimepath^=~/.vim/bundle/ctrlp.vim

