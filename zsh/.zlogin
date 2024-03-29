#!/usr/bin/env zsh

# Execute code in the background to not affect the current session
{
    # Compile zcompdump, if modified, to increase startup speed.
    zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
    if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
        zcompile "$zcompdump"
    fi
} &!

# Don't use fortune_say inside emacs
if [[ -z "$INSIDE_EMACS" ]]; then
    if command -v fortune_say 1>/dev/null 2>&1; then
        fortune_say
    fi
else
    # This will show at emacs with term-mode, ignore vterm
    if [[ ! $INSIDE_EMACS =~ "vterm" ]]; then
        echo "Note: <C-c C-j> to line mode, <C-c C-k> to char mode"
    fi
fi
