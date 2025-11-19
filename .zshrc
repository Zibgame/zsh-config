############################################################
# 🔵 1. PATH & VARIABLES
############################################################
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/node/bin:$PATH"
export PATH="$HOME/.local/node/node-v22/bin:$PATH"
export PATH="$HOME/.local/kitty.app/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export LANG="en_US.UTF-8"
export MAIL="zcadinot@student.42lehavre.fr"


############################################################
# 🔵 2. OH-MY-ZSH
############################################################
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)

source $ZSH/oh-my-zsh.sh
unalias gup 2>/dev/null
unalias glog 2>/dev/null


############################################################
# 🔵 3. OPTIONS & SHELL FEEL
############################################################
bindkey -v
stty -ixon
autoload -Uz colors && colors

PROMPT='%F{blue}💤%f %F{white}%~ %F{blue}→%f '


############################################################
# 🟢 4. FUNCTION : gup (smart Git helper)
############################################################
gup() {
  local pause=0.4 step=1 msg suggested

  clear
  echo "──────────────────────────────────────────────────────────"
  echo "  🚀  gup — Smart add → commit → push"
  echo "──────────────────────────────────────────────────────────"
  echo

  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "❌  Pas un repo git."
    return 1
  fi

  local last_change
  last_change=$(git status --short | head -n 1)

  if [ -z "$last_change" ]; then
    suggested="Update project"
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

  read "msg?💬 Commit (ENTER = suggestion « $suggested ») : "
  [ -z "$msg" ] && msg="$suggested"

  step_echo() {
    printf "\n\033[1;34mÉtape %d\033[0m — %s\n" "$step" "$1"
    step=$((step + 1))
  }

  step_echo "git add ."
  git add .

  step_echo "git commit"
  git commit -m "$msg"

  step_echo "git push"
  git push

  echo "\n✅ Terminé."
}



############################################################
# 🟢 5. FONCTIONS ULTRA UTILES 42
############################################################

# Norminette propre
norm() {
  echo "📏 Norminette…"
  norminette | sed 's/Error/❌ Error/g; s/Warning/⚠️ Warning/g'
}

# Compile + run simple
runc() {
  if [ -z "$1" ]; then echo "Usage : runc file.c"; return; fi
  cc -Wall -Wextra -Werror "$1" -o a.out && ./a.out
}

# Compile avec analyse warnings
cwarn() {
  if [ -z "$1" ]; then echo "Usage : cwarn file.c"; return; fi
  cc -Wall -Wextra -Werror -fsanitize=address -g "$1" -o a.out && ./a.out
}

# Git log stylé
glog() {
  git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(green)%an%C(reset) %C(yellow)%d%C(reset)%n%C(white)%s%C(reset)' --all
}

# Nettoyage branches mergées
gitclean() {
  git branch --merged | grep -v main | grep -v master | xargs -r git branch -d
}

# Mini structure projet C
proj() {
  mkdir -p "$1"/src "$1"/include "$1"/build
  echo "int main() { return 0; }" > "$1/src/main.c"
  echo "Projet créé : $1/"
}

# Petite fiche fonction C
cheat() {
  echo "📚 Cheatsheet C :"
  echo "strlen / strcpy / strcmp / malloc / free / atoi / itoa / write / open / close"
}


############################################################
# 🟠 6. ALIASES
############################################################
alias fcc='cc -Wall -Werror -Wextra '
alias ll='ls -la'
alias cl='clear'
alias nbl='find . -type f \( -name "*.c" -o -name "*.h" -o -name "Makefile" \) -exec wc -l {} +'
alias nvim="$HOME/.local/nvim-portable/bin/nvim"

# Apps
alias hyprstart='Hyprland'
alias google='nohup google-chrome-stable >/dev/null 2>&1 & disown && clear'
alias file='nohup nautilus >/dev/null 2>&1 & disown && clear'
alias deezer='nohup "$HOME/Documents/deezer-linux-x64/DeezerÉcoutedelamusiqueenligneAppdemusique" >/dev/null 2>&1 & disown && clear'
alias cdeezer='pkill -f Deezer'
alias discord='nohup discord >/dev/null 2>&1 &'
alias steam='nohup steam >/dev/null 2>&1 &'

# Perso dev
alias francinette="$HOME/francinette/tester.sh"
alias paco="$HOME/francinette/tester.sh"
alias delock='python3 $HOME/script/delock.py'
alias play='make clean && make re && gup && clear && ./so_long assets/maps/subject_map2.ber'
alias fetch='fastfetch -l $HOME/Downloads/archlinux.png'
alias vibez='bash $HOME/.script/vibez.sh && clear'
alias anime='clear && ani-cli && clear'
alias matrix='clear && cmatrix -C blue'
alias acc='hyprctl dispatch exit'
alias off='sudo poweroff'
alias gnome='killall Hyprland gnome-shell Xorg 2>/dev/null; sleep 1; sudo true; sudo Xorg :0 -nolisten tcp & sleep 2 && DISPLAY=:0 dbus-run-session gnome-session --session=gnome-xorg >/dev/null 2>&1 & disown'

############################################################
# END
############################################################
