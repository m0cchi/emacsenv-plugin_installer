plugin_file="plugins/plugin.sh"

if [ ! -e "$EMACSENV_PLUGINS_DIR/plugin.sh" ]; then
  # automapping
  ln -s "$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/$plugin_file" $EMACSENV_PLUGINS_DIR/plugin.sh > /dev/null
fi

echo $plugin_file
