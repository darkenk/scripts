#!/bin/bash
# Copyright (C) 2014, Dariusz Kluska <darkenk@gmail.com>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice, this
# list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright notice,
# this list of conditions and the following disclaimer in the documentation
# and/or other materials provided with the distribution.
#
# * Neither the name of the {organization} nor the names of its
# contributors may be used to endorse or promote products derived from
# this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

dir=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)

# install .vimrc
if [ ! -e ~/.vimrc ]; then
    ln -s ${dir}/vimrc ~/.vimrc
fi

#install pathogen
if [ ! -e ~/.vim/autoload ]; then
    mkdir -p ~/.vim
    git clone https://github.com/tpope/vim-pathogen.git ~/.vim/vim-pathogen
    ln -s ~/.vim/vim-pathogen/autoload ~/.vim/autoload
fi

#install YouCompleteMe
if [ ! -e ~/.vim/bundle/YouCompleteMe ]; then
    mkdir -p ~/.vim/bundle
    git clone https://github.com/Valloric/YouCompleteMe.git ~/.vim/bundle/YouCompleteMe
    cd ~/.vim/bundle/YouCompleteMe
    git submodule update --init --recursive
    ./install.sh --clang-completer
    cd -
fi

#install vim-better-whitespace
if [ ! -e ~/.vim/bundle/vim-better-whitespace ]; then
    git clone https://github.com/ntpeters/vim-better-whitespace.git ~/.vim/bundle/vim-better-whitespace
fi

#install vim-gitgutter
if [ ! -e ~/.vim/bundle/vim-gitgutter ]; then
    git clone https://github.com/airblade/vim-gitgutter.git ~/.vim/bundle/vim-gitgutter
fi

#install nerdtree
if [ ! -e ~/.vim/bundle/nerdtree ]; then
    git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
fi

#install zenburn
if [ ! -e ~/.vim/colors/zenburn.vim ]; then
    mkdir -p ~/.vim/colors/
    git clone https://github.com/jnurmine/Zenburn.git ~/.vim/bundle/zenburn
    ln -s ~/.vim/bundle/zenburn/colors/zenburn.vim ~/.vim/colors/zenburn.vim
fi

#install vim-cpp-enganced-highlight
if [ ! -e ~/.vim/bundle/syntax/vim-cpp-enhanced-highlight ]; then
    mkdir -p ~/.vim/bundle/syntax/
    git clone https://github.com/octol/vim-cpp-enhanced-highlight.git ~/.vim/bundle/syntax/vim-cpp-enhanced-highlight
fi

#install vim-indent-guides # currently not working, instead of it use next plugin
#if [ ! -e ~/.vim/bundle/vim-indent-guides ]; then
#    git clone https://github.com/nathanaelkane/vim-indent-guides.git ~/.vim/bundle/vim-indent-guides
#fi

# install indentLine
if [ ! -e ~/.vim/bundle/indentLine ]; then
    git clone https://github.com/Yggdroot/indentLine.git ~/.vim/bundle/indentLine
fi

# Install vim autoindent detection
if [ ! -e ~/.vim/bundle/vim-sleuth ]; then
    git clone https://github.com/tpope/vim-sleuth.git ~/.vim/bundle/vim-sleuth
fi

# Install solarized
if [ ! -e ~/.vim/bundle/vim-colors-solarized ]; then
    git clone git://github.com/altercation/vim-colors-solarized.git ~/.vim/bundle/vim-colors-solarized
fi
