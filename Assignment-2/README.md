UserManager Utility

Assignment — User and Team Management

Objective

Create a UserManager.sh utility to simulate Linux user and team management.

The utility supports:

Creating a team/group

Creating a user under a team

Setting permissions on user home directories

Creating shared team and ninja directories

Changing a user's shell

Changing a user's password

Deleting a user

Deleting a team/group

Listing users

Listing teams/groups

Note: The script automatically requests sudo privileges when it is not executed as root.

Problem Statement

Example commands:

./UserManager.sh addTeam amigo
./UserManager.sh addTeam unixkings
./UserManager.sh addUser Rakesh amigo
./UserManager.sh addUser Sandeep unixkings

Expected structure:

/home
├── Rakesh
│   ├── team
│   └── ninja
└── Sandeep
    ├── team
    └── ninja

Permission Requirements

User Home Directory

The assignment requires:

Owner: read, write, execute

Group: read, write, execute

Others: execute only

The script sets:

chmod 751 "/home/$USER_NAME"

Meaning:

751 = rwx r-x --x

User

Permission

Value

Owner

Read + Write + Execute

7

Group

Read + Execute

5

Others

Execute

1

Important: The script uses 751, which gives the group read + execute, not read + write + execute. This matches the stated requirement that fellow team members have read and execute access to a user's home directory.

Shared Directories

Every user receives:

team
ninja

team

Same-team members should have full access.

The script uses:

chmod 770 "/home/$USER_NAME/team"

Meaning:

770 = rwx rwx ---

Owner → full access

Group → full access

Others → no access

The directory is owned by the user and their team group:

chown "$USER_NAME:$GROUP_NAME" "/home/$USER_NAME/team"

ninja

All users should have full access.

The script uses:

chmod 777 "/home/$USER_NAME/ninja"

Meaning:

777 = rwx rwx rwx

Owner → full access

Group → full access

Others → full access

How the Script Works

1. Automatically Request sudo

if [ "$EUID" -ne 0 ]; then
exec sudo "$0" "$@"
fi

$EUID contains the effective user ID.

If the script is not running as root, it automatically reruns itself using sudo.

This provides the privileges required by commands such as useradd, groupadd, passwd, userdel, and groupdel.

2. Create a Team / Group

Command:

./UserManager.sh addGroup amigo

The script executes:

groupadd "$2"

For this command:

$1 = addGroup
$2 = amigo

So the actual command becomes:

groupadd amigo

Another example:

./UserManager.sh addGroup unixkings

3. Add a User Under a Team

Command:

./UserManager.sh addUser Rakesh amigo

Arguments:

$1 = addUser
$2 = Rakesh
$3 = amigo

The script stores them:

USER_NAME="$2"
GROUP_NAME="$3"

Then creates the user:

useradd -m -g "$GROUP_NAME" "$USER_NAME"

For this example:

useradd -m -g amigo Rakesh

-m creates the user's home directory.

-g assigns the specified primary group.

4. Set Home Directory Permissions

chmod 751 "/home/$USER_NAME"

For Rakesh:

chmod 751 /home/Rakesh

Permission:

rwx r-x --x
7   5   1

5. Set Home Directory Ownership

chown "$USER_NAME:$GROUP_NAME" "/home/$USER_NAME"

For Rakesh:

chown Rakesh\:amigo /home/Rakesh

This makes Rakesh the owner and amigo the group owner.

6. Create the team Directory

mkdir "/home/$USER_NAME/team"

For Rakesh:

mkdir /home/Rakesh/team

Permissions:

chmod 770 "/home/$USER_NAME/team"

Ownership:

chown "$USER_NAME:$GROUP_NAME" "/home/$USER_NAME/team"

Therefore, members of the same group receive full access to the team directory.

7. Create the ninja Directory

mkdir "/home/$USER_NAME/ninja"

Permissions:

chmod 777 "/home/$USER_NAME/ninja"

Ownership:

chown "$USER_NAME:$GROUP_NAME" "/home/$USER_NAME/ninja"

All users can access the ninja directory because it has 777 permissions.

8. Change User Shell

Command:

./UserManager.sh changeShell Rakesh /bin/bash

The script executes:

chsh -s "$3" "$2"

For this example:

chsh -s /bin/bash Rakesh

9. Change User Password

Command:

./UserManager.sh changePasswd Rakesh

The script executes:

passwd "$2"

The passwd command prompts for the new password.

10. List Users

Command:

./UserManager.sh ls User

The script executes:

cat /etc/passwd | cut -d: -f1

This displays usernames from /etc/passwd.

11. List Groups

Command:

./UserManager.sh ls Group

The script executes:

cat /etc/group | cut -d: -f1

This displays group names from /etc/group.

Note: The problem statement uses ls Team, while this implementation uses ls Group.

12. Delete a User

Command:

./UserManager.sh delUser Rakesh

The script executes:

userdel -r "$2"

The -r option removes the user's home directory and mail spool along with the account.

13. Delete a Team / Group

Command:

./UserManager.sh delGroup amigo

The script executes:

groupdel "$2"

Example Workflow

Create Teams

./UserManager.sh addGroup amigo
./UserManager.sh addGroup unixkings

Create Users

./UserManager.sh addUser Rakesh amigo
./UserManager.sh addUser Sandeep unixkings

Resulting Structure

/home
├── Rakesh
│   ├── team
│   └── ninja
└── Sandeep
    ├── team
    └── ninja

Check Permissions

ls -ld /home/Rakesh
ls -ld /home/Rakesh/team
ls -ld /home/Rakesh/ninja

Expected modes:

/home/Rakesh       → 751
/home/Rakesh/team  → 770
/home/Rakesh/ninja → 777

Permission Summary

Location

Permission

Meaning

User home directory

751

Owner: rwx, Group: r-x, Others: --x

team directory

770

Owner: rwx, Group: rwx, Others: ---

ninja directory

777

Owner: rwx, Group: rwx, Others: rwx

Linux Permission Values

Linux permissions use:

Read    = 4
Write   = 2
Execute = 1

Therefore:

7 = 4 + 2 + 1 = rwx
6 = 4 + 2     = rw-
5 = 4 + 1     = r-x
4 = 4         = r--
3 = 2 + 1     = -wx
2 = 2         = -w-
1 = 1         = --x
0 = 0         = ---

For example:

751

means:

Owner  → 7 → rwx
Group  → 5 → r-x
Others → 1 → --x

Directory Permissions

For directories:

Read (r) → allows listing directory contents.

Write (w) → allows creating and deleting directory entries.

Execute (x) → allows entering/traversing the directory.

Therefore, execute permission is important when accessing files and directories inside another user's home directory.

Additional Features

Change Shell

./UserManager.sh changeShell Rakesh /bin/bash

Change Password

./UserManager.sh changePasswd Rakesh

Delete User

./UserManager.sh delUser Rakesh

Delete Group

./UserManager.sh delGroup amigo

List Users

./UserManager.sh ls User

List Groups

./UserManager.sh ls Group

Conclusion

The UserManager.sh utility demonstrates practical Linux user, group, permission, ownership, and directory management.

The script uses Bash positional parameters and a case statement to select different operations.

The main Linux commands demonstrated are:

groupadd
useradd
chmod
chown
mkdir
chsh
passwd
userdel
groupdel
cat
cut

The assignment demonstrates how Linux users and groups can be created and managed programmatically, while applying different permissions to user home directories and shared directories.