#!/bin/bash -eu

DIR=${1}

# Sprawdza czy podano parametr wejściowy
if [[ -z ${1} ]]; then
    echo "ERROR! No parameter was given!"
    exit
fi

# Sprawdza czy podano prawidłową ścieżkę do katalogu
if [[ ! -d ${1} ]]; then
    echo "ERROR! Given directories don't exist!"
    exit
fi

cd ${DIR}
for FILE in *; do
    if [[ -d $FILE ]] && [[ ".${FILE##*.}" == ".bak" ]]; then
        chmod u-r ${FILE}
        chmod g-r ${FILE}
        chmod o+r ${FILE}
    elif [[ -d $FILE ]] && [[ ".${FILE##*.}" == ".tmp" ]]; then
        chmod u+rw ${FILE}
        chmod g+rw ${FILE}
        chmod o+rw ${FILE}
    elif [[ -f $FILE ]] && [[ ".${FILE##*.}" == ".bak" ]]; then
        chmod u-w ${FILE}
        chmod o-w ${FILE}
    elif [[ -f $FILE ]] && [[ ".${FILE##*.}" == ".txt" ]]; then
        chmod 421 ${FILE}
    elif [[ -f $FILE ]] && [[ ".${FILE##*.}" == ".exe" ]]; then
        chmod u+x ${FILE}
        chmod g+xs ${FILE}
        chmod o+xs ${FILE}
    fi
done
