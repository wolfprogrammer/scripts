#!/bin/sh
#
#  Author: Caio R.S.
#  
#  Graphical interface using zenity to mount ISO images, works
#  like daemon tools
#
#  Usage: 
#	   chmod +x isomount.sh
#	   ./isomount.sh  and choose the iso image to mount
#
#-----------------------------------------------------------------


# Mount point without slash in the end of the name ( / )
#  Ex. /cdrom not /cdrom/
#
MOUNT=/media/cdrom
FILEMANAGER=pcmanfm

if mount | grep $MOUNT > /dev/null ; then
  echo "Monted"
  sudo umount $MOUNT
  zenity --info --text "$FILE directory umounted"    
fi    

zenity --question --text "Mount CDROM/DVD image ?"; 
if [[ $? == 0 ]] ; then

	FILE=`zenity --file-selection  --title="Select a CROM/DVD ISO image" --file-filter=" | *.iso"`
	gksu -u root  -k -m "Enter root password:" /bin/echo "got r00t?" 
	echo "dummy"
else
	exit 0
fi    


case $? in
         0)
                echo "\"$FILE\" selected."

		sudo mount -o loop "$FILE" /media/cdrom
		$FILEMANAGER $MOUNT
		exit 0
		;;
		

         1)
                echo "No file selected."
		exit 0
		;;
        -1)
                echo "An unexpected error has occurred."
		exit 0
		;;
esac    
