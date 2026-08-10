# Shell Scripting Assignment — Star Patterns & Tomcat

This assignment contains two parts:

- **Part A:** Create a shell script to generate different star (`*`) patterns.
- **Part B:** Create a shell script that prints tom, cat, or tomcat based on divisibility.

# Part A — Star Pattern Generator

## Objective

Create a shell script named `drawStar.sh` that accepts two arguments:

```bash
./drawStar.sh <size> <type>
```

Where:

- `size` specifies the size of the pattern.
- `type` specifies which star pattern should be generated.

### Example

```bash
./drawStar.sh 5 t1
```

The script supports seven pattern types:

```text
t1
t2
t3
t4
t5
t6
t7
```

# How drawStar.sh Works

## 1. Check Number of Arguments

```bash
if [ $# -ne 2 ]; then
    echo "Usage: $0 <size> <type>"
    exit 1
fi
```

`$#` contains the number of arguments passed to the script.

The script requires exactly two arguments:

- `$1` → size
- `$2` → type

For example:

```bash
./drawStar.sh 5 t1
```

means:

```text
$1 = 5
$2 = t1
```

If the user does not provide exactly two arguments, the script displays the usage message and exits.

## 2. Store Arguments in Variables

```bash
size=$1
type=$2
```

This makes the script easier to read.

For:

```bash
./drawStar.sh 5 t3
```

the variables become:

```text
size = 5
type = t3
```

## 3. Select the Pattern Using case

```bash
case $type in
```

The case statement checks the value of `type` and executes the matching pattern.

For example:

```bash
t1)
...
;;
```

runs when:

```text
type=t1
```

# Pattern Types

## T1 — Right-Aligned Triangle

### Command

```bash
./drawStar.sh 5 t1
```

### Output

```text
    *
   **
  ***
 ****
*****
```

### Logic

The first loop controls the rows:

```bash
for ((i=1;i<=size;i++))
```

The second loop prints spaces:

```bash
for ((j=size-i;j>=1;j--))
```

The third loop prints stars:

```bash
for ((k=1;k<=i;k++))
```

As the row number increases:

- Spaces decrease.
- Stars increase.

## T2 — Left-Aligned Triangle

### Command

```bash
./drawStar.sh 5 t2
```

### Output

```text
*
**
***
****
*****
```

### Logic

The outer loop controls rows:

```bash
for ((i=1;i<=size;i++))
```

The inner loop prints i stars:

```bash
for ((j=1;j<=i;j++))
```

Therefore:

```text
Row 1 → 1 star
Row 2 → 2 stars
Row 3 → 3 stars
...
```

## T3 — Pyramid

### Command

```bash
./drawStar.sh 5 t3
```

### Output

```text
    *
   ***
  *****
 *******
*********
```

### Logic

The script first prints spaces:

```bash
for ((j=size-i;j>=1;j--))
```

Then it prints:

```text
2*i-1
```

stars:

```bash
for ((k=1;k<=2*i-1;k++))
```

The number of stars becomes:

```text
1
3
5
7
9
```

This creates the pyramid shape.

## T4 — Inverted Left Triangle

### Command

```bash
./drawStar.sh 5 t4
```

### Output

```text
*****
****
***
**
*
```

### Logic

The outer loop starts from size and decreases:

```bash
for ((i=size;i>=1;i--))
```

The inner loop prints i stars.

Therefore the number of stars decreases on every row.

## T5 — Inverted Right Triangle

### Command

```bash
./drawStar.sh 5 t5
```

### Output

```text
*****
 ****
  ***
   **
    *
```

### Logic

The outer loop decreases:

```bash
for ((i=size;i>=1;i--))
```

The first inner loop adds spaces:

```bash
for ((j=1;j<=size-i;j++))
```

The second inner loop prints stars:

```bash
for ((k=1;k<=i;k++))
```

As the rows progress:

- Spaces increase.
- Stars decrease.

## T6 — Inverted Pyramid

### Command

```bash
./drawStar.sh 5 t6
```

### Output

```text
*********
 *******
  *****
   ***
    *
```

### Logic

The number of rows is controlled by:

```bash
for ((i=size;i>=1;i--))
```

The script prints:

```text
2*i-1
```

stars.

The number of stars becomes:

```text
9
7
5
3
1
```

At the same time, the number of leading spaces increases.

## T7 — Diamond

### Command

```bash
./drawStar.sh 5 t7
```

### Output

```text
    *
   ***
  *****
 *******
*********
 *******
  *****
   ***
    *
```

The diamond consists of two parts:

- Upper pyramid
- Lower inverted pyramid

### Upper Pyramid

```bash
for ((i=1;i<=size;i++))
```

creates the upper half.

The number of stars is:

```text
2*i-1
```

### Lower Pyramid

```bash
for ((i=size-1;i>=1;i--))
```

creates the lower half.

It starts at size-1 so that the widest row is not printed twice.

# Star Pattern Summary

| Type | Pattern |
|---|---|
| `t1` | Right-aligned triangle |
| `t2` | Left-aligned triangle |
| `t3` | Pyramid |
| `t4` | Inverted left triangle |
| `t5` | Inverted right triangle |
| `t6` | Inverted pyramid |
| `t7` | Diamond |

# Important Concepts Used in Part A

## for Loop

Used to repeat operations.

Example:

```bash
for ((i=1;i<=size;i++))
do
    ...
done
```

## Nested Loops

The patterns use loops inside other loops.

For example:

- Outer loop → controls rows
- Inner loop → controls spaces/stars

## printf

The script uses:

```bash
printf "*"
```

to print a star without automatically moving to a new line.

It uses:

```bash
echo
```

after each row to move to the next line.

![Screenshot 1](a3.1.png)

# Part B — Tom Cat / Tomcat

## Objective

Create a shell script named `printTomcat.sh` that accepts a number and prints output based on divisibility.

### Rules

- **Divisible by 15 →** tomcat
- **Divisible by 5 →** cat
- **Divisible by 3 →** tom
- **Otherwise →** display a message indicating that the number is not divisible by 3, 5, or 15.

# How printTomcat.sh Works

## 1. Read the Number

```bash
read -p "enter a number = " num
```

The read command takes input from the user and stores it in the variable `num`.

Example:

```text
enter a number = 30
```

Then:

```text
num = 30
```

## 2. Check Divisibility by 15

```bash
if (( num % 15 == 0 )); then
    echo "tomcat"
```

The `%` operator returns the remainder.

For example:

```text
30 % 15 = 0
```

Therefore, 30 is divisible by 15 and the script prints:

```text
tomcat
```

## 3. Check Divisibility by 5

```bash
elif (( num % 5 == 0 )); then
    echo "cat"
```

For example:

```text
10 % 5 = 0
```

Therefore:

```text
cat
```

## 4. Check Divisibility by 3

```bash
elif (( num % 3 == 0 )); then
    echo "tom"
```

For example:

```text
6 % 3 = 0
```

Therefore:

```text
tom
```

## 5. If None of the Conditions Match

```bash
else
    echo "entered number is not divisible ny 3, 5 or 15"
fi
```

For example:

```text
7
```

7 is not divisible by 3, 5, or 15, so the else block executes.

> **Note:** The original script contains the typo `ny`. A cleaner message would be by 3, 5 or 15.

# Example Outputs

## Input: 7

```bash
./printTomcat.sh
```

Input:

```text
enter a number = 7
```

Output:

```text
entered number is not divisible ny 3, 5 or 15
```

## Input: 6

```text
enter a number = 6
```

Output:

```text
tom
```

Because:

```text
6 % 3 = 0
```

## Input: 10

```text
enter a number = 10
```

Output:

```text
cat
```

Because:

```text
10 % 5 = 0
```

## Input: 30

```text
enter a number = 30
```

Output:

```text
tomcat
```

Because:

```text
30 % 15 = 0
```

# Why the 15 Condition Comes First

The order of the conditions is important.

The script checks:

```bash
if (( num % 15 == 0 ))
```

before:

```bash
elif (( num % 5 == 0 ))
```

and:

```bash
elif (( num % 3 == 0 ))
```

This is necessary because every number divisible by 15 is also divisible by both 3 and 5.

For example:

```text
30 % 15 = 0
30 % 5  = 0
30 % 3  = 0
```

If the script checked divisibility by 3 first, 30 would produce:

```text
tom
```

instead of:

```text
tomcat
```

Therefore, the most specific condition is checked first.

# Part B Logic

```text
         Number
            |
            v
    Divisible by 15?
       /        \
     Yes         No
      |           |
   tomcat    Divisible by 5?
                /       \
              Yes        No
               |          |
              cat    Divisible by 3?
                          /      \
                        Yes       No
                         |         |
                        tom       Message
```

# Commands and Concepts Used

| Concept | Used In |
|---|---|
| Bash script | Both |
| Command-line arguments | `drawStar.sh` |
| Positional parameters `$1`, `$2` | `drawStar.sh` |
| `$#` | `drawStar.sh` |
| case statement | `drawStar.sh` |
| for loop | `drawStar.sh` |
| Nested loops | `drawStar.sh` |
| printf | `drawStar.sh` |
| echo | Both |
| read | `printTomcat.sh` |
| if / elif / else | `printTomcat.sh` |
| Arithmetic evaluation `(( ))` | `printTomcat.sh` |
| Modulo `%` | `printTomcat.sh` |

# Running the Scripts

First make the scripts executable:

```bash
chmod +x drawStar.sh
chmod +x printTomcat.sh
```

Then run Part A:

```bash
./drawStar.sh 5 t1
```

or:

```bash
./drawStar.sh 5 t7
```

Run Part B:

```bash
./printTomcat.sh
```

Then enter a number when prompted.

![Screenshot 2](a3.2.png)

# Conclusion

This assignment provides practical experience with Bash scripting, loops, conditional statements, arithmetic operations, command-line arguments, and pattern generation.

## Part A

`drawStar.sh` demonstrates:

- Positional parameters
- Argument validation
- case statements
- Nested for loops
- Printing spaces and stars
- Generating seven different patterns

## Part B

`printTomcat.sh` demonstrates:

- User input with read
- Arithmetic evaluation
- Modulo operator %
- if, elif, and else
- Checking multiple divisibility conditions

Together, both scripts provide a practical introduction to basic Bash programming concepts.