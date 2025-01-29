#!/bin/bash

# Remember to call this script with . or source in order to change directory in the calling terminal
# For example: source pn.sh
# 
# Optionally add the following line to your shell config
# alias pn="$HOME/path/to/your/folder/containing/this_file"
# Then you can start project navigation with the shorter command: pn
#
# Shell config files dependent on shell used, for bash in linux, they can be found or created at 
# "/etc/profile", "~/bash_profile", "~/.bash_login" or "~/.profile"

# Variables to edit
projectNames=("Neovim Config" "Project 1" "Project 2") # Project names to identify your projects
projectPaths=("$HOME/.config/nvim" "$HOME/Desktop/Project_1" "$HOME/Desktop/Project_2") # The paths of the respective project in the same order

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)
numberRegex='^[0-9]+$'

echo "Hello and welcome to your repo navigator!"
echo "Which project would you like to navigate to?"


array_length=${#projectNames[@]}

option_valid=false

while [[ "$option_valid" = false ]]; do
    option_valid=true
    for i in ${!projectNames[@]}; do
      echo "[$i]: ${projectNames[$i]}"
    done

    read -p "Option index: " option

    if ! [[ $option =~ $numberRegex ]] || [ $option -ge $array_length ] || [ $option -lt 0 ]; then
        echo "${RED}Your chosen option is invalid, please select again${RESET}"
        option_valid=false
    fi

done

cd ${projectPaths[$option]}
echo "${GREEN}You are now in the directory for ${projectNames[$option]}"
echo "Use ${YELLOW}nvim${GREEN} to get started${RESET}"

