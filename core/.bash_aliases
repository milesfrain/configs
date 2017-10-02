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

# Todo - verify this works
alias git-date="git for-each-ref --sort=-committerdate --format='%(refname:short)' refs/heads/"

fvi () {
    find_result=$(find . -name "*$1*")
    num_matches=$(echo "$find_result" | wc -w)
    if [ $num_matches = 0 ]
    then
        # no matches
        echo "cannot find $1"
    elif [ $num_matches = 1 ]
    then
        # single match
        # add line to history
        print -s ${EDITOR:-vim} $find_result
        # open match
        ${EDITOR:-vim} $find_result
    else
        # multiple matches
        local PS3="Choose a file to edit: "
        #select opt in $find_result
        # The below fix is necessary for zsh avoid treating list of results as single blob.
        # See http://zsh.sourceforge.net/FAQ/zshfaq03.html
        select opt in ${=find_result}
        do
            # add line to history
            print -s ${EDITOR:-vim} "$opt"
            # open match
            ${EDITOR:-vim} "$opt"
            break
        done
    fi
}

# Run command on found file
fop () {
    find_result=$(find . -name "*$2*")
    num_matches=$(echo "$find_result" | wc -w)
    if [ $num_matches = 0 ]
    then
        # no matches
        echo "cannot find $2"
    elif [ $num_matches = 1 ]
    then
        # single match
        # add line to history
        print -s $1 $find_result
        # open match
        $1 $find_result
    else
        # multiple matches
        local PS3="Choose a file to $1: "
        #select opt in $find_result
        # The below fix is necessary for zsh avoid treating list of results as single blob.
        # See http://zsh.sourceforge.net/FAQ/zshfaq03.html
        select opt in ${=find_result}
        do
            # add line to history
            print -s $1 "$opt"
            # open match
            $1 "$opt"
            break
        done
    fi
}

epoch () {
    date --reference=$1 +%s
}

rgrep () {
    grep -r "$1" . --color
}

# Any extension
fgext () {
    find -regex '.*\.'"$1" -exec grep -i "$2" -Hn --color {} \;
}

#case sensitive
fgextc () {
    find -regex '.*\.'"$1" -exec grep "$2" -Hn --color {} \;
}

fgtsx () {
    find -regex '.*\.tsx' -exec grep -i "$1" -Hn --color {} \;
}

#case sensitive
fgtsxc () {
    find -regex '.*\.tsx' -exec grep "$1" -Hn --color {} \;
}

fgpy () {
    find -regex '.*\.py' -exec grep -i "$1" -Hn --color {} \;
}

#case sensitive
fgpyc () {
    find -regex '.*\.py' -exec grep "$1" -Hn --color {} \;
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

pipreinstall () {
     pip install --ignore-installed --no-deps "$@"
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
