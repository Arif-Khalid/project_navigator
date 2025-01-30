#!/bin/bash
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
RESET=$(tput sgr0)
DIR_NAME=$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJECTS_FILE_NAME="projects.txt"
SETUP_FILE_NAME="setup.sh"

# Remember to call this script with . or source in order to change directory in the calling terminal
# For example: source pn.sh or . pn.sh
# 
# Optionally add the following line to your shell config
# alias pn=". $HOME/path/to/your/folder/containing/this_file/pn.sh"
# Then you can start project navigation with the shorter command: pn
#
# Shell config files dependent on shell used, for bash in linux, they can be found or created at 
# "/etc/profile", "~/bash_profile", "~/.bash_login" or "~/.profile"

if [[ ! -f "${DIR_NAME}/${PROJECTS_FILE_NAME}" ]]; then
    echo "${RED}No projects file present"
    echo "Please add a projects file at ${DIR_NAME}/${PROJECTS_FILE_NAME}${RESET}"
    return
fi

IFS='='
projectNames=()
projectPaths=()
while read -a project; do
    if [ ! ${#project[@]} -eq 2 ]; then
        echo "${RED}Field starting with ${CYAN}${project}${RED} in ${BLUE}${DIR_NAME}/${PROJECTS_FILE_NAME}${RED} not written properly"
        echo "Please write your projects in the form YOUR_PROJECT_NAME=YOUR_PROJECT_ROOT_DIRECTORY${RESET}"
        return
    fi
    projectNames+=("${project[0]}")
    projectPaths+=("${project[1]}")
    if [[ "${project[1]}" == *"~"* ]]; then
        echo "${RED}There is a ~ present in the path of ${CYAN}${project[0]}:${project[1]}${RED}"
        echo "Please use the full path for the tool to function properly${RESET}"
        echo "You can find the full path by doing ${YELLOW}readlink -f .${RESET} from your project root"
        echo ""
    elif [[ "${project[1]}" != /* ]]; then
        echo "${RED}The path of ${CYAN}${project[0]}:${project[1]}${RED} does not start with /"
        echo "Please use the full path including the / for the tool to function properly${RESET}"
        echo "For example, ${CYAN}/home/user/Desktop${RESET}"
        echo ""
    fi

done < "${DIR_NAME}/${PROJECTS_FILE_NAME}"
names_length=${#projectNames[@]}
numberRegex='^[0-9]+$'

echo "Hello and welcome to your ${MAGENTA}Project Navigator${RESET}!"
echo "${GREEN}Which project would you like to navigate to?${RESET}"
option_valid=false

while [[ "$option_valid" = false ]]; do
    option_valid=true
    for i in ${!projectNames[@]}; do
      echo "[$i]: ${CYAN}${projectNames[$i]}${RESET}"
    done
    echo "${RED}Q to quit${RESET}"

    read -p "Option index: " option
    if [[ $option == "q" ]] || [[ $option == "Q" ]]; then
        return 
    elif ! [[ $option =~ $numberRegex ]] || [ $option -ge $names_length ] || [ $option -lt 0 ]; then
        echo "${RED}Your chosen option is invalid, please select again${RESET}"
        option_valid=false
    fi

done
if [[ ! -d "${projectPaths[$option]}" ]]; then
    echo "${RED}The directory for ${CYAN}${projectNames[$option]}: ${BLUE}${projectPaths[$option]}${RED} does not exist"
    echo "Please edit ${BLUE}${DIR_NAME}/${PROJECTS_FILE_NAME}${RED} to point to a valid directory${RESET}"
    return
fi 
cd ${projectPaths[$option]}
echo "${GREEN}You are now in the directory for ${CYAN}${projectNames[$option]}${RESET}"
if [[ -f "./${SETUP_FILE_NAME}" ]]; then
    echo "${GREEN}I see you are a true ${MAGENTA}CHAD${GREEN} as there is a ${BLUE}${SETUP_FILE_NAME}${GREEN} in this directory"
    echo "Would you like to run it?${RESET}"
    read -p "[Y/N]" option
    if [[ $option == "y" ]] || [[ $option == "Y" ]]; then
        source ./setup.sh
    else
        echo "${GREEN}Run ${CYAN}source ./setup.sh${GREEN} to begin${RESET}"    
    fi
else
    echo "${YELLOW}You may include a ${BLUE}${SETUP_FILE_NAME}${YELLOW} within this directory to set up your development environment"
fi
