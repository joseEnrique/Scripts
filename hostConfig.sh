#!/bin/bash

#Read every databases from mysql and check if exists in some file /home/x/public contain it
for OUTPUT in $(mysql -e 'show databases')
do
  	IFS='_' read -a name <<< "$OUTPUT"
        if [ -n "$(find /home/"$name"/public_html -type f -exec grep -l "$O$
        then
	echo "$OUTPUT" has a config file >>data.txt
        else
	echo "$OUTPUT" HASN'T  has config file  >>data.txt

        fi
done

