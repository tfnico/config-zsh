# Load pure:
autoload -U promptinit && promptinit
prompt pure

# Fix rbenv $SHELL stuff: https://github.com/sstephenson/rbenv/issues/185
SHELL=/bin/zsh

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

#compdef not found?
#source ~/prefs/git-completion.bash

# Some extra features:
#
source ~/.zsh/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-history-substring-search.zsh

# bind UP and DOWN arrow keys, could be Ubuntu specific
# This works fine, also on osx, but not under tmux..
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Share history between sessions
setopt SHARE_HISTORY

# Customize to your needs...
unsetopt correct_all
if [ -f "$HOME/prefs/env" ]; then
  source $HOME/prefs/env
fi

# Add RVM stuff (ruby environment manager)
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Zsh tab completion for cd ..
zstyle ':completion:*' special-dirs true

# Source the shell switcher at work
#if [ -f "$HOME/.shell.sh" ]; then
#  source ~/.shell.sh
#fi

# OS specific stuff

platform='unknown'
unamestr=$(uname)
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='osx'
   #load boxen/homebrew
   source /opt/boxen/env.sh
   PATH="/opt/boxen/homebrew/opt/gnu-tar/libexec/gnubin:$PATH"

# Fix broken pasteboard support in tmux under OSX
#  if type reattach-to-user-namespace >/dev/null 2>&1; then
#    exec reattach-to-user-namespace -l zsh
#  else
#    echo "System clipboard link is broken, but reattach-to-user-namespace not found." >&2
#    echo "Please install reattach-to-user-namespace." >&2
#    echo "https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard" >&2
#  fi
fi

if [[ $platform == 'linux' ]]; then
    #on osx we have open
    alias open=gnome-open
    #Can't remember what the following fix was for. tmux problems
    #on ubuntu I think.
    alias tig="TERM=screen /usr/local/bin/tig"
    alias open="gnome-open"
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
fi

