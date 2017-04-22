# Disable ctrl-s suspend
stty -ixon

# Notes on colors
# http://www.bigsoft.co.uk/blog/index.php/2008/04/11/configuring-ls_colors
# Can print defaults with 'dircolors' command

#Note, adding some extra colons before and after option for safety
# Show directories in purple
LS_COLORS=$LS_COLORS:'di=0;35:' ; export LS_COLORS

#Show "other_writable" directories the same (without green background)
LS_COLORS=$LS_COLORS:'ow=0;35:' ; export LS_COLORS

# Also show colors with grep
alias grep='grep --color=auto'

# Show all history in less
# This is a centos workaround.
# 'history' shows all lines as expected in ubuntu
# Not sure why 1 is giving all lines, but works for me
alias hist='history 1 | less'

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
    find -regex '.*\.\(c\|cpp\|h\|x\|cxx\|cc\|hpp\)' -exec grep -i "$1" -Hn --color {} \;
}

#case sensitive
fgcc () {
    find -regex '.*\.\(c\|cpp\|h\|x\|cxx\|cc\|hpp\)' -exec grep "$1" -Hn --color {} \;
}

typesize () {
    ftypes=$(find . -type f | grep -E ".*\.[a-zA-Z0-9]*$" | sed -e 's/.*\(\.[a-zA-Z0-9]*\)$/\1/' | sort | uniq)

    for ft in $ftypes
    do
        echo -ne "$ft\t"
        find . -name "*${ft}" -exec du -bcsh '{}' + | tail -1 | sed 's/\stotal//'
    done
}

# Produces sorted list of duplicated basenames in tree.
# Useful for finding common files to ignore
namecount() {
    find . -type f -printf "%f\n" | sort | uniq -cd | sort -n
}
