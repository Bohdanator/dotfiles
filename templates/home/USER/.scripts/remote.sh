export REMOTEUSER="yourusername"

export DAVINCIHOST="$REMOTEUSER@davinci.fmph.uniba.sk"

alias fmfissh="ssh $DAVINCIHOST -oHostKeyAlgorithms=+ssh-rsa"
fmfisync() {
    local laptop="$HOME/Documents/fmfi/public_html/"
    local davinci="$DAVINCIHOST:public_html/"
    if [[ $1 == "lr" ]] ; then
        rsync -rPh --delete $laptop $davinci -e "ssh -oHostKeyAlgorithms=+ssh-rsa"
    elif [[ $1 == "rl" ]] ; then
        rsync -rPh --delete $davinci $laptop
    fi
}
