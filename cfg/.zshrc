# This is essentially https://github.com/ghostbsd/ghostbsd-zsh-settings/

# Initialize completion system
autoload -Uz compinit && compinit

ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)

source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# Color ls output
export CLICOLOR=1
alias ls='ls --color=auto'

# Use fish-style command history
HISTFILE=~/.zsh_history      # Location of history file
HISTSIZE=10000               # Number of lines kept in memory
SAVEHIST=10000               # Number of lines saved to file

# Options for fish-like behavior
setopt hist_ignore_dups      # Don't record duplicate lines
setopt hist_reduce_blanks    # Remove unnecessary blanks
setopt inc_append_history    # Save each command as soon as it's run
setopt share_history         # Share history across all zsh sessions
setopt extended_history      # Add timestamps to history
setopt hist_find_no_dups     # Skip duplicate entries during search

# Fish-style up-arrow history search (per command line input)
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search     # Up arrow
bindkey "^[[B" down-line-or-beginning-search   # Down arrow

# Load color module
autoload -U colors && colors

# Enable prompt substitution
setopt PROMPT_SUBST

# Function to abbreviate path like Fish
function fish_like_path() {
  local dir_path=$PWD
  # Handle home directory and subdirectories
  if [[ $dir_path == $HOME ]]; then
    echo "~"
  elif [[ $dir_path == $HOME/* ]]; then
    local sub_path=${dir_path#$HOME/}
    local components=(${(s:/:)sub_path})
    local abbreviated=()
    # Abbreviate all but the last component
    for ((i=1; i<${#components}; i++)); do
      [[ -n $components[$i] ]] && abbreviated+=${components[$i][1]}
    done
    # Add the last component fully
    [[ -n $components[-1] ]] && abbreviated+=$components[-1]
    echo "~/${(j:/:)abbreviated}"
  else
    # Abbreviate non-home paths
    local components=(${(s:/:)dir_path})
    local abbreviated=()
    # Abbreviate all but the last component
    for ((i=1; i<${#components}; i++)); do
      [[ -n $components[$i] ]] && abbreviated+=${components[$i][1]}
    done
    # Add the last component fully
    [[ -n $components[-1] ]] && abbreviated+=$components[-1]
    echo "/${(j:/:)abbreviated}"
  fi
}

# Use Terminator's 3rd palette color (ANSI 2) for user and path, terminal foreground for host
local user_color='2'      # ANSI 2 (Terminator's 3rd color, green)
local host_color='fg'     # Terminal's default foreground
local path_color='2'      # ANSI 2 (Terminator's 3rd color, green)

# Git info function to show branch info in prompt, with fallback if Git is not installed
function git_info() {
  # Check if Git is installed
  if ! command -v git &>/dev/null; then
    return 1  # Return 1 if Git is not installed
  fi

  # Check if inside a Git repository
  if ! git rev-parse --is-inside-work-tree &>/dev/null; then
    return 1  # Return 1 if not inside a Git repository
  fi

  # Get the current Git branch or fallback to describe if in detached HEAD
  local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  if [[ -z "$branch" ]]; then
    branch=$(git describe --tags --always 2>/dev/null)
  fi

  # Return the Git info with the branch or fallback name
  echo "%F{$host_color}($branch)%f"
}

# Check for 256-color support
if [[ "$TERM" == *256color* ]]; then
  # Use ANSI 2 and terminal foreground with Fish-like path
  PROMPT="%F{$user_color}%n%f@%F{$host_color}%m%f %F{$path_color}\$(fish_like_path)\$(git_info)%f %# "
else
  # Fallback to ANSI 2 and terminal foreground with Fish-like path
  PROMPT="%F{$user_color}%n%f@%F{$host_color}%m%f %F{$path_color}\$(fish_like_path)\$(git_info)%f %# "
fi

