#!/bin/bash
#
#  Open files with foxit reader in Linux
#
#


#FOXIT=/home/caio/bin/FoxitReader_4.3.0.0323_enu_Setup.exe
#FOXIT=/home/caio/bin/FoxitReader431_enu_Setup.exe

Filename= `winepath -w "$*"`

wine $FOXIT $Filename

#echo "\$1= "$1
#echo "\$@= "$@
#echo "\$*= "$*
#echo "\$#= "$#
#echo $Filename
wine  "$HOME/drivec/Program Files/Foxit Software/Foxit Reader/Foxit Reader.exe" "$Filename"



