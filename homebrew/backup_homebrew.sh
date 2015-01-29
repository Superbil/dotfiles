#!/usr/bin/env sh

brew tap | while read tap; do echo "tap $tap"; done

echo ""

brew list | while read item;
do
    echo "install $item $(brew info $item | grep 'Built from source with:' | sed 's/^[ \t]*Built from source with:/ /g; s/\,/ /g')"
done
