#!/bin/bash

delay=5
while [[ $# -gt 0 ]]; do # Runs as long as the number of positional parameters are not null
    key="$1"

    case $key in
        --after-pull)
            after_pull="$2"
            shift
            ;;
        --delay)
            delay="$2"
            shift
            ;;
        *)
            echo "Unrecognized option: $key"
            exit 1
            ;;
    esac
    shift
done



while true; do
    git fetch
    status_output=$(git status | grep "nothing to commit")

    if [ -n "$status_output" ]; then
        echo "[*] Nothing to pull"
        eval "$after_pull"
    else
        echo "[*] Pulling current changes"
        git pull
        eval "$after_pull"
    fi
    sleep $delay
done