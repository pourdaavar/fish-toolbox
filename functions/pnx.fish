function pnx --description "Execute shell command in selected workspaces"
    set -l selected_raw (_pnpm_get_projects | fzf --multi --height 40% --header "Run shell command in:")
    test -z "$selected_raw"; and return 0

    for line in $selected_raw
        set -l pkg (string trim (string replace "★ " "" $line))
        set_color blue; echo "❯ Executing in $pkg"; set_color normal
        pnpm -F "$pkg" exec -- $argv
    end
end
