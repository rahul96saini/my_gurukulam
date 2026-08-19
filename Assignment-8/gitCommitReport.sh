#!/bin/bash

while [ $# -gt 0 ]
do
    case "$1" in
        -u)
            url="$2"
            shift 2
            ;;
        -d)
            days="$2"
            shift 2
            ;;
        *)
            echo "Usage: ./gitCommitReport.sh -u <repo_url> -d <days>"
            exit 1
            ;;
    esac
done

if [ -z "$url" ] || [ -z "$days" ]
then
    echo "Usage: ./gitCommitReport.sh -u <repo_url> -d <days>"
    exit 1
fi

dir=$(mktemp -d)

git clone -q "$url" "$dir/repo"

if [ $? -ne 0 ]
then
    echo "Clone failed"
    rm -rf "$dir"
    exit 1
fi

cd "$dir/repo"

git log --since="$days days ago" --format="%ad | %an | %ae | %s" --date=default

rm -rf "$dir"