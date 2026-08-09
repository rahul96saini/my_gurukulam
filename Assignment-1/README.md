# Linux Assignment-01

## Objective

This assignment covers basic Linux commands for:

- Checking the current working directory
- Creating directories and nested directory structures
- Creating and modifying files
- Adding content without using an editor
- Viewing specific lines from a file
- Listing files and directories
- Copying files
- Moving and renaming files
- Clearing file contents
- Deleting files and directories

---

# Commands Used

> **Note:** The commands below are based on the commands actually used while completing the assignment.

---

## 1. Create `Assignment-01` Directory Inside `linux`

The task required creating an `Assignment-01` directory inside the `linux` directory.

Command used:

```bash
mkdir Assignment-o1
```

> **Note:** The command above creates `Assignment-o1`, where `o1` contains the letter `o`. The required name was `Assignment-01`, with zero `0`.

Correct command:

```bash
mkdir Assignment-01
```

Check the directory:

```bash
ls
```

---

## 2. Navigate Through Directories

Commands used while navigating:

```bash
cd ../../../..
ls
cd ..
ls
cd home
ls
cd rahul
```

The `cd` command is used to change the current working directory.

The `ls` command is used to list the contents of the current directory.

---

## 3. Create `dir1` Inside `/tmp`

Command used:

```bash
mkdir /tmp/dir1
```

Check the contents of `/tmp`:

```bash
ls /tmp
```

Detailed listing:

```bash
ls -l /tmp
```

---

## 4. Check `mkdir` Help

Command used:

```bash
mkdir --help
```

This displays the available options and usage of the `mkdir` command.

---

## 5. Create Nested Directory Structure Using One Command

Required structure:

```text
/tmp
└── dir1
    └── dir2
        └── dir3
```

Command used:

```bash
mkdir -p /tmp/dir1/dir2/dir3
```

The `-p` option allows `mkdir` to create the required parent directories automatically.

Check the directory:

```bash
ls /tmp
```

To display the tree structure:

```bash
tree /tmp/dir1
```

If permission is required:

```bash
sudo tree /tmp/dir1
```

### Installing `tree`

Initially, the following command was tried:

```bash
sudo spt install tree
```

This contains a typo.

The correct command is:

```bash
sudo apt install tree
```

After installation:

```bash
tree /tmp/dir1
```

Expected output:

```text
/tmp/dir1
└── dir2
    └── dir3
```

---

## 6. Delete `dir3`

Command used:

```bash
rmdir /tmp/dir1/dir2/dir3
```

`rmdir` removes an empty directory.

Verify:

```bash
ls /tmp/dir1/dir2
```

---

# File Operations

## 7. Create an Empty File

Create the first-name file inside `/tmp`.

Command used:

```bash
touch /tmp/rahul.txt
```

Check:

```bash
ls /tmp
```

---

## 8. Add the First Line to the File

The required content was:

```text
This is my first line
```

Command used:

```bash
echo "This is my first line" > /tmp/rahul.txt
```

The `>` operator writes content to a file and overwrites existing content.

Verify:

```bash
cat /tmp/rahul.txt
```

Output:

```text
This is my first line
```

---

## 9. Add Additional Content Without Overwriting

Command used:

```bash
echo "this is a additional content" >> /tmp/rahul.txt
```

The `>>` operator appends content to the existing file without overwriting it.

Verify:

```bash
cat /tmp/rahul.txt
```

Expected output:

```text
This is my first line
this is a additional content
```

---

## 10. Create Last-Name File With Content

Command used:

```bash
echo "saini is my last name" > /tmp/saini.txt
```

Check the file:

```bash
ls -l /tmp
```

Display the contents:

```bash
cat /tmp/saini.txt
```

Output:

```text
saini is my last name
```

---

## 11. Add a Line at the Beginning

The required line was:

```text
this is line at the beginning
```

Command used:

```bash
echo -e "this is line at the beginning\n$(cat /tmp/saini.txt)" > /tmp/saini.txt
```

### How it works

- `echo -e` enables interpretation of escape sequences.
- `\n` creates a new line.
- `$(cat /tmp/saini.txt)` reads the existing content.
- `>` writes the combined content back to the file.

Verify:

```bash
cat /tmp/saini.txt
```

---

## 12. Editing the File

The following editors were also opened during the task:

```bash
vi /tmp/saini.txt
```

and:

```bash
nano /tmp/saini.txt
```

However, the assignment specifically requested that editors should **not** be used for adding the content.

The non-editor command used earlier was:

```bash
echo -e "this is line at the beginning\n$(cat /tmp/saini.txt)" > /tmp/saini.txt
```

---

# Viewing File Contents

## 13. Display Top 5 Lines

Command used:

```bash
cat /tmp/saini.txt | head -n 5
```

`head -n 5` displays the first 5 lines.

A simpler equivalent command is:

```bash
head -n 5 /tmp/saini.txt
```

---

## 14. Display Bottom 2 Lines

Command used:

```bash
cat /tmp/saini.txt | tail -n 2
```

`tail -n 2` displays the last 2 lines.

A simpler equivalent:

```bash
tail -n 2 /tmp/saini.txt
```

---

## 15. Display Only the 6th Line

Command used:

```bash
cat /tmp/saini.txt | head -n 6 | tail -n 1
```

### How it works

First:

```bash
head -n 6
```

gets the first 6 lines.

Then:

```bash
tail -n 1
```

gets the last line from those 6 lines.

Therefore, the result is the **6th line**.

A simpler alternative is:

```bash
sed -n '6p' /tmp/saini.txt
```

---

## 16. Display Lines 3 to 8

Command used:

```bash
cat /tmp/saini.txt | head -n 8 | tail -n 6
```

This first gets lines 1–8 and then selects the last 6 lines from them, resulting in lines 3–8.

A simpler alternative is:

```bash
sed -n '3,8p' /tmp/saini.txt
```

---

# Listing `/tmp` Contents

## 17. List All Contents Including Hidden Files

Command used:

```bash
ls -la /tmp
```

Options:

- `-l` → long listing format
- `-a` → show hidden files

---

## 18. List Only Directories

Command used:

```bash
ls -la /tmp | grep ^d
```

The `^d` pattern matches lines beginning with `d`, which represents directories in the long listing format.

---

## 19. List Only Files

Command used:

```bash
ls -la /tmp | grep ^-
```

The `^-` pattern matches lines beginning with `-`, which represents regular files in the long listing format.

---

# Copy Operations

## 20. Copy `saini.txt` to `dir2`

Command used:

```bash
cp /tmp/saini.txt /tmp/dir1/dir2/
```

Verify:

```bash
ls /tmp/dir1/dir2
```

The file is now present as:

```text
/tmp/dir1/dir2/saini.txt
```

---

## 21. Create a Copy With a Different Name

Command used:

```bash
cp /tmp/dir1/dir2/saini.txt /tmp/dir1/dir2/saini_copy.txt
```

Verify:

```bash
ls /tmp/dir1/dir2
```

The directory contains:

```text
saini.txt
saini_copy.txt
```

> The assignment specified `last-name.copy`; in this execution, the filename used was `saini_copy.txt`.

---

# Rename and Move Operations

## 22. Rename the First-Name File

Command used:

```bash
mv /tmp/rahul.txt /tmp/rahul_new.txt
```

Verify:

```bash
ls /tmp
```

The file has been renamed from:

```text
rahul.txt
```

to:

```text
rahul_new.txt
```

---

## 23. Move `saini.txt` to `dir1`

Command used:

```bash
mv /tmp/saini.txt /tmp/dir1
```

Verify:

```bash
ls /tmp
```

Then:

```bash
ls /tmp/dir1
```

The file is now located at:

```text
/tmp/dir1/saini.txt
```

---

# Clear File Contents

## 24. Clear `saini_copy.txt`

First, check the help for `truncate`:

```bash
truncate --help
```

Then clear the file:

```bash
truncate -s 0 /tmp/dir1/dir2/saini_copy.txt
```

The `-s 0` option sets the file size to **0 bytes**.

Verify:

```bash
cat /tmp/dir1/dir2/saini_copy.txt
```

Since the file is empty, `cat` produces no output.

You can also check the size:

```bash
ls -l /tmp/dir1/dir2/saini_copy.txt
```

The file size should be:

```text
0
```

---

# Delete Files

## 25. Delete `saini_copy.txt`

Command used:

```bash
rm -rf /tmp/dir1/dir2/saini_copy.txt
```

Verify:

```bash
ls /tmp/dir1/dir2
```

---

## 26. Delete `saini.txt` From `dir2`

Command used:

```bash
rm -rf /tmp/dir1/dir2/saini.txt
```

Verify:

```bash
ls /tmp/dir1/dir2
```

---

# Delete Directories

## 27. Remove `dir2`

After removing the files from `dir2`, it became empty.

Command used:

```bash
rmdir /tmp/dir1/dir2
```

Verify:

```bash
ls /tmp/dir1
```

---

## 28. Remove `saini.txt` From `dir1`

Command used:

```bash
rm -rf /tmp/dir1/saini.txt
```

---

## 29. Remove `dir1`

After removing its contents:

```bash
rmdir /tmp/dir1
```

Verify:

```bash
ls /tmp
```

---

# Final Cleanup

The renamed first-name files were also removed:

```bash
rm -rf /tmp/rahul.txt
```

```bash
rm -rf /tmp/rahul_new.txt
```

Finally:

```bash
ls /tmp
```

This verifies the final contents of `/tmp`.

---

# Important Commands Summary

| Operation | Command Used |
|---|---|
| Create directory | `mkdir directory_name` |
| Create nested directories | `mkdir -p path` |
| List directory | `ls` |
| Detailed listing | `ls -l` |
| Show hidden files | `ls -la` |
| Show directory tree | `tree path` |
| Remove empty directory | `rmdir directory` |
| Create empty file | `touch file` |
| Write to file | `echo "text" > file` |
| Append to file | `echo "text" >> file` |
| Display file | `cat file` |
| First 5 lines | `head -n 5 file` |
| Last 2 lines | `tail -n 2 file` |
| Specific line | `head -n 6 file \| tail -n 1` |
| Line range | `head -n 8 file \| tail -n 6` |
| List only directories | `ls -la \| grep ^d` |
| List only files | `ls -la \| grep ^-` |
| Copy file | `cp source destination` |
| Move/rename file | `mv source destination` |
| Empty file | `truncate -s 0 file` |
| Delete file | `rm -rf file` |
| Remove empty directory | `rmdir directory` |
| Show command history | `history` |
| Clear terminal | `clear` |

---

# Final Directory Structure

During the assignment, the following structure was created:

```text
/tmp
└── dir1
    └── dir2
        └── dir3
```

Then `dir3` was removed:

```text
/tmp
└── dir1
    └── dir2
```

Files were subsequently created, copied, moved, cleared, and deleted as required.

At the end, the directories and files created for the assignment were cleaned up.

---

# Key Linux Concepts Learned

### 1. `mkdir`
Used to create directories.

```bash
mkdir directory
```

### 2. `mkdir -p`
Used to create nested directories in a single command.

```bash
mkdir -p /tmp/dir1/dir2/dir3
```

### 3. `touch`
Used to create an empty file.

```bash
touch file.txt
```

### 4. `>`
Writes content to a file and overwrites existing content.

```bash
echo "Hello" > file.txt
```

### 5. `>>`
Appends content without overwriting existing content.

```bash
echo "Hello Again" >> file.txt
```

### 6. `cp`
Copies files or directories.

```bash
cp source destination
```

### 7. `mv`
Moves or renames files.

```bash
mv old.txt new.txt
```

### 8. `head`
Displays the beginning of a file.

```bash
head -n 5 file.txt
```

### 9. `tail`
Displays the end of a file.

```bash
tail -n 2 file.txt
```

### 10. `truncate`
Changes the size of a file. Setting the size to zero clears the file.

```bash
truncate -s 0 file.txt
```

### 11. `rm`
Deletes files.

```bash
rm file.txt
```

### 12. `rmdir`
Deletes an empty directory.

```bash
rmdir directory
```

---

## Conclusion

This assignment provided practical experience with fundamental Linux commands used for directory management, file creation, file manipulation, viewing file contents, copying, moving, renaming, and deleting files and directories.