#!/bin/bash
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
CYAN=$(tput setaf 6)
RESET=$(tput sgr0)
DIR_NAME=$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJECTS_FILE_NAME="projects.txt"
SHELL_FILE_NAME="pn.sh"

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
IFS='='
projectNames=()
projectPaths=()
while read -a project; do
    echo ${project[0]}
    echo ${project[1]}
    if [ ! ${#project[@]} -eq 2 ]; then
        echo "${RED}Field starting with ${CYAN}${project}${RED} in ${BLUE}${DIR_NAME}/${PROJECTS_FILE_NAME}${RED} not written properly${RESET}"
        return
    fi
    projectNames+=("${project[0]}")
    projectPaths+=("${project[1]}")

done < "${DIR_NAME}/${PROJECTS_FILE_NAME}"

#projectNames=("Neovim Config" "Project 1" "Project 2") # Project names to identify your projects
#projectPaths=("$HOME/.config/nvim" "$HOME/Desktop/Project_1" "$HOME/Desktop/Project_2") # The paths of the respective project in the same order

names_length=${#projectNames[@]}
paths_length=${#projectPaths[@]}
if [ ! $names_length -eq $paths_length ]; then
    echo "${RED}The project names and paths have different lengths"
    echo "Please edit ${BLUE}${DIR_NAME}/${SHELL_FILE_NAME}${RED} to include the same number of items in each array${RESET}"
    return
fi
numberRegex='^[0-9]+$'

echo "Hello and welcome to your repo navigator!"
echo "Which project would you like to navigate to?"
option_valid=false

while [[ "$option_valid" = false ]]; do
    option_valid=true
    for i in ${!projectNames[@]}; do
      echo "[$i]: ${projectNames[$i]}"
    done

    read -p "Option index: " option

    if ! [[ $option =~ $numberRegex ]] || [ $option -ge $names_length ] || [ $option -lt 0 ]; then
        echo "${RED}Your chosen option is invalid, please select again${RESET}"
        option_valid=false
    fi

done
if [[ ! -d "${projectPaths[$option]}" ]]; then
    echo "${RED}The directory for ${CYAN}${projectNames[$option]}: ${BLUE}${projectPaths[$option]}${RED} does not exist"
    echo "Please edit ${BLUE}${DIR_NAME}/${SHELL_FILE_NAME}${RED} to point to a valid directory${RESET}"
    return
fi 
cd ${projectPaths[$option]}
echo "${GREEN}You are now in the directory for ${CYAN}${projectNames[$option]}${GREEN}"
echo "Use ${YELLOW}nvim${GREEN} to get started${RESET}"
