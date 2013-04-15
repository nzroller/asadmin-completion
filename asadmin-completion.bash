# bash completion for asadmin(1) -*- shell-script -*-
#
# asadmin-completion
# ===================
#
# Bash completion support for [Glassfish](http://glassfish.java.net) `asadmin'
#
# The contained completion routines provide support for completing:
#
#  * asadmin start-domain, stop-domain, list-applications
#  * deploy war, jar or ear files
#  * deploy directories
#
#
# Installation
# ------------
#
# To achieve asadmin completion nirvana:
#
#  0. Install bash-completion.
#
#  1. Install this file. Either:
#
#     a. Place it in a `bash-completion.d` folder:
#
#        * /etc/bash-completion.d
#        * /usr/local/etc/bash-completion.d
#        * ~/bash-completion.d
#
#     b. Or, copy it somewhere (e.g. ~/.asadmin-completion.bash) and put the following line in
#        your .bashrc:
#
#            source ~/.asadmin-completion.bash
#

_have asadmin &&
_asadmin_list_commands()
{
		echo "
    list-applications
    list-commands
    list-connector-connection-pools
    list-connector-resources
    list-connector-security-maps
    list-http-listeners
    list-javamail-resources
    list-jdbc-connection-pools
    list-jdbc-resources
    list-jms-resources
    list-jmsdest
    list-jndi-entries
    list-threadpools
    list-virtual-servers
    "
} &&
_asadmin_misc_commands()
{
		echo "verify-domain-xml generate-jvm-report flush-connection-pool flush-jmsdest"
} &&
_asadmin_commands()
{
		# just a subset of all commands (asadmin list-commands shows all)
    echo "start-domain stop-domain deploy undeploy `_asadmin_list_commands` `_asadmin_misc_commands`"
} &&
_asadmin_start_domain_options()
{
    echo "--debug=true"
} &&
_asadmin_undeploy_commands()
{
    asadmin list-applications | sed -e 's/^\([^<]\+\) \+<.\+$/\1/g' -e '/^Command list-applications executed successfully./Q'
} &&
_asadmin_flush_connection_pool_commands()
{
		asadmin list-jdbc-connection-pools | grep -v '^Command .* executed successfully.'
} &&
_asadmin_flush_jmsdest_commands()
{
		asadmin list-jmsdest | grep -v '^Command .* executed successfully.'
} &&
_asadmin()
{
    local cur prev words cword
    _init_completion || return

    COMPREPLY=()

    if [ $COMP_CWORD -eq 1 ]; then
        COMPREPLY=( $( compgen -W "--help $(_asadmin_commands)" -- $cur ) )
    elif [ $COMP_CWORD -gt 1 ]; then
        case "$prev" in
            start-domain)
                COMPREPLY=( $( compgen -W "--help $(_asadmin_start_domain_options)" -- $cur ) )
                return 0
                ;;
            stop-domain)
                COMPREPLY=( $( compgen -W "--help" -- $cur ) )
								return 0
								;;
            undeploy)
                COMPREPLY=( $( compgen -W "--help $(_asadmin_undeploy_commands)" -- $cur ) )
                return 0
                ;;
            flush-connection-pool)
                COMPREPLY=( $( compgen -W "--help $(_asadmin_flush_connection_pool_commands)" -- $cur ) )
                return 0
                ;;
						flush-jmsdest)
						    COMPREPLY=( $( compgen -W "--help --desttype=queue" -- $cur ) )
								return 0
								;;
            --desttype=queue)
                COMPREPLY=( $( compgen -W "$(_asadmin_flush_jmsdest_commands)" -- $cur ) )
                return 0
                ;;
            deploy)
                COMPREPLY=( $( compgen -W "--help --force" -- $cur ) )
						    _filedir '@(ear|war|jar)'
                return 0
                ;;
            --force)
						    _filedir '@(ear|war|jar)'
                return 0
                ;;
            list-threadpools)
                COMPREPLY=( $( compgen -W "--help server" -- $cur ) )
								return 0
								;;
        esac
    fi
} && complete -F _asadmin asadmin
