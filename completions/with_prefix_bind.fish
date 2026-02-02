# Completion for with_prefix_bind
# This makes the function self-documenting and discoverable

# Complete function name
complete -c with_prefix_bind \
    -d "Bind a key sequence to with_prefix"

# First argument: key sequence
complete -c with_prefix_bind \
    -n "test (count (commandline -opc)) -eq 1" \
    -d "Fish key sequence (use fish_key_reader)"

# Second argument: common prefixes
complete -c with_prefix_bind \
    -n "test (count (commandline -opc)) -eq 2" \
    -a "sudo 'proxychains -q' 'env VAR=1'" \
    -d "Prefix passed to with_prefix"
