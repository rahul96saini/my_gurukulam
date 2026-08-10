Template Engine & Text Editor Utilities

This assignment contains two parts:

Part A: Create a simple template engine that replaces template variables with values supplied as command-line arguments.

Part B: Create a text editor utility that can perform common text manipulation operations on a file.

# Part A — Template Engine

## Objective

Create a template engine that reads a template file and replaces variables provided as command-line arguments.

## Syntax

./templateEngine.sh \<template-file> key1=value1 key2=value2

## Example Template

### File:

trainer.template

### Content:

Hello this is {{name}} from {{place}}.

### Command:

./templateEngine.sh trainer.template name=Rahul place=uttarakhand

### Output:

Hello this is Rahul from uttarakhand.

# How templateEngine.sh Works

1\. Get Template File

template="$1"

The first argument is the template file.

### Example:

./templateEngine.sh trainer.template name=Rahul place=uttarakhand

Therefore:

$1 = trainer.template

The variable stores:

template = trainer.template

2\. Shift the Arguments

- shift

### Before shift:

$1 = trainer.template
$2 = name=Rahul
$3 = place=uttarakhand

### After:

- shift

the template filename is removed from the positional parameter list.

The remaining arguments are the key-value pairs:

name=Rahul
place=uttarakhand

3\. Read Template Content

content=$(cat "$template")

This reads the complete template file and stores it in the content variable.

### For example:

Hello this is {{name}} from {{place}}.

4\. Process Key-Value Pairs

### The script uses:

for arg in "$@"
do
    ...
done

$@ represents all remaining command-line arguments.

For:

./templateEngine.sh trainer.template name=Rahul place=uttarakhand

the loop processes:

name=Rahul
place=uttarakhand

5\. Extract the Key

key=${arg%=\*}

For:

arg=name=Rahul

the result is:

key=name

The expression removes everything from the last = onward.

6\. Extract the Value

value=${arg#\*=}

For:

arg=name=Rahul

the result is:

value=Rahul

The expression removes everything up to the first =.

7\. Replace the Variable

content=$(echo "$content" | sed "s/{{${key}}}/$value/g")

For:

key=name
value=Rahul

the script replaces:

{{name}}

with:

Rahul

Then:

{{place}}

is replaced with:

linux

Final result:

Hello this is Rahul from uttarakhand.

# Template Engine Example

### Template

Hello this is {{name}} from {{place}}.

### Command

./templateEngine.sh trainer.template name=Rahul place=uttarakhand

### Output

Hello this is Rahul from uttarakhand.


## Screenshots


![Screenshot 0]\(partA/a5.a.png)

# Part B — Text Editor Utility

## Objective

Create a command-line text editor utility named:

otTextEditor

The utility should provide operations to:

- Add a line at the top

- Add a line at the bottom

- Add a line at a specific line number

- Replace the first occurrence of a word

- Replace all occurrences of a word

- Insert a word between two words

- Delete a line

- Delete a line containing a word

The script also implements two additional features:

- Count lines

- Convert file contents to uppercase

## Input File

The operations are performed on:

file.txt

Initial content:

LEARNING DEVOPS AT THE MYGURUKULUM

MY NAME IS RAHUL

UK GIVES YOU CHILLS AT WINTER

I WORK FROM HOME

PEOPLE AT GURUKULEM IS AMAZING

# Text Editor Operations

1\. Add a Line at the Top

### Command

./otTextEditor addLineTop file.txt "This is a new first line"

### Implementation

sed -i "1i $line" "$file"

### Explanation:

1 → first line

i → insert before the specified line

sed -i → modify the file directly

2\. Add a Line at the Bottom

### Command

./otTextEditor addLineBottom file.txt "This is the last line"

### Implementation

echo "$line" >> "$file"

The >> operator appends the line to the end of the file.

3\. Add a Line at a Specific Line Number

### Command

./otTextEditor addLineAt file.txt 3 "This is line three"

### Implementation

sed -i "${lineno}i $line" "$file"

For this example:

sed -i "3i This is line three" file.txt

The line is inserted before the existing line 3.

4\. Replace the First Occurrence of a Word

### Command

./otTextEditor updateFirstWord file.txt DEVOPS KUBERNETES

### Implementation

sed -i "0,/$old/s//$new/" "$file"

The command searches from the beginning of the file and replaces only the first matching occurrence.

5\. Replace All Occurrences of a Word

### Command

./otTextEditor updateAllWords file.txt RAHUL SURESH

### Implementation

sed -i "s/$old/$new/g" "$file"

### Here:

s = substitute
g = global

Therefore, every occurrence of the old word is replaced.

6\. Insert a Word

### Command

./otTextEditor insertWord file.txt DEVOPS MYGURUKULUM AT

The script searches for:

DEVOPS MYGURUKULUM

and changes it to:

DEVOPS AT MYGURUKULUM

### Implementation

sed -i "s/$word1 $word2/$word1 $insert $word2/g" "$file"

7\. Delete a Line

### Command

./otTextEditor deleteLine file.txt 3

### Implementation

sed -i "${lineno}d" "$file"

### Here:

d = delete

The specified line is removed from the file.

8\. Delete a Line Containing a Word

### Command

./otTextEditor delLineWord file.txt WINTER

### Implementation

sed -i "/$word/d" "$file"

The command searches for the word and deletes the entire line containing it.

9\. Count Lines

This is an additional feature implemented in the text editor.

### Command

./otTextEditor countLines file.txt

### Implementation

wc -l < "$file"

wc -l counts the number of lines in the file.

10\. Convert File to Uppercase

This is another additional feature.

### Command

./otTextEditor upperCase file.txt

### Implementation

sed -i "s/.\*/\U&/" "$file"

### Explanation:

.\* matches the complete line.

& represents the matched text.

\U converts the matched text to uppercase.

sed -i saves the changes directly to the file.

# Command Summary

| Operation | Command | Main Linux Command |
|---|---|---|
| Add line at top | `addLineTop` | `sed` |
| Add line at bottom | `addLineBottom` | `echo >>` |
| Add line at specific line | `addLineAt` | `sed` |
| Replace first word | `updateFirstWord` | `sed` |
| Replace all words | `updateAllWords` | `sed` |
| Insert word | `insertWord` | `sed` |
| Delete line | `deleteLine` | `sed` |
| Delete line containing word | `delLineWord` | `sed` |
| Count lines | `countLines` | `wc` |
| Uppercase file | `upperCase` | `sed` |

# Complete Usage Examples

Add Line at Top

./otTextEditor addLineTop file.txt "New first line"

Add Line at Bottom

./otTextEditor addLineBottom file.txt "New last line"

Add Line at Specific Position

./otTextEditor addLineAt file.txt 3 "New line at position 3"

Replace First Word

./otTextEditor updateFirstWord file.txt DEVOPS KUBERNETES

Replace All Words

./otTextEditor updateAllWords file.txt RAHUL SURESH

Insert Word

./otTextEditor insertWord file.txt DEVOPS MYGURUKULUM AT

Delete Line

./otTextEditor deleteLine file.txt 3

Delete Line Containing Word

./otTextEditor delLineWord file.txt WINTER

### Count Lines

./otTextEditor countLines file.txt

Convert to Uppercase

./otTextEditor upperCase file.txt

# Important Bash Concepts Used

## Positional Parameters

The text editor uses positional parameters:

cmd=$1
file=$2

### For example:

./otTextEditor updateAllWords file.txt RAHUL SURESH

### The values are:

$1 = updateAllWords
$2 = file.txt
$3 = RAHUL
$4 = SURESH

### For addLineAt:

./otTextEditor addLineAt file.txt 3 "New line"

### the values are:

$1 = addLineAt
$2 = file.txt
$3 = 3
$4 = New line

## case Statement

### The script uses:

case "$cmd" in

to determine which text editing operation should be executed.

### For example:

case "$cmd" in

addLineTop)
    ...
    ;;

addLineBottom)
    ...
    ;;

deleteLine)
    ...
    ;;

esac

## sed -i

Most editing operations use:

## sed -i

The -i option modifies the file directly rather than only displaying the result.

## Redirection

The addLineBottom operation uses:

echo "$line" >> "$file"

The >> operator appends content without overwriting the existing file.

# Additional Features

The assignment asks for additional features, and the implementation includes:

### Count Lines

./otTextEditor countLines file.txt

Uses:

wc -l < file.txt

### Uppercase

./otTextEditor upperCase file.txt

Converts the complete file content to uppercase.

# Note About Command Name

The assignment specifies:

./otTextEditor deleteLineWord \<file> \<line no> \<word>

However, the implemented script uses:

delLineWord)

and accepts:

./otTextEditor delLineWord file.txt WINTER

There is also a difference in the assignment's example and implementation: the assignment mentions a line number for deleteLineWord, but the current script only takes the word and deletes every line containing that word.

Therefore, the current implementation should be considered a word-based line deletion operation rather than a line-number-and-word operation.

# Important Observation

The assignment asks for a text editor utility and the current implementation uses sed extensively for editing.

This is appropriate because Part B does not prohibit sed.

The script demonstrates practical usage of:

sed
echo
wc
cat
case
positional parameters
shell variables
file redirection

# Running the Scripts

Make both scripts executable:

chmod +x templateEngine.sh
chmod +x otTextEditor

Run the template engine:

./templateEngine.sh trainer.template name=Rahul place=uttarakhand

Run the text editor:

./otTextEditor countLines file.txt

or:

./otTextEditor addLineTop file.txt "New first line"


## Screenshots


![Screenshot 1]\(partB/a5.b.1.png)
![Screenshot 2]\(partB/a5.b.2.png)
![Screenshot 3]\(partB/a5.b.3.png)

# Conclusion

This assignment demonstrates two useful Bash scripting utilities.

# Part A — Template Engine

templateEngine.sh demonstrates:

- Reading a template file

- Command-line arguments

- Positional parameters

- shift

- Processing key-value pairs

- Shell parameter expansion

- Variable substitution using sed

### Example:

./templateEngine.sh trainer.template name=Rahul place=uttarakhand

### Output:

Hello this is Rahul from uttarakhand.

# Part B — Text Editor

otTextEditor demonstrates:

- Adding lines

- Deleting lines

- Replacing words

- Inserting words

- Counting lines

- Converting text to uppercase

- case statements

- Positional parameters

- sed editing commands

- File redirection

Together, both scripts provide practical experience in building command-line utilities using Bash.