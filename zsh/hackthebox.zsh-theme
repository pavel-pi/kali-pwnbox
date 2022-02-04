# credits: https://github.com/ikirt/htb-ohmyzsh-theme

# Custom Colors
green='118'
blue='75'
red='196'

CURRENT_BG='NONE'

() {
  local LC_ALL="" LC_CTYPE="en_US.UTF-8"
  SEGMENT_SEPARATOR_TOP='┌─['
  SEGMENT_SEPARATOR_BOT='└──╼'
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ $UID -eq 0 ]]; then
    echo -n "%{%f%} %{%k%F{$red}%}#"
  else
    echo -n "%{%f%} %{%k%F{$green}%}$"
  fi 
  CURRENT_BG=''
}

# Context: user@hostname (who am I and where am I)
prompt_context() {
  if [[ "$USER" != "root" ]]; then
    echo -n "%(!.%{%F{red}%}.)%{%k%F{white}%}$USER%{%k%F{$green}%}@%{%k%F{$blue}%}%m%{%k%F{$green}%}]─["
  else
    echo -n "%(!.%{%F{red}%}.)%{%k%F{$red}%}$USER%{%k%F{$green}%}@%{%k%F{$blue}%}%m%{%k%F{$green}%}]─["
  fi
}

# Dir: current working directory
prompt_dir() {
  echo -n  '%{%k%F{white}%}%~%{%k%F{$green}%}]'
}

# VPN: htb vpn location
prompt_vpn_loc() {
  #this script can be found here https://github.com/pavel-pi/kali-pwnbox
  htb_vpn_loc=`/opt/pwnbox/vpnserver.sh`
  if [[ -n $htb_vpn_loc ]]; then
    echo -n  "%{%k%F{$blue}%}${htb_vpn_loc}%{%k%F{$green}%}]─["
  fi
}

# VPN: htb vpn IP
prompt_vpn_ip() {
   #this script can be found here https://github.com/pavel-pi/kali-pwnbox
   htb_vpn_ip=`/opt/pwnbox/vpnbash.sh`
   if [[ -n $htb_vpn_ip ]]; then
     echo -n "%{%k%F{white}%}${htb_vpn_ip}%{%k%F{$green}%}]─["
   fi
}

# Virtualenv: current working virtualenv
prompt_virtualenv() {
  local virtualenv_path="$VIRTUAL_ENV"
  if [[ -n $virtualenv_path && -n $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
    echo -n  "(`basename $virtualenv_path`)"
  fi
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local symbols
  FAIL_CHAR=$'\u2622'
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{$red}%}${FAIL_CHAR}"
  [[ $UID -eq 0 ]] && symbols+="%{%F{$red}%}⚡"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}⚙"

  [[ -n "$symbols" ]] && echo -n "%{%F{$green}%}[$symbols%{%F{$green}%}]"
}

prompt_newline() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n "%{%k%F{$CURRENT_BG}%}
%{%k%F{$green}%}$SEGMENT_SEPARATOR_BOT"
  else
    echo -n "%{%k%}"
  fi

  echo -n "%{%f%}"
  CURRENT_BG=''
}

prompt_spacer() {
  echo -n "%{%k%F{$green}%}]-["
}

prompt_header() {
  echo -n "%{%k%F{$green}%}$SEGMENT_SEPARATOR_TOP"
}

## Main prompt
build_prompt() {
  RETVAL=$?
  prompt_header
  prompt_vpn_loc
  prompt_vpn_ip
  prompt_virtualenv
  prompt_context
  prompt_dir
  prompt_newline
  prompt_status
  prompt_end
}

PROMPT='%{%f%b%k%}$(build_prompt) %{$reset_color%}'

zle_highlight=( default:fg=$green )

