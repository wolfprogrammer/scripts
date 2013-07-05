#!/bin/bash  
#
#
#  Do chroot in partition to save the broken linux system
#------------------------------------------------------------------ 
#  See also: http://superuser.com/questions/111152/whats-the-proper-way-to-prepare-chroot-to-recover-a-broken-linux-installation 
#  See also : http://cuttingedgelinux.com/2013/03/10/command-line-interface-chroot-access-another-linux-from-your-current-linux/ 
#
#  
# If your /boot directory is on a different partition from your /,
# and you want to manipulate files on it (e.g., if you'll be working with
# GRUB, performing a kernel upgrade, etc.), you'll also need to mount that 
# partition. If it's at /dev/sda2 and its filetype is ext2, then do
#
# mount -t ext2 /dev/sda2 /mnt/boot
#

# Root partition to be mounted /
DISK=/dev/sda5

# Chroot directory
DIR=/mnt/chroot

# Enable Chroot graphical applications
xhost +

#rm -rf "$DIR"
mkdir -p "$DIR"

# Mount chroot partition in target directory
mount $DISK $DIR

# Enter chroot directory
cd $DIR

echo "Mounting system on chroot"
mount -o bind /dev dev
mount -o bind /var var
mount -o bind /sys/ sys
mount -o bind /proc proc
mount -t devpts pts dev/pts/

# Add internet connection
cp -L /etc/resolv.conf etc/resolv.conf

#export PS1="(chroot) $PS1"

echo "Entering new root"
echo "Type: exit  to get out chroot"
echo ""

chroot $DIR /bin/bash
#/usr/sbin/chroot  $DIR /bin/sh -Cc echo "In new root"
#umount {proc,sys,dev/pts,dev}

