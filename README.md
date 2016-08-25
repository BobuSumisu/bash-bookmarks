# bash-bookmarks

Simple bash bookmarks.

## Installation

    $ git clone https://github.com/BobuSumisu/bash-bookmarks.git

Add to `.bashrc`:

    [[ -f /path/to/bash_bookmarks.sh ]] && . /path/to/bash_bookmarks.sh

If you want bash completion, move `bash_bookmarks_completion.sh` to `/etc/bash_completion.d/`
(or your OS's equivalent).

## Usage

Bookmark current working directory with:

    $ bb --add home
    [bb] Bookmark added!

You can now visit it using:

    $ bb home
    [bb] Changing directory to /home/oyvind

To see all bookmarks:

    $ bb --list
    NAME    PATH
    home    /home/oyvind

And delete a bookmark:

    $ bb --delete home
    [bb] Bookmark 'home' deleted!
    $ bb --list
    [bb] You do not have any bookmarks yet :(

See usage for more information:

	$ bb --help
	Usage: bb [<command>] [<name>]

	Where command is one of:
		-g, --goto <name>     Change directory to a bookmark by name.
		-a, --add <name>      Add a new bookmark with a unique name.
		-d, --delete <name>   Delete a bookmark by name.
		-l, --list            List all bookmarks.
		-h, --help            Show this help message.

	If no command is given, the command defaults to 'goto'
	and the argument is treated as a bookmark name.

