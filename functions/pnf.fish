function pnf --description "pnpm filter with interactive fzf selection"
    set -f projects (_pnpm_get_projects)
    test $status -ne 0; and return 1

    # Local styles just for this command
    set -lx FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS \
        --color=fg:#d0d0d0,fg+:#d0d0d0,bg:#121212,bg+:#262626 \
        --color=hl:#5f87af,hl+:#5fd7ff,info:#afaf87,marker:#87ff00 \
        --color=prompt:#d7005f,spinner:#af5fff,pointer:#af5fff,header:#87afaf \
        --color=border:#262626,label:#aeaeae,query:#d9d9d9 \
        --border=\"double\" --border-label=\"\" --preview-window=\"down:10%:border-double\" --bind=\"?:toggle-preview\"  --padding=\"1\" \
        --margin=\"1\" --prompt=\"WORKSPACE \" --marker=\"\" --pointer=\"◆\" \
        --separator=\"-\" --scrollbar=\"\""

    set -x CMD_ARGS "$argv"

    set -l selected_raw (printf "%s\n" $projects | fzf --multi --height 30% \
        --header "Tab: Select Multiple | Enter: Confirm" \
        --preview-label " Final Executed Command " \
        --preview "
            set -l pkgs (echo {+1..} | sed 's/★ //g' | sed 's/  //g')
            set -l filters ''
            for pkg in (string split ' ' \$pkgs)
                if test -n \"\$pkg\"
                    set filters \"\$filters -F \$pkg\"
                end
            end
            echo -e '\033[1;35m> pnpm'\$filters \$CMD_ARGS'\033[0m'
        ")

    set -e CMD_ARGS

    if test -z "$selected_raw"
        return 0
    end

    set -l filters
    for line in $selected_raw
        set -l clean_name (string trim (string replace "★ " "" $line))
        set filters $filters -F "$clean_name"
    end

    set_color magenta; echo " pnpm $filters $argv"; set_color normal
    command pnpm $filters $argv
end
