#!/usr/bin/env bash

T_RED=91
T_GRN=92
T_YLW=93
T_BLU=94
T_CYN=96


colorecho () {
   echo -e "\e[$1m$2"
}                         

_LOGO_COL=${T_BLU}

colorecho ${_LOGO_COL} 	"═════════════════════════════════"
colorecho ${_LOGO_COL} 	"██╗  ██╗███████╗██╗     ██╗   ██╗"
colorecho ${_LOGO_COL} 	"██║  ██║██╔════╝██║     ██║   ██║"
colorecho ${_LOGO_COL} 	"███████║███████╗██║     ██║   ██║"
colorecho ${_LOGO_COL} 	"██╔══██║╚════██║██║     ██║   ██║"
colorecho ${_LOGO_COL} 	"██║  ██║███████║███████╗╚██████╔╝"
colorecho ${_LOGO_COL} 	"╚═╝  ╚═╝╚══════╝╚══════╝ ╚═════╝ "
colorecho ${_LOGO_COL} 	"═════════════════════════════════"                                 

colorecho ${T_RED}		"This Computer is Property of the"
colorecho ${T_RED}		"Lucerne University"
colorecho ${T_RED}		"of Applied Sciences" 
echo ""
colorecho ${T_RED}		"any abuse prohibited"
colorecho ${T_RED}		"All rights reserved."
colorecho ${T_RED}		"Lucerne, Switzerland (2019)"

colorecho ${_LOGO_COL} 	"═════════════════════════════════"
colorecho ${T_GRN}		"Dear Student,"
colorecho ${T_GRN}		"please handle with care."
colorecho ${_LOGO_COL} 	"═════════════════════════════════"
