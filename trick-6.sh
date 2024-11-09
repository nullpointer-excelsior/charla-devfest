#!/bin/zsh

#Colours
declare -r greenColour="\e[0;32m\033[1m"
declare -r endColour="\033[0m\e[0m"
declare -r redColour="\e[0;31m\033[1m"
declare -r yellowColour="\e[0;33m"
declare -r purpleColour="\e[0;35m\033[1m"
declare -r turquoiseColour="\e[0;36m\033[1m"
declare -r grayColour="\e[0;37m\033[1m"


# Ctrl + C
trap ctrl_c INT
function ctrl_c(){
    tput cnorm
    echo -e "\n\n${redColour}[!] Exiting...${endColour}\n\n"
    exit 1
}

if [ -z "$1" ]
then
  echo "\n\n${redColour}[x]${endColour} You must specify a file!\n\n"
  exit 1
fi

oldfile="$1"
dir="$(dirname $oldfile)"

echo -e "${yellowColour}[*]${endColour} Enter a new filename ${greenColour}>${endColour}"
read filename;
newfile="$dir/$filename"
clear

echo -e "${yellowColour}[*]${endColour} Renaming file: ${redColour} $oldfile ${endColour} to ${greenColour} $newfile ${endColour}"
mv $oldfile $newfile
