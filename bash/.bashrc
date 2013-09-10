# export PATH=/usr/local/sbin:/usr/local/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/libexec

# homebrew's python
export PATH=/usr/local/share/python:$PATH

export CLICOLOR=1
export LSCOLORS=gxfxaxdxcxegedabagacad

#export PS1='\$'
#export PS1='\e[36m\w\e[0m \e[32m\e[0m\e[33m\$\e[0m \e[37m\e[0m'
#export PS1='\e[36m\w\e[0m \e[33m\$\e[0m '
export PS1='\W @\h > '

# Make bash check its window size after a process completes
shopt -s checkwinsize
