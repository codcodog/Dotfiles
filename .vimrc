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
Plugin 'godlygeek/tabular'

Plugin 'plasticboy/vim-markdown'
Plugin 'suan/vim-instant-markdown'

Plugin 'mattn/emmet-vim'

Plugin 'scrooloose/syntastic'
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

syntax enable                " 打开语法高亮
syntax on                    " 开启文件类型侦测

set encoding=utf-8
 
inoremap jj <ESC>

"只有在是PHP文件时，才启用PHP补全
au FileType php call AddPHPFuncList()
function AddPHPFuncList()
    set dictionary-=$HOME/.vim/function.txt dictionary+=$HOME/.vim/function.txt
    set complete-=k complete+=k
endfunction

" ctrlp
set runtimepath^=~/.vim/bundle/ctrlp.vim

