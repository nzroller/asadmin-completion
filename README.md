asadmin-completion
==================

Bash completion support for [asadmin](http://docs.oracle.com/cd/E18930_01/html/821-2416/giobi.html).

The contained completion routines provide support for completing:

 * asadmin undeploy - tab complete on deployed modules
 * asadmin deploy - lists directories and java archives (ear, war and jar)


Installation for Bash
---------------------

To achieve asadmin completion nirvana:

 0. Install bash-completion.

 1. Install this file. Either:

    a. Place it in a `bash-completion.d` folder:

       * /etc/bash-completion.d
       * /usr/local/etc/bash-completion.d
       * ~/bash-completion.d

    b. Or, copy it somewhere (e.g. ~/.asadmin-completion.bash) and put the following line in
       your .bashrc:

           source ~/.asadmin-completion.bash
