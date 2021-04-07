#!/bin/bash -eu

FIRST_DIR=${1}
SECOND_DIR=${2}

# Sprawdza czy podano parametry
if [[ -z ${1} ]] || [[ -z ${2} ]]; then
    echo "ERROR! No parameters were given!"
    exit
fi

# Sprawdza czy podano prawidłowe ścieżki do katalogów
if [[ ! -d ${1} ]] || [[ ! -d ${2} ]]; then
    echo "ERROR! Given directories don't exist!"
    exit
fi

ALL_FILES=$(ls ${FIRST_DIR})
for FILE in ${ALL_FILES}; do
    if [[ -d ${FIRST_DIR}/${FILE} ]]; then
        echo "${FILE} is a directory"
        LINK_NAME=${FILE}_ln
        ln -s $(cd "$(dirname "${FIRST_DIR}/${FILE}")"; pwd -P)/$(basename "${FIRST_DIR}/${FILE}") ${SECOND_DIR}/${LINK_NAME}
    elif [[ -f ${FIRST_DIR}/${FILE} ]]; then
        echo "${FILE} is a regular file"
        LINK_NAME=${FILE%.*}_ln${FILE#${FILE%.*}}
        ln -s $(cd "$(dirname "${FIRST_DIR}/${FILE}")"; pwd -P)/$(basename "${FIRST_DIR}/${FILE}") ${SECOND_DIR}/${LINK_NAME}
    elif [[ -h ${FIRST_DIR}/${FILE} ]]; then
        echo "${FILE} is a symbolic link"
    fi
done