 #!/bin/bash -eu

# We wszystkich plikach w katalogu ‘groovies’ zamień $HEADER$ na /temat/
for FILE in "data/groovies"/*; do
     cat ${FILE} | sed -i 's|\$HEADER\$|/temat/|g' ${FILE}
     echo "Modified: ${FILE}"
done


# We wszystkich plikach w katalogu ‘groovies’ po każdej linijce z 'class' dodać '  String marker = '/!@$%/''
for FILE in "data/groovies"/*; do
     cat ${FILE} | sed -ri "s|.*class.*|&\n    String marker = '\/!@\$%/'|" ${FILE}
     echo "Modified: ${FILE}"
done


# We wszystkich plikach w katalogu ‘groovies’ usuń linijki zawierające frazę 'Help docs:'
for FILE in "data/groovies"/*; do
    cat ${FILE} | sed -i '/Help docs:/d' ${FILE}
    echo "Modified: ${FILE}"
done
