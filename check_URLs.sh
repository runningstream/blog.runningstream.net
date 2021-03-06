#!/bin/bash

BASE_DIR="."

already_checked="$BASE_DIR/already_URL_checked.txt"
content_dir="$BASE_DIR/content/post"

for file in "$content_dir/"*; do
    checked=$(grep "$file" "$already_checked")
    if [ "$checked" != "" ]; then
        echo "Skipping $file - already checked"
        continue
    fi
    echo ""
    echo "Checking $file"

    grep --color=auto "http" "$file"
    echo ""

    echo -n "Mark $file as URL checked (y/n)? "
    read mark
    if [[ "$mark" =~ [yY] ]]; then
        echo "$file" >> "$already_checked"
    else
        echo "Not marking file as checked."
    fi
done
