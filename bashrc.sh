#coding=utf-8

echo "https://github.com/lingjf/bashrc.git"

# 30 设置黑色前景
# 31 设置红色前景
# 32 设置绿色前景
# 33 设置棕色前景
# 34 设置蓝色前景
# 35 设置紫色前景
# 36 设置青色前景
# 37 设置白色前景
# 40 设置黑色背景
# 41 设置红色背景
# 42 设置绿色背景
# 43 设置棕色背景
# 44 设置蓝色背景
# 45 设置紫色背景
# 46 设置青色背景
# 47 设置白色背景

function prompt_symbol() {
        # echo "♩ ♪ ♫ ♬ ♭ "
        # echo "☯ ⚛ ☢ ☣ ☠ ☺ "
        # echo "☪ ☭ "
        # echo "↓ ↑ ← → ↖ ↘ ↗ ↙ ✎ ✏ ✐ ➤ "
        # echo "♂ ♀ "
        # echo "⅓ ⅔ "
        # echo "╳ ╱ ╲ │ ┆ ┊ ‖ ∥ ∵ ∷ … ‥ "
        # echo "㊣⊕※¤⊙◎◢◣◤◥□■◇◆△▲▽▼○●★☆"
        # echo "▁▂▃▄▅▆▇█▉▊▋▌▍▎〓━"
        # echo "āáǎà ōóǒò ēéěè īíǐì ūúǔù ǖǘǚǜ ü ê ń ň"
        # echo "⒈ ⒉ ⒊ ⒋ ⒌ ⒍ ⒎ ⒏ ⒐ ⒑ ⒒ ⒓ ⒔ ⒕ ⒖ ⒗ ⒘ ⒙ ⒚ ⒛ "
        # echo "⑴ ⑵ ⑶ ⑷ ⑸ ⑹ ⑺ ⑻ ⑼ ⑽ ⑾ ⑿ ⒀ ⒁ ⒂ ⒃ ⒄ ⒅ ⒆ ⒇ "
        # echo "＄￥￠￡"
        # echo "℃ ㎜ ㎝ ㎡ ㎏ 〒 ℉ ㏕ ㎎ ㏄ ○"
        # echo "αβγδεζηθικλμνξοπρστυφχψω"
        # echo "√×÷± ≈≠ ≌≡ ≦≧ ≤≥ ≮≯ ∧∨ ∑∏∫∬∮ ∝∞ ∊∍∈∋∃ ⌒ ∪ ㏒ ㏑"
        echo "➤"
}

function today_week() {
        # weeks="①②③④⑤⑥⑦⑧⑨⑩"
        # weeks="❶❷❸❹❺❻❼❽❾❿"
        weeks="㈠㈡㈢㈣㈤㈥㈦㈧㈨㈩"
        echo ${weeks:$(date +"%u")-1:1}
}

if [[ $SHELL == */zsh ]]; then
        PROMPT='$(today_week)%* %~%{$fg_bold[red]%}$(prompt_symbol)%{$reset_color%} '
        #如果连续输入的命令相同，历史纪录中只保留一个
        setopt HIST_IGNORE_DUPS
        setopt HIST_IGNORE_ALL_DUPS
else
        export PS1='$(today_week)\t ${USER} \w\[\e[0;32;40m\]$(prompt_symbol)\[\e[0m\] '
fi

export HISTCONTROL=ignoreboth #erasedups:ignorespace
export HISTIGNORE="pwd:ls:ll:cd:history:uname:"

#历史纪录条目数量
export HISTSIZE=10000
#注销后保存的历史纪录条目数量
export SAVEHIST=10000
#以附加的方式写入历史纪录
#setopt INC_APPEND_HISTORY
#为历史纪录中的命令添加时间戳
#setopt EXTENDED_HISTORY
#setopt AUTO_PUSHD
#相同的历史路径只保留一个
#setopt PUSHD_IGNORE_DUPS

[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && source ~/.autojump/etc/profile.d/autojump.sh

############################################################
# cd

function up() {
        if [ -z $(echo $1 | sed 's/[0-9]//g') ]; then
                let n=$1
        else
                n=$(echo $1 | sed 's/[^.]//g' | wc -c)
                let n=n-2
        fi

        case $n in
        0) ;;
        1) cd .. ;;
        2) cd ../.. ;;
        3) cd ../../.. ;;
        4) cd ../../../.. ;;
        5) cd ../../../../.. ;;
        6) cd ../../../../../.. ;;
        7) cd ../../../../../../.. ;;
        8) cd ../../../../../../../.. ;;
        9) cd ../../../../../../../../.. ;;
        *)
                while [ $n -gt 0 ]; do
                        cd ..
                        let n=n-1
                done
                ;;
        esac
}
alias ..='up 1'
alias ...='up 2'
alias ....='up 3'
alias .....='up 4'
alias ......='up 5'
alias .......='up 6'
alias ........='up 7'
alias .........='up 8'
alias ..........='up 9'
alias cd..='up 1'
alias cd...='up 2'
alias cd....='up 3'
alias cd.....='up 4'
alias cd......='up 5'
alias cd.......='up 6'
alias cd........='up 7'
alias cd.........='up 8'
alias cd..........='up 9'

############################################################
# rm
if [[ $(uname) =~ "Darwin" ]]; then
        alias r='rmtrash'
elif [[ $(uname) =~ "Linux" ]]; then
        alias xclip='xclip -selection clipboard'
        function r() {
                trash-put $1
                trash-empty 7
        }
else
        echo ""
fi

export PATH=$(pwd):$PATH

alias m='make -j 4'
alias py=python
alias p2=python
alias p3=python3

############################################################
# git
alias git='LANG=en_GB git'

function gst() {
        git status
}

function gbr() {
        git branch
}

function glg() {
        git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
}

function gls() {
        git log --pretty=format:'%C(yellow)%h %C(blue)%ad %C(red)%d %C(reset)%s %C(green)[%cn]' --decorate --date=short
}

function gci() {
        git commit -am "$*"
}

function gco() {
        git checkout $*
}

function gic() {
        git icdiff $*
}

function gxx() {
        git clean -fd
}

function gxxx() {
        git clean -fdx
}

############################################################
# br
function brb() { #黑色
        printf "\033[30m%$(tput cols)s\033[0m" | tr ' ' ${1:-'-'}
}
function brr() { #红色
        printf "\033[31m%$(tput cols)s\033[0m" | tr ' ' ${1:-'-'}
}
function brg() { #绿色
        printf "\033[32m%$(tput cols)s\033[0m" | tr ' ' ${1:-'-'}
}
function bry() { #黄色
        printf "\033[33m%$(tput cols)s\033[0m" | tr ' ' ${1:-'-'}
}
function brp() { #紫色
        printf "\033[35m%$(tput cols)s\033[0m" | tr ' ' ${1:-'-'}
}
function brc() { #青色
        printf "\033[36m%$(tput cols)s\033[0m" | tr ' ' ${1:-'-'}
}
function brw() { #白色
        printf "\033[37m%$(tput cols)s\033[0m" | tr ' ' ${1:-'-'}
}
alias br=brp

function calc() {
        echo "$*" | tr 'x' '*' | bc -l
}

############################################################
# compress and uncompress
function x() {
        if [ -f $1 ]; then
                case $1 in
                *.tar.bz2) tar xjf $1 ;;
                *.tar.gz) tar xzf $1 ;;
                *.bz2) bunzip2 $1 ;;
                *.rar) rar x $1 ;;
                *.gz) gunzip $1 ;;
                *.tar) tar xf $1 ;;
                *.tbz2) tar xjf $1 ;;
                *.tgz) tar xzf $1 ;;
                *.zip) unzip $1 ;;
                *.Z) uncompress $1 ;;
                *) echo "'$1' cannot be extracted via x()" ;;
                esac
        else
                echo "'$1' is not a valid file"
        fi
}

function p() {
        if [ ! -z $1 ]; then
                ps aux | grep -v grep | grep $1
        else
                ps -ef
        fi
}

function ssh_free() {
        [[ ! -s ~/.ssh/id_rsa ]] && ssh-keygen
        ssh $1 "cd"
        ssh-copy-id $1
}

function kl() {
        ps aux | grep $1 | grep -v grep | awk '{print $2}' | xargs kill -9
}
function pk() {
        ps aux | percol | awk '{print $2}' | xargs kill -9
}

function v() {
        ssh jf@localhost -p 2222
}

function ss() {
        ssh ${2:-"lingjf"}@$1
}
