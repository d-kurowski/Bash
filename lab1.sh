#!/bin/bash

#Zadanie 1
SOURCE_DIR=${1:-"lab_uno"}
RM_LIST=${2:-"lab_uno/2remove"}
TARGET_DIR=${3:-"bakap"}

#Zadanie 2
if [[ ! -d $TARGET_DIR ]]; then
	mkdir $TARGET_DIR
	echo "Created catalog $SOURCE_DIR/$FILE_NAME"
fi

#Zadanie 3
TO_REMOVE=$(cat $RM_LIST)
for FILE_NAME in $TO_REMOVE; do
	if [[ -e $SOURCE_DIR/$FILE_NAME ]]; then
		rm -R $SOURCE_DIR/$FILE_NAME
		echo "Deleted $SOURCE_DIR/$FILE_NAME"
	fi
done

#Zadanie 4+5
FILE_LIST=$(ls $SOURCE_DIR)
for FILE_NAME in $FILE_LIST; do
	if [[ -f $SOURCE_DIR/$FILE_NAME ]]; then
		mv $SOURCE_DIR/$FILE_NAME $TARGET_DIR/
		echo "Moved regular file $FILE_NAME"
	fi
	
	if [[ -d $SOURCE_DIR/$FILE_NAME ]]; then
		mv $SOURCE_DIR/$FILE_NAME $TARGET_DIR/
		echo "Moved catalog $FILE_NAME"
	fi
done

#Zadanie 6
FILES_LEFT=$(ls $SOURCE_DIR | wc -w )
if [[ $FILES_LEFT -gt 0 ]]; then
	echo "Jeszcze cos zostalo"
	if [[ $FILES_LEFT -ge 2 ]]; then
		echo "Zostaly co najmniej dwa pliki"
		if [[ $FILES_LEFT -gt 4 ]]; then
			echo "Zostaly więcej niż 4 pliki"
		else
			echo "Zostaly 3 pliki"
		fi
	fi
else
	echo "Tu byl Kononowicz"
fi

#Zadanie 7
FILE_LIST2=$(find $TARGET_DIR -mindepth 1)
for FILE_NAME in $FILE_LIST2; do
	echo $FILE_NAME
    chmod a-w $FILE_NAME
done

#Zadanie 8
DATE=$(date +'%Y-%m-%d')
zip -r bakap_$DATE.zip $TARGET_DIR

