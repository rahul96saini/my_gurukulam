#!/bin/bash

read -p "enter a number = " num

if (( num % 15 == 0 )); then
    echo "tomcat"
elif (( num % 5 == 0 )); then
    echo "cat"
elif (( num % 3 == 0 )); then
    echo "tom"
else
    echo "entered number is not divisible ny 3, 5 or 15"
fi
