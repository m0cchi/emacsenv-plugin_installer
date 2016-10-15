function invoke_selector() {
    if [ -e "$1" ]; then
        # target script
        echo ". '$1'"
        return 0
    else
        # missing
        echo "$2"
        return 1
    fi
}

function install_plugin_with_github() {
    local URL='https://github.com/'$COMMAND'.git'
    if [ ! -d "$github_dir" ]; then
        mkdir "$github_dir" &> /dev/null
    fi
    git clone "$URL" $github_dir/$COMMAND &> /dev/null
}

github_dir="$EMACSENV_PLUGINS_DIR/repo"
plugin_github="$github_dir/$COMMAND/spec.sh"
plugin="$EMACSENV_PLUGINS_DIR/$COMMAND.sh"

exec=$(invoke_selector "$plugin" 'nop')

if [ $? -eq 0 ]; then
    eval "$exec"
else
    exec=$(invoke_selector "$plugin_github" "install_plugin_with_github $COMMAND")
    ret_code=$?
    plugin_file=$(eval "$exec")

    if [ $ret_code -eq 1 ]; then
        exec=$(invoke_selector "$plugin_github" 'exit 1')
        plugin_file=$(eval "$exec")
        if [ $? -eq 1 ]; then
            exit 1
        fi
    fi
    . "$(dirname $plugin_github)/$plugin_file"
fi
