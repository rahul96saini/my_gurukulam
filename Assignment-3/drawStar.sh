#!/bin/bash

# Check arguments
if [ $# -ne 2 ]; then
    echo "Usage: $0 <size> <type>"
    exit 1
fi

size=$1
type=$2

case $type in

t1)
# Right triangle (right aligned)
for ((i=1;i<=size;i++))
do
    for ((j=size-i;j>=1;j--))
    do
        printf " "
    done
    for ((k=1;k<=i;k++))
    do
        printf "*"
    done
    echo
done
;;

t2)
# Left aligned triangle
for ((i=1;i<=size;i++))
do
    for ((j=1;j<=i;j++))
    do
        printf "*"
    done
    echo
done
;;

t3)
# Pyramid
for ((i=1;i<=size;i++))
do
    for ((j=size-i;j>=1;j--))
    do
        printf " "
    done

    for ((k=1;k<=2*i-1;k++))
    do
        printf "*"
    done
    echo
done
;;

t4)
# Inverted left triangle
for ((i=size;i>=1;i--))
do
    for ((j=1;j<=i;j++))
    do
        printf "*"
    done
    echo
done
;;

t5)
# Inverted right triangle
for ((i=size;i>=1;i--))
do
    for ((j=1;j<=size-i;j++))
    do
        printf " "
    done

    for ((k=1;k<=i;k++))
    do
        printf "*"
    done
    echo
done
;;

t6)
# Inverted pyramid
for ((i=size;i>=1;i--))
do
    for ((j=1;j<=size-i;j++))
    do
        printf " "
    done

    for ((k=1;k<=2*i-1;k++))
    do
        printf "*"
    done
    echo
done
;;

t7)
# Diamond

# Upper Pyramid
for ((i=1;i<=size;i++))
do
    for ((j=size-i;j>=1;j--))
    do
        printf " "
    done

    for ((k=1;k<=2*i-1;k++))
    do
        printf "*"
    done
    echo
done

# Lower Pyramid
for ((i=size-1;i>=1;i--))
do
    for ((j=1;j<=size-i;j++))
    do
        printf " "
    done

    for ((k=1;k<=2*i-1;k++))
    do
        printf "*"
    done
    echo
done
;;

*)
echo "Invalid Type"
;;

esac
