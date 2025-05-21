#!/bin/bash

FRONTEND_HOST="$1"

if [[ -z "$FRONTEND_HOST" ]]; then
    echo "ERROR: No frontend host provided."
    exit 1
fi

file_to_find="../backend/.env.docker"
expected="FRONTEND_URL=\"http://${FRONTEND_HOST}:5173\""

if [ -f "$file_to_find" ]; then
    current_url=$(grep FRONTEND_URL "$file_to_find")
    if [[ "$current_url" != "$expected" ]]; then
        sed -i -e "s|FRONTEND_URL.*|$expected|g" "$file_to_find"
        echo "Updated FRONTEND_URL to $FRONTEND_HOST"
    else
        echo "FRONTEND_URL is already correct."
    fi
else
    echo "ERROR: $file_to_find not found."
fi
