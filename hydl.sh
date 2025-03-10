#!/usr/bin/env bash

# Set necessary environment variables
scrDir="$(dirname "$(realpath "$0")")"
confDir="${XDG_CONFIG_HOME:-$HOME/.config}/hyde"
cacheDir="${XDG_CACHE_HOME:-$HOME/.cache}/hyde"

# Source HyDE's global control script if needed
#source "$scrDir/globalControl.sh"


# Define color codes using ANSI escape sequences
RED='\e[38;2;255;0;0m'      # Hex: #FF0000
GREEN='\e[38;2;0;255;0m'    # Hex: #00FF00
YELLOW='\e[38;2;255;255;0m' # Hex: #FFFF00
MAGENTA='\e[38;5;206m'     # Hex: #0000FF
CYAN='\e[38;2;0;255;255m'   # Hex: #00FFFF
NC='\e[0m'                  # No Color

while true; do
# To ask for the Link the user wants to download:
   echo -e "${CYAN}Enter(link or name to download) or ('exit' or 'q' to quit): ${NC}";
   read yt_link

# checks if its a valid link or not
   if [ -z "$yt_link" ]; then
    echo -e "${RED}Please enter a Valid YouTube link or search term.${NC}"
    continue
   fi

# checks if user want to exit
   if [ "$yt_link" == "exit" ] || [ "$yt_link" == "q" ] ;then
       echo -e "${RED}Please comeback again...${NC}"
       exit 0
       #break
   
# youtube link check and download   
   elif [[ "$yt_link" =~ ^https?://(www\.)?(youtube\.com/watch\?v=|youtu\.be/)([A-Za-z0-9_-]{11}) ]]; then
	    
	    echo -e "${YELLOW} URL looks good...\n Searching for the Video...\n Downloading the best audio and video (most popular)...${NC}";
            echo -e "${MAGENTA}where to Download(Default = Downloads): "${NC};
            read loca
	
	if [ "$loca" == "" ]; then
          yt-dlp -f "bestvideo+bestaudio" "$yt_link" -P "$HOME/Downloads" 
        else
          yt-dlp -f "bestvideo+bestaudio" "$yt_link" -P "$loca"
	fi
    
   else 
	echo -e "${YELLOW} This is not a general youtube link\n Searching YouTube for: $yt_link...\n Found it ✅${NC}";
    	yt-dlp --get-title --get-duration --flat-playlist ytsearch5:"$yt_link" | paste - - | nl 
   	echo -e "${CYAN}Enter the number of the video you want to download (default: 1): ${NC}"
   	read choice

    	if [[ "$choice" -ge 1 && "$choice" -le 5 || -z "$choice" ]]; then
        	video_id=$(yt-dlp --get-id --flat-playlist ytsearch5:"$yt_link" | sed -n "${choice}p")
   		if [[ -n "$video_id" ]]; then
        		yt-dlp -f "bestvideo+bestaudio" "https://www.youtube.com/watch?v=$video_id" -P "$HOME/Downloads"
   		else
        		echo -e "${RED} Choose Number Between 1-5 Please...${NC}"
    		fi
	fi

	
   fi  
   
# Asks if the user wants to download another video
   echo -e "${GREEN}Do you want to download another video?: ${NC}";
   read answer

   if [ "$answer" == "y" ] || [ "$answer" == "yes" ] || [ "$answer" ==  "Y" ] || [ "$answer" ==  "" ]; then
       #exit 0
       scrPath=dl.sh

   else
       echo -e "${RED}Exiting the script...GoodBye...${NC}";
       break
   fi
done

