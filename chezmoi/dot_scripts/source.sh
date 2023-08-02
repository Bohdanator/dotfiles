export SCRIPTSDIR="$HOME/.scripts"

# OTHER SCRIPT FILES
alias bat="$SCRIPTSDIR/battery.sh"
alias perf="$SCRIPTSDIR/performance.sh"
alias light="$SCRIPTSDIR/light-theme.sh"
alias toolwait="$SCRIPTSDIR/toolwait.py"
[[ -r "$SCRIPTSDIR/remote.sh" ]] && source "$SCRIPTSDIR/remote.sh"

# UTILS
alias mdtopdf="pandoc --highlight-style kate -V papersize:a4 -V geometry:margin=2.5cm -V urlcolor=blue -f gfm"
alias busy="python -c 'while True: pass'"
alias timer="termdown -f roman"
alias ookla="speedtest --simple"
alias cz="chezmoi"
alias reload="cz apply && sudo rsync -rv ~/.root-src/ / && swaymsg reload"
alias grubupdate="grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB && grub-mkconfig -o /boot/grub/grub.cfg"
alias c="code"
alias XW="GDK_BACKEND=x11 SDL_VIDEODRIVER=x11 QT_QPA_PLATFORM=xcb"

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
alias df="df -h"
alias du="du -h"
alias free="free -h"

# GIT SHORTCUTS
alias g='git'

alias gad='git add -v'
alias gadp='git add -v --patch'
alias gadi='git add -v --interactive'

alias gap='git apply'

alias gbr='git branch'
alias gbra='git branch --all'
alias gbrd='git branch --delete'

alias gco='git checkout --recurse-submodules'
alias gcom='git checkout main || git checkout master'
alias gcod='git checkout develop || git checkout dev'
alias gcob='git checkout -b'

alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'

alias gcl='git clone --recurse-submodules'

alias gcm='git commit -v'
alias gcma='git commit -v --amend'
alias gcmf='git commit -v --fixup'

alias gcf='git config'
alias gcfl='git config --list'

alias gdf='git diff'
alias gdfs='git diff --staged'
alias gdfn='git diff --stat'

alias gft='git fetch'
alias gfta='git fetch --all'

alias glg='git log'
alias glgs='git log --stat'
alias glgg='git log --graph'
alias glgo='git log --oneline'
alias glggo='git log --graph --oneline'
alias glggp="git log --graph --pretty='%C(yellow)%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"

alias gpl='git pull'
alias gplm='gcod && gpl && gco - && gcom && gpl && gco -'

alias gps='git push'
alias gpsf='git push -f'
alias gpst='git push origin --tags'

alias grb='git rebase'
alias grbi='git rebase -i'
alias grbio='git rebase -i --onto'
alias grbis='git rebase -i --autosquash'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'

alias gww='git remote -v'
alias gwwa='git remote -v add'
alias gwws='git remote -v set-url'

alias grr='git reset'
alias grrh='git reset --hard'
alias grru='git reset --soft HEAD~'

alias gll='git restore'
alias glls='git restore --staged'

alias grv='git revert'

alias gxx='git rm'
alias gxxc='git rm --cached'

alias gsh='git show'

alias gss='git stash'
alias gssp='git stash push --include-untracked'
alias gssps='git stash push --staged'
alias gssl='git stash list'
alias gsss='git stash show'
alias gssst='git stash show --text'
alias gssa='git stash apply'
alias gstd='git stash drop'
alias gsto='git stash pop'

alias goo='git status'

alias gsm='git submodule'
alias gsmu='git submodule update'
alias gsmf='git submodule deinit -f . && git submodule update --init'

alias gsw='git switch'

alias gtg='git tag'
alias gtga='git tag -a'
