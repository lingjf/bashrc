#!/usr/bin/env bash

if [[ $1 == "full" ]]; then
        git clone git://github.com/joelthelion/autojump.git autojump
        cd autojump && ./install.py && cd - && \rm -rf autojump
fi

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
