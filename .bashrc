source ~/.git-prompt.sh
source ~/.git-completion.bash

# Aliases

# ls:
# -G renders the output in colour
# -F adds a / after each directory name, a @ after symlinks, a | after pipes, a * after executables
alias ls='ls -GF'
alias ll='ls -l'                              # long list
alias la='ls -A'                              # all but . and ..
# Colour the output of ls
# Order:
#         1.   directory
#         2.   symbolic link
#         3.   socket
#         4.   pipe
#         5.   executable
#         6.   block special
#         7.   character special
#         8.   executable with setuid bit set
#         9.   executable with setgid bit set
#         10.  directory writable to others, with sticky bit
#         11.  directory writable to others, without sticky bit
#
# The color designators are as follows:
#
#         a     black
#         b     red
#         c     green
#         d     brown
#         e     blue
#         f     magenta
#         g     cyan
#         h     light grey
#         A     bold black, usually shows up as dark grey
#         B     bold red
#         C     bold green
#         D     bold brown, usually shows up as yellow
#         E     bold blue
#         F     bold magenta
#         G     bold cyan
#         H     bold light grey; looks like bright white
#         x     default foreground or background
export LSCOLORS='cxfxexdxbxegedabagacad'

# Open vim in split mode
alias vi='vim -O'

# Colourize grep
alias grep='grep --color'

# Use grep recursively and show line numbers
# alias gr='grep -rn '
function dj_grep () {
    grep -rn . --exclude-dir=venv --exclude=*.pyc --exclude=tags --exclude=*.sw* -e "$@"
}
alias gr=dj_grep


# GIT:
# git checkout using fuzzy branch finder
gco() {
  local branches branch
  branches=$(git for-each-ref --count=45 --sort=-committerdate refs/heads/ --format='%(refname:short)') &&
  # ^This line brings up a list of branches sorted by the ones most recently worked on
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | sed "s/.* //")
}

# git commit browser with fuzzy search
gls() {
  local out sha q
  while out=$(
      git log --decorate=short --graph --oneline --color=always |
      fzf --ansi --multi --no-sort --reverse --query="$q" --print-query); do
    q=$(head -1 <<< "$out")
    while read sha; do
      [ -n "$sha" ] && git show --color=always $sha | less -R
    done < <(sed '1d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
  done
}

# A bunch of useful git aliases
alias ga='git add'
alias gs='git status'
alias gd='git diff --word-diff=color'
alias gc='git commit'
alias gl="git log --graph --pretty=format:'%Cred%h%Creset < %Cgreen%p%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit" # Git log basic
alias gle="git log --graph --pretty=format:'%Cred%h%Creset < %Cgreen%p%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --numstat --summary" # Git log extended
alias gcm='git commit -m'
alias gdc='git diff --cached --word-diff=color'
alias gfa='git fetch --all'
alias gpr='git pull-request --browse -b instamojo/imojo:develop'
alias gsb="git for-each-ref --count=45 --sort=-committerdate refs/heads/ --format='%(committerdate:short): %(refname:short) (%(committeremail))'" # Show the last few branches worked on
alias ghead='git symbolic-ref --short head'
alias gmoh='git merge origin/$(ghead)' # Merge the remote branch at origin into the local branch
alias gmuh='git merge upstream/$(ghead)' # Merge the remote branch at upstream into the local branch
alias gref='git for-each-ref --sort=-committerdate refs/remotes/upstream/' # Show upstream refs sorted by committer date
alias gbr='git browse'

# Print the path
alias path='echo -e ${PATH//:/\\n}'

# Virtualenv
alias mkvenv='virtualenv --no-site-packages --distribute venv'
alias act='source venv/bin/activate'

# Show VirtualEnv in prompt:
# Get Virtual Env
if [[ $VIRTUAL_ENV != "" ]]
    then
      # Strip out the path and just leave the env name
      venv="(${VIRTUAL_ENV##*/}) "
else
      # In case you don't have one activated
      venv=''
fi

## Jazz up Git:

# Visit http://ithaca.arpinum.org/2013/01/02/git-prompt.html for details
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_DESCRIBE_STYLE="branch"
GIT_PS1_SHOWUPSTREAM="auto git"

# Colour Prompt
export PS1='\[\033[01;34m\][\D{%Y-%m-%d} \T]\]\[\033[0m\] \[\033[33m\]${venv}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[32m\]$(__git_ps1)\[\033[00m\] \n\$ '

# export PATH=/usr/local/bin:$PATH
# export PATH=/usr/local/share/python:$PATH
# export PATH="/usr/local/share/npm/bin:$PATH"

# We only customize our path if our path hasn't been previously customized.
# This allows us to deal with issues where a program that requires the path set
# in a specific way for the program to run can run without having its path
# clobbered (like venv)
if [[ -z "$PATH_SET" ]]
then
    export PATH="/Users/sengupta/Dropbox/src/work/aws/eb/macosx/python2.7:/usr/local/heroku/bin:/Applications/Postgres.app/Contents/Versions/latest/bin:/usr/local/bin:/usr/local/sbin:/usr/local/heroku/bin:/usr/local/php5/bin:/usr/local/Cellar/node/0.12.2_1/libexec/npm/bin:${PATH}"
    export PATH_SET="True"
fi

export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL=""

export ARCHFLAGS="-arch x86_64"

source ~/.aws_ssh

# Using hub (https://github.com/github/hub/)
alias git=hub
alias fr='foreman run'

# Fuzzy finder
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# CTRL-T - Paste the selected file path(s) into the command line
# CTRL-R - Paste the selected command from history into the command line

# Exuberant Ctags
alias ct="ctags -R --exclude=.git --exclude=design/build --exclude=design/node_modules"

# Because Macs don't have SSH autocomplete:
_complete_ssh_hosts ()
{
        COMPREPLY=()
        cur="${COMP_WORDS[COMP_CWORD]}"
        comp_ssh_hosts=`cat ~/.ssh/known_hosts | \
                        cut -f 1 -d ' ' | \
                        sed -e s/,.*//g | \
                        grep -v ^# | \
                        uniq | \
                        grep -v "\[" ;
                cat ~/.ssh/config | \
                        grep "^Host " | \
                        awk '{print $2}'
                `
        COMPREPLY=( $(compgen -W "${comp_ssh_hosts}" -- $cur))
        return 0
}
complete -F _complete_ssh_hosts ssh

alias check="pylint --load-plugins pylint_django --reports=no"
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
source /usr/local/bin/virtualenvwrapper.sh
