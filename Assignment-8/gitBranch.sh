#!/bin/bash


case "$1" in

    # List branches
    -l)
        git branch
        ;;

    # Create branch
    -b)
        git branch "$2"
        echo "Branch $2 created"
        ;;

    # Delete branch
    -d)
        git branch -d "$2"
        ;;

    # Merge branch1 into branch2
    -m)
        if [ "$2" = "-1" ] && [ "$4" = "-2" ]; then
            branch1="$3"
            branch2="$5"

            git checkout "$branch2"
            git merge "$branch1"
        else
            echo "Usage: ./gitBranches.sh -m -1 <branch1> -2 <branch2>"
        fi
        ;;

    # Rebase branch1 onto branch2
    -r)
        if [ "$2" = "-1" ] && [ "$4" = "-2" ]; then
            branch1="$3"
            branch2="$5"

            git checkout "$branch1"
            git rebase "$branch2"
        else
            echo "Usage: ./gitBranches.sh -r -1 <branch1> -2 <branch2>"
        fi
        ;;

    *)
        echo "Usage:"
        echo "./gitBranches.sh -l"
        echo "./gitBranches.sh -b <branch_name>"
        echo "./gitBranches.sh -d <branch_name>"
        echo "./gitBranches.sh -m -1 <branch1> -2 <branch2>"
        echo "./gitBranches.sh -r -1 <branch1> -2 <branch2>"
        ;;

esac



# # Function to display usage instructions
# usage() {
#     echo "Usage:"
#     echo "  $0 -l                                      # List all branches"
#     echo "  $0 -b <branch_name>                        # Create a new branch"
#     echo "  $0 -d <branch_name>                        # Delete a branch"
#     echo "  $0 -m -1 <branch1> -2 <branch2>            # Merge branch1 into branch2"
#     echo "  $0 -r -1 <branch1> -2 <branch2>            # Rebase branch1 onto branch2"
#     exit 1
# }

# # Ensure at least one argument is provided
# if [ $# -eq 0 ]; then
#     usage
# fi

# ACTION=""
# BRANCH1=""
# BRANCH2=""

# # Parse flags using getopts
# while getopts "l b: d: m r 1: 2:" opt; do
#     case "$opt" in
#         l) ACTION="list" ;;
#         b) ACTION="create"; BRANCH1="$OPTARG" ;;
#         d) ACTION="delete"; BRANCH1="$OPTARG" ;;
#         m) ACTION="merge" ;;
#         r) ACTION="rebase" ;;
#         1) BRANCH1="$OPTARG" ;;
#         2) BRANCH2="$OPTARG" ;;
#         *) usage ;;
#     esac
# done

# # Execute actions based on the flag
# case "$ACTION" in
#     list)
#         git branch
#         ;;
#     create)
#         if [ -z "$BRANCH1" ]; then
#             echo "Error: Branch name required."
#             usage
#         fi
#         git branch "$BRANCH1"
#         echo "Branch '$BRANCH1' created successfully."
#         ;;
#     delete)
#         if [ -z "$BRANCH1" ]; then
#             echo "Error: Branch name required."
#             usage
#         fi
#         git branch -d "$BRANCH1"
#         ;;
#     merge)
#         if [ -z "$BRANCH1" ] || [ -z "$BRANCH2" ]; then
#             echo "Error: Both -1 <branch1> and -2 <branch2> are required for merging."
#             usage
#         fi
#         echo "Merging '$BRANCH1' into '$BRANCH2'..."
#         git checkout "$BRANCH2" && git merge "$BRANCH1"
#         ;;
#     rebase)
#         if [ -z "$BRANCH1" ] || [ -z "$BRANCH2" ]; then
#             echo "Error: Both -1 <branch1> and -2 <branch2> are required for rebasing."
#             usage
#         fi
#         echo "Rebasing '$BRANCH1' onto '$BRANCH2'..."
#         git checkout "$BRANCH1" && git rebase "$BRANCH2"
#         ;;
#     *)
#         usage
#         ;;
# esac