#!/bin/bash

##This script is written by Jose Enrique Ruiz Navarro
#systerminal.com
set -x


#Make backup on fly from you server

#setup for your case
IP='systerminal.com'
LOCALDST="/mnt/backups" #where store
REMOTESRC=("/home") #what copy
USER="user" #user db
PASS="userpass" #pass db
LOG="/var/log/sysbackup" #log file

DAYS="6"

date=$(date +"%d-%m-%Y")






FULLDST=$LOCALDST/$date


timestamp=`date "+%Y.%m.%d %H:%M:%S"`

if [ ! -d $LOG ]; then
	mkdir -p $LOG
fi
echo -e "\n*******************\n${timestamp}\n*******************\n" >> $LOG/sysbackup.log
echo `date "+%Y.%m.%d %H:%M:%S"` " Start" >> $LOG/sysbackup.log


#WARNING
if `find $LOCALDST/ -mtime +$DAYS -exec rm -r {} \;`; then
	echo `date "+%Y.%m.%d %H:%M:%S"` " Delete directories older than $DAYS" >> $LOG/sysbackup.log
fi


if [ ${#REMOTESRC[@]} -eq  1 ];
then
if [ ! -d $LOCALDST$REMOTESRC ]; then
mkdir -p $FULLDST$REMOTESRC
fi
echo `date "+%Y.%m.%d %H:%M:%S"` " Copying Databases and directories " >> $LOG/sysbackup.log

for i in  `ssh root@$IP "cd $REMOTESRC; ls -d *"` ; do
	if [ ! -d $FULLDST$REMOTESRC/$i ]; then
	mkdir -p $FULLDST$REMOTESRC/$i #if no exist
	fi

	for e in `ssh root@$IP "mysql -u $USER -p$PASS -e 'show databases;'"`;
	do
	if [[ $e =~ ^$i ]]; then # if db start with username 
	ssh $IP " mysqldump -u $USER -p$PASS $e"  > $FULLDST$REMOTESRC/$i/$e.sql
	fi
	done
	ssh $IP "cd $REMOTESRC; tar czf - $i" | cat > $FULLDST$REMOTESRC/$i/$i.tar.gz
done
else

echo "TODO"

fi


echo `date "+%Y.%m.%d %H:%M:%S"` " END " >> $LOG/sysbackup.log





