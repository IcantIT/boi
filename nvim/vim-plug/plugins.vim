" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'
    " NerdTree
    Plug 'preservim/nerdtree'
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'
    " Line theme
    Plug 'itchyny/lightline.vim'
    " Neovim theme
    Plug 'joshdick/onedark.vim'
    " Stable version of coc
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Colorizer
    Plug 'norcalli/nvim-colorizer.lua'

call plug#end()
