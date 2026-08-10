otssh — SSH Connection Manager

Assignment — SSH Connection Utility

Objective

Create a command-line utility named otssh that manages SSH connection details.

The utility should provide the following features:

Add an SSH connection

List SSH connections

List SSH connections with details

Update an SSH connection

Delete an SSH connection

Connect to a saved SSH server

The utility stores SSH connection information locally so that the user can connect to a server using only its saved connection name.

Features

The otssh utility supports:

Add SSH connection
List SSH connections
List SSH connections with details
Update SSH connection
Delete SSH connection
Connect to saved server

Database Location

The script stores connection information in:

$HOME/.otssh/servers.db

At startup, the script creates the directory and database file if they do not already exist:

DB="$HOME/.otssh/servers.db"

mkdir -p "$HOME/.otssh"
touch "$DB"

The database uses the following pipe-separated format:

name|host|user|port|key

Example:

server1|192.168.21.30|kirti|22|
server2|192.168.42.34|kirti|2022|
server3|192.168.46.34|ubuntu|2022|/home/user/.ssh/server3.pem


How the Script Works

1. Create the Database

The script defines the database location:

DB="$HOME/.otssh/servers.db"

It then creates the directory:

mkdir -p "$HOME/.otssh"

and creates the database file if necessary:

touch "$DB"

This means the user does not need to manually create the database.

2. Add SSH Connection

The -a option is used to add a connection.

Add Server With Default SSH Port

./otssh -a -n server1 -h 192.168.21.30 -u kirti

The default port is:

22

The script initializes:

port="22"
key=""

The stored record becomes:

server1|192.168.21.30|kirti|22|

Add Server With Custom Port

./otssh -a -n server2 -h 192.168.42.34 -u kirti -p 2022

The stored information becomes:

server2|192.168.42.34|kirti|2022|

Add Server With SSH Key

./otssh -a -n server3 -h 192.168.46.34 -u ubuntu -p 2022 -i ~/.ssh/server3.pem

The stored information contains:

server3|192.168.46.34|ubuntu|2022|/home/user/.ssh/server3.pem

The script uses:

key=$(eval echo "$2")

to expand the ~ path.

Add Command Argument Processing

After detecting -a, the script removes the first argument:

shift

It then processes the remaining arguments using a while loop:

while [ $# -gt 0 ]
do
    case "$1" in
        -n) name="$2"; shift 2 ;;
        -h) host="$2"; shift 2 ;;
        -u) user="$2"; shift 2 ;;
        -p) port="$2"; shift 2 ;;
        -i) key=$(eval echo "$2"); shift 2 ;;
    esac
done

The options are:

Option

Meaning

-n

Connection name

-h

Server hostname/IP

-u

SSH username

-p

SSH port

-i

SSH private key

3. List SSH Connections

List Names Only

Command:

./otssh ls

The script uses:

cut -d'|' -f1 "$DB"

The database uses | as the delimiter.

Therefore:

server1|192.168.21.30|kirti|22|
server2|192.168.42.34|kirti|2022|
server3|192.168.46.34|ubuntu|2022|/home/user/.ssh/server3.pem

produces:

server1
server2
server3

4. List SSH Connections With Details

Command:

./otssh ls -d

The script reads every database record:

while IFS="|" read -r name host user port key
do
    ...
done < "$DB"

The IFS="|" tells Bash to split each line using |.

Default Port

If the port is 22, the script displays:

server1: ssh kirti@192.168.21.30

The command is built using:

echo "$name: ssh $user@$host"

Custom Port

For a custom port:

server2: ssh -p 2022 kirti@192.168.42.34

The script uses:

echo "$name: ssh -p $port $user@$host"

SSH Key

If an SSH key is configured:

server3: ssh -i /home/user/.ssh/server3.pem -p 2022 ubuntu@192.168.46.34

The script uses:

echo "$name: ssh -i $key -p $port $user@$host"

5. Update an SSH Connection

The script uses -U for updating a connection.

Example:

./otssh -U -n server1 -h server1 -u user1

Another example:

./otssh -U -n server2 -h server2 -u user2 -p 2022

The script first checks whether the server exists:

if grep -q "^$name|" "$DB"; then

If found, it creates a temporary database:

tmpfile="$HOME/.otssh/temp.db"

Then removes the old record:

grep -v "^$name|" "$DB" > "$tmpfile"

The updated record is appended:

echo "$name|$host|$user|$port|$key" >> "$tmpfile"

Finally, the temporary database replaces the original:

mv "$tmpfile" "$DB"

6. Delete an SSH Connection

Command:

./otssh rm server1

The script checks whether the server exists:

grep -q "^$2|" "$DB"

If found, it removes the matching record:

grep -v "^$2|" "$DB" > "$tmpfile"

Then the temporary database replaces the original:

mv "$tmpfile" "$DB"

7. Connect to a Saved Server

The connection name itself can be passed to otssh.

Example:

./otssh server3

The script searches the database:

line=$(grep "^$server|" "$DB")

If the server does not exist:

[ERROR]: Server information is not available, please add server first

If it exists, the record is split:

IFS="|" read -r name host user port key <<< "$line"

The variables become:

name
host
user
port
key

Building the SSH Command

The default SSH command is:

cmd="ssh -p $port $user@$host"

If a key is available:

[ -n "$key" ] && cmd="ssh -i $key -p $port $user@$host"

Finally:

exec $cmd

executes the actual SSH command and opens the live SSH connection.

Complete Usage Examples

Add Connections

./otssh -a -n server1 -h 192.168.21.30 -u kirti

./otssh -a -n server2 -h 192.168.42.34 -u kirti -p 2022

./otssh -a -n server3 -h 192.168.46.34 -u ubuntu -p 2022 -i ~/.ssh/server3.pem

List Connections

./otssh ls

Example:

server1
server2
server3

List Connections With Details

./otssh ls -d

Example:

server1: ssh kirti@192.168.21.30
server2: ssh -p 2022 kirti@192.168.42.34
server3: ssh -i /home/user/.ssh/server3.pem -p 2022 ubuntu@192.168.46.34

Update Connection

./otssh -U -n server1 -h server1 -u user1

./otssh -U -n server2 -h server2 -u user2 -p 2022

Then:

./otssh ls -d

Delete Connection

./otssh rm server1

Then:

./otssh ls -d

Connect

./otssh server3

The utility retrieves the saved details and executes the corresponding SSH command.

Example Database

After adding three servers, the database may look like:

server1|192.168.21.30|kirti|22|
server2|192.168.42.34|kirti|2022|
server3|192.168.46.34|ubuntu|2022|/home/user/.ssh/server3.pem

The database is located at:

~/.otssh/servers.db

Command Summary

Operation

Command

Linux Concepts

Add connection

otssh -a ...

echo, file append

List names

otssh ls

cut

List details

otssh ls -d

while, read, IFS

Update connection

otssh -U ...

grep, temporary file

Delete connection

otssh rm NAME

grep, temporary file

Connect

otssh NAME

grep, read, ssh, exec

Bash Concepts Used

Positional Parameters

Example:

./otssh -a -n server1 -h 192.168.21.30 -u kirti

Initially:

$1 = -a
$2 = -n
$3 = server1
$4 = -h
$5 = 192.168.21.30
$6 = -u
$7 = kirti

The script uses shift to process the options.

case

The main script uses:

case "$1" in

to select the operation.

The supported operations are:

-a
-U
ls
rm
server name

while

The add and update operations process multiple command-line options using:

while [ $# -gt 0 ]
do
    ...
done

shift

Example:

shift

removes the first positional argument.

shift 2

removes the first two arguments.

This allows the script to process options such as:

-n server1
-h 192.168.21.30
-u kirti
-p 2022
-i ~/.ssh/server3.pem

grep

The script uses grep to search for a saved connection:

grep "^$server|" "$DB"

It also checks whether a connection exists:

grep -q "^$name|" "$DB"

And removes a matching record using:

grep -v "^$name|" "$DB"

cut

Used to extract the connection name:

cut -d'|' -f1 "$DB"

Here:

-d'|' → pipe is the delimiter
-f1   → select the first field

IFS

The script uses:

IFS="|" read -r name host user port key

This splits a database record into separate variables.

For example:

server3|192.168.46.34|ubuntu|2022|/home/user/.ssh/server3.pem

becomes:

name = server3
host = 192.168.46.34
user = ubuntu
port = 2022
key  = /home/user/.ssh/server3.pem

exec

The actual SSH connection is opened using:

exec $cmd

This replaces the current shell process with the SSH process.

## Screenshots

![Screenshot 1](a4.1.png)
![Screenshot 2](a4.2.png)
![Screenshot 3](a4.3.png)

Conclusion

The otssh utility provides a simple way to save and manage SSH connection information.

Instead of remembering the complete SSH command every time, the user can save the connection:

./otssh -a -n server3 -h 192.168.46.34 -u ubuntu -p 2022 -i ~/.ssh/server3.pem

and later connect using only:

./otssh server3

The utility demonstrates practical Bash scripting concepts including:

Command-line argument processing

case

while

shift

grep

cut

read

IFS

Temporary files

File redirection

SSH command construction

exec

Local data storage