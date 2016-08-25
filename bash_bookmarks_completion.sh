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
