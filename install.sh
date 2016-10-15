which emacsenv

if [ ! $? -eq 0 ]; then
    exit 1
fi

eval $(emacsenv env)

cp $(cd $(dirname $0); pwd)/plugins/plugin.sh $EMACSENV_HOME/plugins
