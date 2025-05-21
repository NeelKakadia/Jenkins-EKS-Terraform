#!/bin/bash

BACKEND_HOST="$1"

if [[ -z "$BACKEND_HOST" ]]; then
    echo "ERROR: No backend host provided."
    exit 1
fi

file_to_find="../frontend/.env.docker"
expected="VITE_API_PATH=\"http://${BACKEND_HOST}:31100\""

if [ -f "$file_to_find" ]; then
    current_url=$(grep VITE_API_PATH "$file_to_find")
    if [[ "$current_url" != "$expected" ]]; then
        sed -i -e "s|VITE_API_PATH.*|$expected|g" "$file_to_find"
        echo "Updated VITE_API_PATH to $BACKEND_HOST"
    else
        echo "VITE_API_PATH is already correct."
    fi
else
    echo "ERROR: $file_to_find not found."
fi