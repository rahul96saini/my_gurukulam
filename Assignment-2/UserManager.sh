#!/bin/bash

# script to run without sudo
if [ "$EUID" -ne 0 ]; then
    exec sudo "$0" "$@"
fi

# $1 is the command (addgroup, adduser, deluser, delgroup)
# $2 is the first argument (name of group or user)
# $3 is the second argument (group name or path)

case "$1" in
    addGroup)	# Usage: ./UserManager.sh addGroup <group_name>
	groupadd "$2"
	echo "group $2 created"
	;;
    addUser)	# Usage: ./UserManager.sh addUser <user_name> <group_name>
	USER_NAME="$2"
	GROUP_NAME="$3"

	#create user and assign the group
	useradd -m -g "$GROUP_NAME" "$USER_NAME"

	#set home directories permissions
	chmod 751 "/home/$USER_NAME"
	chown "$USER_NAME:$GROUP_NAME" "/home/$USER_NAME"

	#create sub directories team and ninja
	mkdir "/home/$USER_NAME/team"
	mkdir "/home/$USER_NAME/ninja"

	#set team dir permission
	chmod 770 "/home/$USER_NAME/team"
	chown "$USER_NAME:$GROUP_NAME" "/home/$USER_NAME/team"

	#set ninja dir permission
	chmod 777 "/home/$USER_NAME/ninja"
	chown "$USER_NAME:$GROUP_NAME" "/home/$USER_NAME/ninja"

	echo "user $USER_NAME is added to group $GROUP_NAME"
	;;

	#additional features

    changeShell)	# Usage: ./UserManager.sh changeShell <user_name> <shell_path>
	chsh -s "$3" "$2"
	echo "shell updated for $2."
	;;

    changePasswd)	# Usage: ./UserManager.sh changePasswd <user_name>
	passwd "$2"
	echo "password updated for $2"
	;;

    ls)		# Usage: ./UserManager.sh ls User OR ./UserManager.sh ls Group
	if [ "$2" == "User" ]; then
	cat /etc/passwd | cut -d: -f1
	elif [ "$2" == "Group" ]; then
	cat /etc/group | cut -d: -f1
	fi
	;;

    delGroup)	# Usage: ./UserManager.sh delGroup <group_name>
	groupdel "$2"
	echo "$2 group deleted"
	;;

    delUser)	# Usage: ./UserManager.sh delUser <user_name>
	userdel -r "$2"
	echo "$2 user deleted"
	;;

    *)
        echo "Invalid command!"
        echo "Usage: $0 {addGroup|addUser|delGroup|delUser|changePasswd|changeShell|ls}"
        ;;

esac
