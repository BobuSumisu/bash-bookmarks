# bash-bookmarks

Simple bash bookmarks.

## Installation

    $ git clone ...

Add to `.bashrc`:

    [[ -f /path/to/bash_bookmarks.sh ]] && . /path/to/bash_bookmarks.sh

## Usage

	~$ bb
    Usage:  [<command>] [<name>]

    Where command is one of:
        goto <name>     Change directory to a bookmark by name.
        add <name>      Add a new bookmark with a unique name.
        delete <name>   Delete a bookmark by name.
        list            List all bookmarks.
        help            Show this help message.

    If no command is given, the command defaults to 'goto'
    and the argument is treated as a bookmark name.

    ~$ bb list
    [bb] You do not have any bookmarks yet :(
    ~$ bb add home
    [bb] Bookmark added!
    ~$ cd /tmp
    /tmp$ bb add tmp
    [bb] Bookmark added!
    /tmp$ bb home
    [bb] Changing directory to /home/oyvind
    ~$ bb tmp
    [bb] Changing directory to /tmp
    /tmp$ bb list
    NAME	PATH
    home	/home/oyvind
    tmp	/tmp
    /tmp$ bb delete tmp
    [bb] Bookmark 'tmp' deleted!
    /tmp$ bb home
    [bb] Changing directory to /home/oyvind
    ~$ bb list
    NAME	PATH
    home	/home/oyvind
