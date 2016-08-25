# bash-bookmarks

Simple bash bookmarks.

## Installation

    $ git clone https://github.com/BobuSumisu/bash-bookmarks.git

Add to `.bashrc`:

    [[ -f /path/to/bash_bookmarks.sh ]] && . /path/to/bash_bookmarks.sh

## Usage

Bookmark current working directory with:

    $ bb add home
    [bb] Bookmark added!

You can now visit it using:

    $ bb home
    [bb] Changing directory to /home/oyvind

To see all bookmarks:

    $ bb list
    NAME    PATH
    home    /home/oyvind

And delete a bookmark:

    $ bb delete home
    [bb] Bookmark 'home' deleted!
    $ bb list
    [bb] You do not have any bookmarks yet :(

See usage for more information:

	$ bb
	Usage:  [<command>] [<name>]

	Where command is one of:
		goto <name>     Change directory to a bookmark by name.
		add <name>      Add a new bookmark with a unique name.
		delete <name>   Delete a bookmark by name.
		list            List all bookmarks.
		help            Show this help message.

	If no command is given, the command defaults to 'goto'
	and the argument is treated as a bookmark name.

## Limitations

You cannot use the command names as names for bookmarks (i.e.: "goto", "add", "delete", "list" and "help")
