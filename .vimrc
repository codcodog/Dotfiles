set nocompatible             " 禁止vim在vi兼容模式
filetype off                 " required

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

" Python 语法高亮
Plugin 'hdima/python-syntax'
" Python 缩进
Plugin 'hynek/vim-python-pep8-indent'

" markdown编辑器及其实时查看
Plugin 'plasticboy/vim-markdown'
Plugin 'suan/vim-instant-markdown'

" 前端emmet插件
Plugin 'mattn/emmet-vim'

" 查看目录结构
Plugin 'scrooloose/nerdtree'
" 源码函数列表
Plugin 'taglist.vim'

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

" ============= Options 配置 START =============
"
set expandtab                " 设置tab键换空格
set tabstop=4                " 设置tab键的宽度
set encoding=utf-8           " 设置字符编码
set shiftwidth=4             " 换行时行间交错使用4个空格
set autoindent               " 自动对齐
set cindent                  " 自动缩进4空格
set smartindent              " 智能自动缩进
set ai!                      " 设置自动缩进
set nu!                      " 显示行号
set incsearch                " 查找book时，当输入/b时会自动找到
set hlsearch                 " 开启高亮显示结果
set incsearch                " 开启实时搜索功能
set nowrapscan               " 搜索到文件两端时不重新搜索
set encoding=utf-8           " 设置字符编码
set tags=tags;/              " 设置ctags, vim在当前目录找不到tags文件时请到上层目录查找。
set laststatus=2             " 总是显示状态栏
set splitright               " 设置vsplit在右边
set autochdir                " 设置当前目录路径为当前文件目录路径, 或者可以使用：:cd %:p:h
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
cnoremap w!! w !sudo tee > /dev/null %
"
" ============= 映射键 配置 END =============


" ============= <LEADER> 配置 START =============
"
let mapleader=','   " 设置 <leader> 键
noremap <leader>o :only<CR>
noremap <leader>v :vsp<CR>
noremap <leader>s :sp<CR><C-W>k
noremap <leader>q :quit<CR>
noremap <leader>p "+p
noremap <leader>] :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
"
" ============= <LEADER> 配置 END ==============


" ============= 插件配置 START =============
"
" Ctrlp
noremap <space><space> :CtrlPBuffer<CR>
set runtimepath^=~/.vim/bundle/ctrlp.vim

" NERDTree
noremap <C-n> :NERDTreeToggle<CR>
let g:NERDTreeQuitOnOpen = 1

" Taglist
let Tlist_Show_One_File           = 1           " To display the tags for only the current active buffer
let Tlist_Close_On_Select         = 1           " close the taglist window when a file or tag is selected
let Tlist_GainFocus_On_ToggleOpen = 1           " the cursor moves to the taglist window after opening the taglist window.
let Tlist_Auto_Update = 1                       " When a new file is edited, the tags defined in the file are automatically processed and added to the taglist
noremap <leader>t :TlistToggle<CR>

" Python-syntax
let python_highlight_all = 1
syntax enable                " 打开语法高亮
syntax on                    " 开启文件类型侦测
"
" ============= 插件配置 END =============


" 只有在是PHP文件时，才启用补全
au FileType php call AddPHPFuncList()
function AddPHPFuncList()
    set dictionary-=$HOME/.vim/doc/function.txt dictionary+=$HOME/.vim/doc/function.txt
    set complete-=k complete+=k
endfunction
