#!/bin/bash

d="/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"
[[ $1 == 60  ]] && sudo sh -c "echo 1 > $d"
[[ $1 == 100 ]] && sudo sh -c "echo 0 > $d"
[[ $1 == t   ]] && v=$(( 1 - $(cat $d) )) && sudo sh -c "echo $v > $d"
case $(cat $d) in
    0) echo 100;;
    1) echo 60;;
    *) echo error;;
esac
