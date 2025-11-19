#############################################
# PATH
#############################################

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/node/bin:$PATH"
export PATH="$HOME/.local/node/node-v22/bin:$PATH"
export PATH="$HOME/.local/kitty.app/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export LANG="en_US.UTF-8"

#############################################
# OH-MY-ZSH
#############################################

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Oh My Zsh charge parfois un alias gup → on supprime
unalias gup 2>/dev/null

#############################################
# OPTIONS & BEHAVIOR
#############################################

bindkey -v
stty -ixon
autoload -Uz colors && colors

PROMPT='%F{blue}💤%f %F{white}%~ %F{blue}→%f '
export MAIL="zcadinot@student.42lehavre.fr"

#############################################
# FUNCTION : gup (smart Git helper)
#############################################

gup() {
  local pause=0.5
  local step=1
  local msg suggested

  clear
  echo "──────────────────────────────────────────────────────────"
  echo "  🚀  gup — Commit & Push (smart commit message)"
  echo "──────────────────────────────────────────────────────────"
  echo

  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "❌  Tu n'es pas dans un dépôt git."
    return 1
  fi

  # Détection du changement principal
  local last_change
  last_change=$(git status --short | head -n 1)

  if [ -z "$last_change" ]; then
    suggested="Update: no changes?"
  else
    local code=$(echo "$last_change" | awk '{print $1}')
    local file=$(echo "$last_change" | awk '{print $2}')

    case "$code" in
      M) suggested="Update $file" ;;
      A) suggested="Create $file" ;;
      D) suggested="Delete $file" ;;
      R) suggested="Rename $file" ;;
      *) suggested="Update project" ;;
    esac
  fi

  echo "💡 Suggestion : $suggested"
  read "msg?💬 Message de commit (ENTER pour utiliser la suggestion) : "
  if [ -z "$msg" ]; then msg="$suggested"; fi

  step_echo() {
    printf "\n\033[1;34mÉtape %d\033[0m — %s\n" "$step" "$1"
    step=$((step + 1))
  }

  step_echo "git add ."
  git add . || return 1
  sleep $pause

  step_echo "git status"
  git status --short
  sleep $pause

  step_echo "git commit"
  git commit -m "$msg" || return 1
  sleep $pause

  step_echo "git push"
  git push || return 1
  sleep $pause

  echo
  echo "──────────────────────────────────────────────────────────"
  echo "  ✅  Terminé : add → commit → push"
  echo "──────────────────────────────────────────────────────────"
}

#############################################
# ALIASES : Git
#############################################

alias fcc='cc -Wall -Werror -Wextra '
alias ll='ls -la'

#############################################
# ALIASES : Programmes / Apps
#############################################

alias hyprstart='Hyprland'
alias google='nohup google-chrome-stable >/dev/null 2>&1 & disown && clear'
alias file='nohup nautilus >/dev/null 2>&1 & disown && clear'
alias deezer='nohup "$HOME/Documents/deezer-linux-x64/DeezerÉcoutedelamusiqueenligneAppdemusique" >/dev/null 2>&1 & disown && clear'
alias cdeezer='pkill -f Deezer'
alias discord='nohup discord >/dev/null 2>&1 &'
alias steam='nohup steam >/dev/null 2>&1 &'

#############################################
# ALIASES : Dev / Outils Persos
#############################################

alias francinette="$HOME/francinette/tester.sh"
alias paco="$HOME/francinette/tester.sh"
alias nbl='find . -type f \( -name "*.c" -o -name "*.h" -o -name "Makefile" \) -exec wc -l {} +'
alias nvim="$HOME/.local/nvim-portable/bin/nvim"
alias cl='clear'
alias delock='python3 $HOME/script/delock.py'
alias play='make clean && make re && gup && clear && ./so_long assets/maps/subject_map2.ber'
alias fetch='fastfetch -l $HOME/Downloads/archlinux.png'
alias vibez='bash $HOME/.script/vibez.sh && clear'
alias anime='clear && ani-cli && clear'
alias matrix='clear && cmatrix -C blue'
alias acc='hyprctl dispatch exit'
alias off='sudo poweroff'
alias gnome='killall Hyprland gnome-shell Xorg 2>/dev/null; sleep 1; sudo true; sudo Xorg :0 -nolisten tcp & sleep 2 && DISPLAY=:0 dbus-run-session gnome-session --session=gnome-xorg >/dev/null 2>&1 & disown'

#############################################
# FIN
#############################################
