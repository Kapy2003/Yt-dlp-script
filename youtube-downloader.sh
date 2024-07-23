#!/bin/bash

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

   # check if the user wants to exit
   if [ "$yt_link" == "exit" ] || [ "$yt_link" == "q" ]; then
       echo -e "${RED}Please comeback again...${NC}"
       break


   elif [[ "$yt_link" =~ ^https?://(www\.)?youtube\.com/ ]]; then
       echo -e "${MAGENTA}where to store : "${NC};
       read loca
       echo -e "${YELLOW}Searching for the link and downloading the best audio and video...${NC}";
       if [ "$loca" == "" ]; then
            # Default Download
           yt-dlp -f "bestvideo+bestaudio" "$yt_link" -P "/hdd/Videos/yt-dlp/"
       else
            yt-dlp -f "bestvideo+bestaudio" "$yt_link" -P "$loca"

       fi

   else
       echo -e "${MAGENTA}where to store : "${NC};
       read loca
       echo -e "${YELLOW}Searching and downloading the best audio and video file...${NC}";
       if [ "$loca" == "" ]; then
            # Default Download
           yt-dlp -f "bestvideo+bestaudio" ytsearch:"$yt_link" -P "/hdd/Videos/yt-dlp/"
       else
            yt-dlp -f "bestvideo+bestaudio" ytsearch:"$yt_link" -P "$loca"

       fi

   fi

   # Asks if the user wants to download another video
   echo -e "${GREEN}Do you want to download another video? (y/n):${NC}";
   read answer

   if [ "$answer" != "y" ]; then
        echo -e "${RED}Exiting the script...${NC}";
        break
   fi
done

