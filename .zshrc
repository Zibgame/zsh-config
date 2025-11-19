#############################################
# PATH
#############################################

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/node/bin:$PATH"
export PATH="$HOME/.local/node/node-v22/bin:$PATH"
export PATH="$HOME/.local/kitty.app/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"

#############################################
# OH-MY-ZSH
#############################################

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)

source $ZSH/oh-my-zsh.sh

#############################################
# OPTIONS & BEHAVIOR
#############################################

bindkey -v
stty -ixon
autoload -Uz colors && colors

PROMPT='%F{blue}💤%f %F{white}%~ %F{blue}→%f '
export MAIL="zcadinot@student.42lehavre.fr"

#############################################
# ALIASES : Git
#############################################

alias gup='
  echo -e "\033[1;34m🚀 Mise à jour Git…\033[0m";
  git add .;
  if git diff --cached --quiet; then
    echo -e "\033[1;33m⚠️  Aucun changement.\033[0m";
  else
    echo -ne "\033[1;33m📝 Message de commit : \033[0m";
    read msg;
    git commit -m "${msg:-42}";
  fi
  echo -e "\033[1;35m⬆️  Push forcé…\033[0m";
  git push -f;
  echo -e "\033[1;32m✅ Terminé.\033[0m"
'

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

#############################################
# FIN
#############################################
