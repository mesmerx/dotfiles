let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
	echo "Installing Vundle.."
	echo ""
	silent !mkdir -p ~/.vim/bundle
	silent !git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
endif
set rtp+=~/.vim/bundle/Vundle.vim/

call vundle#begin()
source ~/.vim/config/vundleplugins.vim

call vundle#end()

