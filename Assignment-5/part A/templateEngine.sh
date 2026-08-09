#!/bin/bash


#captures the path of template file which is passed in positional argument $1
template="$1"

#shift arguments to the left so only keyvalue pairs read
shift

#content is variable where data is saved coming from template variable
content=$(cat "$template")

#distinguish key value pairs in CL arguments $@
for arg in "$@"
do

    #extract key by removing right side of argument including = , % right to left
    key=${arg%=*}

    #extract value by removing left side of argument including = , # left to right
    value=${arg#*=}

    #take data from content vaiable and send it to sed to replace key, value
    content=$(echo "$content" | sed "s/{{${key}}}/$value/g")

    done

echo "$content"
