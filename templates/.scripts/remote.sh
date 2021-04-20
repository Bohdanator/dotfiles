export REMOTEUSER="yourusername"

export DAVINCIHOST="$REMOTEUSER@davinci.fmph.uniba.sk"
export LPPHOST="$REMOTEUSER@lpp.ii.fmph.uniba.sk"
export DBPHOST="$REMOTEUSER@cvika.dcs.fmph.uniba.sk"
export UNIXHOST="$REMOTEUSER@unix.dcs.fmph.uniba.sk"

alias fmfissh="ssh $DAVINCIHOST"
fmfisync() {
    local laptop="$HOME/Documents/fmfi/"
    local davinci="$DAVINCIHOST:public_html/"
    if [[ $1 == "lr" ]] ; then
        rsync -rPh --delete $laptop $davinci
    elif [[ $1 == "rl" ]] ; then
        rsync -rPh --delete $davinci $laptop
    fi
}

alias lppssh="ssh $LPPHOST"
alias lppinit="lppssh 'qemu-img create -f qcow2 -b /opt/f32master.qcow2 tmp.qcow2 && \
    virt-install --name=moja --disk=./tmp.qcow2 --import --vcpus=1 --memory=2048 --graphics none \
    --disk size=1 --disk size=3'"

alias dbpssh="ssh $DBPHOST"
dbprun() {
    local f="queries.sql"
    [[ $# = 1 ]] && f="$1"
    rsync "$f" "$DBPHOST:"
    dbpssh psql -f "$f"
}

alias unixssh="ssh $UNIXHOST -L2323:127.0.0.1:44161"
alias unixtelnet="telnet 127.0.0.1 2323"
