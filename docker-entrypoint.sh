#!/bin/bash

# Determine if direcotry - loop through files
# Copy {FILE}.png to {FILE}-original.png
# Compress {FILE}.png to {FILE}.webp
# Compress {FILE}.png to {FILE}-compressed.jpg

function convert() {
    local FILE=$1
    local FILENAME="${FILE%%.*}"
    local EXTENSION="${FILE#*.}"
    local ORIGINAL="$FILENAME-original.$EXTENSION"
    mv "$FILE" "$ORIGINAL"
    cwebp -m 6 -q 70 -mt -af "$ORIGINAL" -o "$FILENAME".webp
    if [[ "$EXTENSION" == "png" ]]; then
        opj_compress -r 25 -i "$ORIGINAL" -o "$FILENAME".jp2
    fi
    /opt/google/guetzli/bin/Release/guetzli --quality 84 "$ORIGINAL" "$FILENAME"-guetzli.jpg
}

INPUT=$1

if [[ -f "$INPUT" ]]; then
    convert $INPUT
elif [[ -d "$INPUT" ]]; then
    shopt -s nullglob nocaseglob extglob
    for FILE in "$INPUT"/*.{jpg,jpeg,png}; do
        case "$FILE" in
            *original*);;
            *guetzli*);;
            *) convert "$FILE";;
        esac
    done
fi
