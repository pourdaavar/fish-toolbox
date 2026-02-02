function _pnpm_get_projects
    if not test -f pnpm-workspace.yaml
        return 1
    end
    set -l current_pkg (test -f package.json; and jq -r '.name // empty' package.json; or echo "")
    pnpm ls -r --depth -1 --json | jq -r '.[] | .name' | sort -u | while read -l pkg
        if test "$pkg" = "$current_pkg"
            echo "★ $pkg"
        else
            echo "  $pkg"
        end
    end
end
