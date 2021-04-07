#!/bin/bash -eu

DIR=${1}
FILE_NAME=${2}

# Sprawdza czy podano parametry
if [[ -z ${1} ]] || [[ -z ${2} ]]; then
    echo "ERROR! No parameters were given!"
    exit
fi

# Sprawdza czy podano prawidłowe ścieżki do katalogów
if [[ ! -d ${1} ]]; then
    echo "ERROR! Given directory doesn't exists!"
    exit
fi

cd ${DIR}
touch ${FILE_NAME}
for LINK in *; do
    if [ ! -e ${LINK} ]; then 
        echo "${LINK} $(date -u +%Y-%m-%dT%H:%M:%SZ)" >> ${FILE_NAME}
        rm ${LINK}
    fi
done