function __npm_package_json_deps --description 'Print npm package names from package.json dependencies'
    test -f package.json; or return
    type -q jq; or return

    jq -r '
        [
            .dependencies // {},
            .devDependencies // {},
            .peerDependencies // {},
            .optionalDependencies // {}
        ]
        | add // {}
        | to_entries[]
        | "\(.key)\t\(.value)"
    ' package.json 2>/dev/null
end

complete -c npm \
    -n '__fish_seen_subcommand_from list ls uninstall update explain why' \
    -f \
    -a '(__npm_package_json_deps)' \
    -d 'package.json dependency'
