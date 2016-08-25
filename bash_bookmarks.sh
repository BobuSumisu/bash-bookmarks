#!/bin/bash

BASH_BOOKMARKS_FILE=~/.bash_bookmarks

function bb() {
    info() {
        echo "[bb] $1"
    }

    count() {
        wc -l $BASH_BOOKMARKS_FILE | cut -d' ' -f1
    }

    lookup_by_name() {
        grep --color=never "^$1:.*$" $BASH_BOOKMARKS_FILE
    }

    lookup_by_path() {
        grep --color=never "^[^:]\+:$1$" $BASH_BOOKMARKS_FILE
    }

    get_name() {
        echo -n $1 | cut -d':' -f1
    }

    get_path() {
        echo -n $1 | cut -d':' -f2
    }

    get_line() {
        echo -n "$(get_name $1):$(get_path $1)"
    }

    add() {
        # Check if a bookmark with the given name exists.
        bookmark=$(lookup_by_name $1)
        if [[ ! -z $bookmark ]]; then
            info "Bookmark with name '$1' already exists ($(get_path $bookmark))"
            return 1
        fi

        # Check if a bookmark to current path exists.
        bookmark=$(lookup_by_path $(pwd))
        if [[ ! -z $bookmark ]]; then
            info "Bookmark for current directory already exists: $(get_name $bookmark)"
            return 1
        fi

        # All good. Add new bookmark.
        echo "$1:$(pwd)" >> $BASH_BOOKMARKS_FILE
        info "Bookmark added!"

        return 0
    }

    delete() {
        bookmark=$(lookup_by_name $1)
        if [[ -z $bookmark ]]; then
            info "Bookmark '$1' not found!"
            return 1
        fi

        sed -i "/$(get_line $bookmark | sed 's|\/|\\/|g')/d" $BASH_BOOKMARKS_FILE
        info "Bookmark '$1' deleted!"

        return 0
    }

    list() {
        if [[ $(count) == 0 ]]; then
            info "You do not have any bookmarks yet :("
        else
            cat <(echo "NAME:PATH") $BASH_BOOKMARKS_FILE | sed 's/:/\t/g' | column -t -s ":"
        fi
    }

    goto() {
        bookmark=$(lookup_by_name $1)
        if [[ -z $bookmark ]]; then
            info "Bookmark '$1' not found!"
            return 1
        elif [[ $(get_path $bookmark) == $(pwd) ]]; then
            info "You are already in $(get_path $bookmark)"
            return 1
        fi
        info "Changing directory to $(get_path $bookmark)"
        cd $(get_path $bookmark)
    }

    usage() {
    cat << EOF
Usage: bb [<command>] [<name>]

Where command is one of:
    -g, --goto <name>     Change directory to a bookmark by name.
    -a, --add <name>      Add a new bookmark with a unique name.
    -d, --delete <name>   Delete a bookmark by name.
    -l, --list            List all bookmarks.
    -h, --help            Show this help message.

If no command is given, the command defaults to 'goto'
and the argument is treated as a bookmark name.

EOF
    }

    check_arg() {
        if [[ -z $1 ]]; then
            usage
            return 1
        fi
    }

    # Ensure the bookmarks file exists.
    if [[ ! -f $BASH_BOOKMARKS_FILE ]]; then
        touch $BASH_BOOKMARKS_FILE
    fi

    case $1 in
        -a|--add)
            check_arg $2 && add $2
            ;;
        -d|--delete)
            check_arg $2 && delete $2
            ;;
        -g|--goto)
            check_arg $2 && goto $2
            ;;
        -l|--list)
            list
            ;;
        -h|--help)
            usage
            return 0
            ;;
        *)
            if [[ -z $1 ]]; then
                usage
                return 1
            fi
            goto $1
            ;;
    esac
}

_bb() {
    local cur prev cmds bookmarks

    COMPREPLY=()

    cur=${COMP_WORDS[COMP_CWORD]}
    prev=${COMP_WORDS[COMP_CWORD-1]}

    if [[ $cur == -* ]]; then
        cmds="--add --delete --goto --list --help"
        COMPREPLY=( $(compgen -W "$cmds" -- $cur) )
    else
        bookmarks="$(cat $BASH_BOOKMARKS_FILE | cut -d':' -f1 | tr '\n' ' ')"
        COMPREPLY=( $(compgen -W "$bookmarks" -- $cur) )
    fi
}
complete -F _bb bb
