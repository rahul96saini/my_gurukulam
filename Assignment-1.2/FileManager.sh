#!/bin/bash

case "$1" in

addDir)
    mkdir -p "$2/$3"
    echo "Directory '$3' created in '$2'"
    ;;

deleteDir)
    rmdir "$2/$3"
    echo "Directory '$3' deleted from '$2'"
    ;;

listContent)
    ls "$2"
    ;;

listFiles)
    find "$2" -maxdepth 1 -type f
    ;;

listDirs)
    find "$2" -maxdepth 1 -type d
    ;;

listAll)
    ls -la "$2"
    ;;

addFile)
    touch "$2/$3"
    if [ ! -z "$4" ]; then
        echo "$4" > "$2/$3"
    fi
    echo "File Created"
    ;;

addContentToFile)
    echo "$4" >> "$2/$3"
    echo "Content Added"
    ;;

addContentToFileBegining)
    echo "$4" > temp.txt
    cat "$2/$3" >> temp.txt
    mv temp.txt "$2/$3"
    echo "Content Added at Beginning"
    ;;

showFileBeginingContent)
    head -n "$4" "$2/$3"
    ;;

showFileEndContent)
    tail -n "$4" "$2/$3"
    ;;

showFileContentAtLine)
    awk "NR==$4" "$2/$3"
    ;;

showFileContentForLineRange)
    awk "NR>=$4 && NR<=$5" "$2/$3"
    ;;

moveFile)
    mv "$2" "$3"
    echo "File Moved"
    ;;

copyFile)
    cp "$2" "$3"
    echo "File Copied"
    ;;

clearFileContent)
    > "$2/$3"
    echo "File Content Cleared"
    ;;

deleteFile)
    rm "$2/$3"
    echo "File Deleted"
    ;;

*)
    echo "Invalid Command!"
    echo "Available Commands:"
    echo " addDir"
    echo " deleteDir"
    echo " listContent"
    echo " listFiles"
    echo " listDirs"
    echo " listAll"
    echo " addFile"
    echo " addContentToFile"
    echo " addContentToFileBegining"
    echo " showFileBeginingContent"
    echo " showFileEndContent"
    echo " showFileContentAtLine"
    echo " showFileContentForLineRange"
    echo " moveFile"
    echo " copyFile"
    echo " clearFileContent"
    echo " deleteFile"
    ;;
esac