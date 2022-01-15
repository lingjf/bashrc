#!/usr/bin/env bash

if [[ $(uname) =~ "Darwin" ]]; then
        [[ -s ~/.zshrc ]] && sed -i '' '/github_lingjf_bashrc_git/d' ~/.zshrc
        [[ -s ~/.bashrc ]] && sed -i '' '/github_lingjf_bashrc_git/d' ~/.bashrc
else
        [[ -s ~/.zshrc ]] && sed -i '/github_lingjf_bashrc_git/d' ~/.zshrc
        [[ -s ~/.bashrc ]] && sed -i '/github_lingjf_bashrc_git/d' ~/.bashrc
fi

if [[ $SHELL == */zsh ]]; then
        echo "test -e $(pwd)/bashrc.sh && source $(pwd)/bashrc.sh #github_lingjf_bashrc_git" >>~/.zshrc
else
        echo "test -e $(pwd)/bashrc.sh && source $(pwd)/bashrc.sh #github_lingjf_bashrc_git" >>~/.bashrc
fi

if [[ $1 == "full" ]]; then
        git clone https://github.com/abishekvashok/cmatrix.git
        cd cmatrix && cmake . && make install

        git clone git://github.com/wting/autojump.git autojump
        cd autojump && ./install.py && cd - && \rm -rf autojump

        git clone https://github.com/andreafrancia/trash-cli.git trash-cli
        cd trash-cli && python setup.py install --user && cd - && \rm -rf trash-cli

        git clone git://github.com/mooz/percol.git percol
        cd percol && python setup.py install && cd - && \rm -rf percol
fi
