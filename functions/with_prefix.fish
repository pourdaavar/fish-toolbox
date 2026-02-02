function with_prefix -d "Prepend a prefix to specific commands or use an argument"

    # Optional argument: prefix to use
    set -l custom_prefix $argv[1]

    # Default mapping for commands
    # set -l prefix_map curl "proxychains -q"
    # Add more command → prefix mappings here
    # set -l prefix_map wget "proxychains -q"
    # set -l prefix_map node "env VAR=1"

    # Get current command line & cursor
    set -l cmd (commandline)
    set -l cursor (commandline -C)

    # Split command
    set -l first_word (string split ' ' -- $cmd)[1]

    # Determine prefix to use
    if test -n "$custom_prefix"
        set -l prefix $custom_prefix
    else
        # Check mapping
        set -l prefix ""
        for i in (seq 1 2 (count $prefix_map))
            if test "$first_word" = $prefix_map[$i]
                set prefix $prefix_map[(math $i+1)]
                break
            end
        end
    end

    # No prefix to apply? exit
    if test -z "$prefix"
        return
    end

    # Toggle prefix in command line
    if string match -q -- "$prefix*" -- $cmd
        set -l newcmd (string replace -r "^$prefix\s+" "" -- $cmd)
        commandline -r $newcmd
        set cursor (math $cursor - (string length $prefix) - 1)
    else
        commandline -r "$prefix $cmd"
        set cursor (math $cursor + (string length $prefix) + 1)
    end

    # Restore cursor
    commandline -C $cursor
end
