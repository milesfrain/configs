# Disable ctrl-s suspend
stty -ixon

fvi () {
    find_result=$(find . -name "*$1*")
    num_matches=$(echo "$find_result" | wc -w)

    if [ $num_matches == 0 ]
    then
        # no matches
        echo "cannot find $1"
    elif [ $num_matches == 1 ]
    then
        # single match
        ${EDITOR:-vi} $find_result
    else
        # multiple matches
        local PS3="Choose a file to edit: "
        select opt in $find_result
        do
            ${EDITOR:-vi} "$opt"
            break
        done
    fi
}

epoch () {
    date --reference=$1 +%s
}

fgpl () {
    find -regex '.*\.\(pm\|pl\)' -exec grep -i "$1" -Hn --color {} \;
}

#case sensitive
fgplc () {
    find -regex '.*\.\(pm\|pl\)' -exec grep "$1" -Hn --color {} \;
}

fgc () {
    find -regex '.*\.\(c\|cpp\|h\|x\|cxx\)' -exec grep -i "$1" -Hn --color {} \;
}

#case sensitive
fgcc () {
    find -regex '.*\.\(c\|cpp\|h\|x\|cxx\)' -exec grep "$1" -Hn --color {} \;
}

typesize () {
    ftypes=$(find . -type f | grep -E ".*\.[a-zA-Z0-9]*$" | sed -e 's/.*\(\.[a-zA-Z0-9]*\)$/\1/' | sort | uniq)

    for ft in $ftypes
    do
        echo -ne "$ft\t"
        find . -name "*${ft}" -exec du -bcsh '{}' + | tail -1 | sed 's/\stotal//'
    done
}
