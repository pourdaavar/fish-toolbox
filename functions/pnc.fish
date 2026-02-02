function pnc --description "Recursive delete all node_modules"
    set_color red; echo "Removing all node_modules..."
    find . -name "node_modules" -type d -prune -exec rm -rf '{}' +
    set_color green; echo "Done."
end
