#!/bin/bash
#
#  Author: Caio Rodrigues
#
#  It does incremental backup of a list of directries in Apple's time
#  machine fashion without a fancy gui.
#
#  ** This script must be called by cronjob
#
#
# -----------------------------------------------
#  Based on
#  See also: http://www.swecsoftware.com/blog/2011/12/time-machine-for-linux-automated-backups  
#
#
#
#---------------------- C R O N J O B  -------------------------------#
#
#   To make the backup every two hours do:
#   Enter:
#   sudo crontab -u user -e    
#   
#   add the line:
#   0 */2 * * *  /home/user/bin/backup    > /tmp/backup.log  2>&1 
#   
#   To test:
#   cat /tmp/backup.log
#
#   To debug:
#   tail -n300 -f /var/log/syslog | grep -i cron
#     
#
#-----------------------------------------------------


#----------- F I L E S   T O   B E   B A C K E D U P ----------------#
#
# Directory list to be backedup
DIRS_BACKUP="$HOME/bin \
$HOME/Dropbox \
$HOME/finalproject \
$HOME/Finalproject \
$HOME/metacompiler \
$HOME/mfiles \
$HOME/Notebooks \
$HOME/BOARDS"


# Storage Backup directory 
BACKUP="$HOME/backup"


#----------------------------------------------------------------------#

  # Control will enter here if $DIRECTORY doesn't exist.
if [ ! -d $BACKUP ]; then
    echo " Creating backup storage directory $BACKUP"
    mkdir -p $BACKUP
fi
echo "Starting User backups"


#------------------------------------------------#
#
HIST=$BACKUP/history
MAX_BACKUPS=10
#
TIME=$(date "+%H:%M:%S")
date=`date "+%Y-%m-%d-%H-%M-%S"`
echo $date
#
# Backup name
NAME="backup-$date"
echo $NAME

# Add backup to the history log
echo "$NAME  $TIME" >> $HIST




#=====================  RSYNC OPTIONS ================================
#
# -a Recursive mode preserves  symbolic links  permissions  timestamp  owner and group 
# -x This  tells  rsync   to  avoid  crossing  a  filesystem boundary when recursing. 
# -v Verbose 
# -P continue interrupted transfers and show a progress status for each file. 
#    This isn’t really necessary but I like it.  
# -z Compression
# -R absolute path
# --linl-dest  
#   This make full backups without losing much space. rsync links unchanged 
#   files to the previous backup (using hard-links,  This only works if you have a backup at hand,
#   otherwise you have to make at least one backup beforehand. 
#-----------------------------------------------------------------------
# 

for dir in $DIRS_BACKUP
do
#   dir=$DIRS_BACKUP
    rsync -avzxbPR --progress --delete --human-readable --delete-excluded --link-dest=$BACKUP/latest $dir $BACKUP/$NAME  

done

rm -rf $BACKUP/latest 
ln -s $BACKUP/$NAME $BACKUP/latest

echo "-------------------------------------"
echo "Backups done see  $BACKUPS/$NAME "
echo "-------------------------------------"

#-------------------------------#
#   E N D   O F   F I L E       #
#-------------------------------#
