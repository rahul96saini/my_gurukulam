#!/bin/bash

#!/bin/bash

case "$1" in

    -t)
        git tag "$2"
        echo "Tag $2 created"
        ;;

    -l)
        git tag
        ;;

    -d)
        git tag -d "$2"
        ;;

    *)
        echo "Usage:"
        echo "./gitTags.sh -t <tag_name>"
        echo "./gitTags.sh -l"
        echo "./gitTags.sh -d <tag_name>"
        ;;

esac

# # Function to display usage instructions
# usage() {
#     echo "Usage:"
#     echo "  $0 -t <tag_name>   # Create a tag"
#     echo "  $0 -l              # List all tags"
#     echo "  $0 -d <tag_name>   # Delete a tag"
#     exit 1
# }

# # Ensure at least one argument is provided
# if [ $# -eq 0 ]; then
#     usage
# fi

# ACTION=""
# TAG_NAME=""

# # Parse flags using getopts
# while getopts "t: l d:" opt; do
#     case "$opt" in
#         t) ACTION="create"; TAG_NAME="$OPTARG" ;;
#         l) ACTION="list" ;;
#         d) ACTION="delete"; TAG_NAME="$OPTARG" ;;
#         *) usage ;;
#     esac
# done

# # Execute actions based on the flag
# case "$ACTION" in
#     create)
#         if [ -z "$TAG_NAME" ]; then
#             echo "Error: Tag name required."
#             usage
#         fi
#         git tag "$TAG_NAME"
#         echo "Tag '$TAG_NAME' created successfully."
#         ;;
#     list)
#         git tag
#         ;;
#     delete)
#         if [ -z "$TAG_NAME" ]; then
#             echo "Error: Tag name required."
#             usage
#         fi
#         git tag -d "$TAG_NAME"
#         ;;
#     *)
#         usage
#         ;;
# esac