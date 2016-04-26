#!/bin/bash
#Requiere IMAGEMAGICK
#Hay que pasarle el diretorio




DIRNAME=$1



find $DIRNAME  -type f -exec ls -R {} +   | while read -r FILE
do
    echo $FILE
    mv -v "$FILE" `echo $FILE | tr ' ' '_' ` 2>/dev/null
done




for file in `find $DIRNAME  -type f -exec ls -R {} + `;
do

	if [  -f $file ]; then
	
		if [ ${file: -4} == ".JPG" ];  then

	
	mv "$file" "${file%.JPG}.jpg" 2>/dev/null
	fi

	if [ ${file: -4} == ".JPEG" ];  then


        mv "$file" "${file%.JPEG}.jpg" 2>/dev/null
        fi


	fi

done



for IMAGE in `find $DIRNAME -iname "*.jpg" -o -iname "*.png"`
do
	echo $IMAGE

	convert $IMAGE -resize '1600x800!>' $IMAGE
done
