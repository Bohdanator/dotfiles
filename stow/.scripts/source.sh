export SCRIPTSDIR="$HOME/.scripts"

# OTHER SCRIPT FILES
alias bat="$SCRIPTSDIR/battery.sh"
[[ -r "$SCRIPTSDIR/remote.sh" ]] && source "$SCRIPTSDIR/remote.sh"

# GIT UTILS
alias gitu="git add . && git commit && git push"

gitprune() {
    git checkout master
    git pull -p
    git branch -vv | grep ": gone]" | awk "{print $1}" | xargs git branch -D
}

# OTHER UTILS
alias mdtopdf="pandoc --highlight-style kate -V papersize:a4 -V geometry:margin=2.5cm -V urlcolor=blue -f gfm"
alias busy="python -c "while True: pass""
alias timer='termdown -f roman'
alias ookla='speedtest --simple'

hotspot() {
    sudo rm /tmp/create_ap.all.lock
    local password
    echo -n "Set hotspot password: "
    read -s password
    echo ""
    sudo create_ap wlp3s0 wlp3s0 "$USER-$HOST" $password
}

beep() {
    if [[ $# -ne 2 ]]; then
        echo 'usage: beep <freq> <secs>'
    else
        play -qn synth "$2" sin "$1"
    fi
}

# ENABLE COLORS
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"
alias diff="diff --color=auto"
alias ip="ip -color=auto"

# ADD OPTIONS
alias ls="ls -F --group-directories-first --color=auto"
alias ll="ls -ghl  --time-style=long-iso"
alias la="ls -ghlA --time-style=long-iso"

alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
