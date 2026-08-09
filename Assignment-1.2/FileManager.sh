#!/bin/bash


echo "=============================="
echo "    Simple File Manager"
echo "=============================="
echo "1) Create 3 Directories"
echo "2) Delete a Directory"
echo "3) create a file"
echo "4) add content to the file"
echo "5) Add conent at the begining of the file"
echo "6) Show top 2 lines of a file"
echo "7) Show last 2 lines of a file"
echo "8) Show content of a specific line number"
echo "9) Show content of a specific line number range"
echo "10) Move/Copy file from one location to another"
echo "11) List Content of a Directory"
echo "12) Only List Files"
echo "13) Only List Directories"
echo "14) List All (Files and Directories)"
echo "=============================="


# create a directory 1, 2 and 3 inside /tmp
mkdir /tmp/dir1   #dir1 created in tmp
mkdir /tmp/dir2   #dir2 created in tmp
mkdir /tmp/dir3   #dir3 created in tmp
echo ">>>3 directories created"
ls /tmp

# delete dir3 from /tmp
rmdir /tmp/dir3
echo ">>>dir3 deleted"
ls /tmp

# create an empty file1 inside dir1
touch /tmp/dir1/file1.txt
echo ">>>file1 created inside dir1"
ls /tmp/dir1

# adding content to file1
echo ">>>adding content to file1"
echo "my first name is rahul" > /tmp/dir1/file1.txt

# adding content at the begining of the file1
echo ">>>updating content in the file1"
echo -e "This line is in the beginning.\n$(cat /tmp/dir1/file1.txt)\nThis is 3rd line.\nThis is 4th line.\nThis is 5th line." > /tmp/dir1/file1.txt
cat /tmp/dir1/file1.txt

# show top 2 lines of file1
echo ">>>showing top 2 lines"
cat /tmp/dir1/file1.txt | head -n 2

# show last 2 lines of file1
echo ">>>showing last 2 lines"
cat /tmp/dir1/file1.txt | tail -n 2

# show content of line number 3
echo ">>>content of line 3"
cat /tmp/dir1/file1.txt | head -n 3 | tail -n 1

# show content of range form line2 to line4
echo ">>>content from line2 to 4"
cat /tmp/dir1/file1.txt | head -n 4 | tail -n 3

# copy file1 from dir1 to dir2
echo ">>>creating copy of file1 in dir2"
cp /tmp/dir1/file1.txt /tmp/dir2/file1_copy.txt

# list content of dir1 and dir2
echo ">>>list file inside dir1 and dir2"
ls /tmp/dir1
ls /tmp/dir2

# only list files in /tmp
echo ">>>only list files in /tmp"
ls -l /tmp | grep ^-

# only list directories in /tmp
echo ">>>only list directories in /tmp"
ls -l /tmp | grep ^d

# list all files and directories inside /tmp
echo ">>>list all files and directories inside /tmp"
ls -la /tmp







