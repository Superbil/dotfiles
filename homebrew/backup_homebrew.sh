#!/usr/bin/env sh

brew tap | while read tap; do echo "tap $tap"; done

echo ""

brew list | while read item;
do
    echo "install $item $(brew info $item | /usr/bin/grep 'Built from source with:' | /usr/bin/sed 's/^[ \t]*Built from source with:/ /g; s/\,/ /g')"
done
