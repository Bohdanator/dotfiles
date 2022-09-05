# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

## Options section
setopt correct            # Auto correct mistakes
setopt extendedglob       # Extended globbing. Allows using regexes with *
setopt nocaseglob         # Case insensitive globbing
setopt rcexpandparam      # Array expension with parameters
setopt nocheckjobs        # Don't warn about running processes when exiting
setopt numericglobsort    # Sort filenames numerically when it makes sense
setopt nobeep             # No beep
setopt appendhistory      # Immediately append history instead of overwriting
setopt histignorealldups  # If a new command is a duplicate, remove the older one
setopt autocd             # if only directory path is entered, cd there.

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"    # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                         # automatically find new executables in path
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

WORDCHARS=${WORDCHARS//\/[&.;]}                            # Don't consider certain characters part of the word

HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000

## Keybindings section
bindkey -e
bindkey '^[[7~' beginning-of-line                          # Home key
bindkey '^[[H' beginning-of-line                           # Home key
if [[ "${terminfo[khome]}" != "" ]]; then
    bindkey "${terminfo[khome]}" beginning-of-line         # [Home] - Go to beginning of line
fi
bindkey '^[[8~' end-of-line                                # End key
bindkey '^[[F' end-of-line                                 # End key
if [[ "${terminfo[kend]}" != "" ]]; then
    bindkey "${terminfo[kend]}" end-of-line                # [End] - Go to end of line
fi
bindkey '^[[2~' overwrite-mode                             # Insert key
bindkey '^[[3~' delete-char                                # Delete key
bindkey '^[[C'  forward-char                               # Right key
bindkey '^[[D'  backward-char                              # Left key
bindkey '^[[5~' history-beginning-search-backward          # Page up key
bindkey '^[[6~' history-beginning-search-forward           # Page down key

# Navigate words with ctrl+arrow keys
bindkey '^[Oc' forward-word                                #
bindkey '^[Od' backward-word                               #
bindkey '^[[1;5D' backward-word                            #
bindkey '^[[1;5C' forward-word                             #
bindkey '^H' backward-kill-word                            # delete previous word with ctrl+backspace
bindkey '^[[Z' undo                                        # Shift+tab undo last action

# Theming section
autoload -U compinit colors zcalc
compinit -d
colors


# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r

## Plugins section: Enable fish style features
# Use syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Use history substring search
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
# bind UP and DOWN arrow keys to history substring search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Apply different settigns for different terminals
case $(basename "$(cat "/proc/$PPID/comm")") in
  login)
        RPROMPT="%{$fg[red]%} %(?..[%?])"
        alias x='startx ~/.xinitrc'      # Type name of desired desktop after x, xinitrc is configured for it
    ;;
    # 'tmux: server')
    #       RPROMPT='$(git_prompt_string)'
    #       ## Base16 Shell color themes.
    #       #possible themes: 3024, apathy, ashes, atelierdune, atelierforest, atelierhearth,
    #       #atelierseaside, bespin, brewer, chalk, codeschool, colors, default, eighties,
    #       #embers, flat, google, grayscale, greenscreen, harmonic16, isotope, londontube,
    #       #marrakesh, mocha, monokai, ocean, paraiso, pop (dark only), railscasts, shapesifter,
    #       #solarized, summerfruit, tomorrow, twilight
    #       #theme="eighties"
    #       #Possible variants: dark and light
    #       #shade="dark"
    #       #BASE16_SHELL="/usr/share/zsh/scripts/base16-shell/base16-$theme.$shade.sh"
    #       #[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
    #       # Use autosuggestion
    #       source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    #       ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
    #       ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
    #    ;;
  *)
        RPROMPT='$(git_prompt_string)'
        # Use autosuggestion
        source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
        ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
    ;;
esac

################################################################################

. /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[[ -r ~/.scripts/source.sh ]] && . ~/.scripts/source.sh

eval "$(pyenv init -)"

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 72h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

# from ubuntu .zshrc

# . "$HOME/.cargo/env"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# if [ -e /home/david/.nix-profile/etc/profile.d/nix.sh ]; then . /home/david/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
