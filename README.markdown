# git-pair

A git porcelain for changing `user.name` and `user.email` so you can commit as
more than one author.

## Usage

Install the gem:

    gem install neo-git-pair

And here's how to use it! 

    $ git pair

    General Syntax:
      git pair [reset | authors | options]

    Options:
        -a, --add AUTHOR                 Add an author. Format: "Author Name <author@example.com>"
        -r, --remove NAME                Remove an author. Use the full name.
        -d, --reset                      Reset current author to default (global) config

    Switching authors:
      git pair aa [bb]                   Where AA and BB are any abbreviation of an
                                         author's name. You can specify one or more authors.

    Current config:
         Author list: Adam McCrea
                      Jon Distad

      Current author: Jon Distad + Adam McCrea
       Current email: devs+jd+am@neo.com

## How does it work?

The list of authors is maintained in the global git configuration file.  
The current author is set in the git configuration local to the project.
The email address for a pair is generated using the default email address
from the global configuration along with the developer abbreviations.

## About this version

This was forked from http://github.com/chrisk/git-pair.  Many thanks to
Chris Kampmeier for the original version.  Our version added the --reset
option, modified how email addresses are handled, and refactored much of 
the code.

## License

Copyright (c) 2009 Chris Kampmeier. See `LICENSE` for details.
