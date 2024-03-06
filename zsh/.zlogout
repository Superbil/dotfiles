#!/usr/bin/env zsh

# Remove history include TERM='dumb'
# https://stackoverflow.com/questions/7243983/how-to-remove-an-entry-from-the-history-in-zsh
export LC_ALL=C
if [[ "$(uname -s)" == "Darwin" && $(which sed) == "/usr/bin/sed" ]]; then
    sed -i '' "/TERM='dumb'/d" $HISTFILE
else
    sed -i "/TERM='dumb'/d" $HISTFILE
fi
