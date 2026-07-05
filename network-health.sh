#!/bin/bash


HEALTH_SCORE=0
#Depedencies Check
check_dependencies(){
REQUIRED_COMMANDS=(
    ip
    curl
    nslookup
    ss
    systemctl
    firewall-cmd
)


echo "=========================="
echo "Dependency Check"
echo "=========================="

for cmd in "${REQUIRED_COMMANDS[@]}"
do
  if command -v "$cmd" >/dev/null 2>&1
      then  echo "[PASS] $cmd"
  else  
      echo " [FAIL] $cmd is not installed"
      exit 1
  fi
 done
}

# Log Configuration
LOG_DIR="logs"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="$LOG_DIR/network_monitor_$TIMESTAMP.log"

mkdir -p "$LOG_DIR"
touch "$LOG_FILE"

log_message() {
    echo "$1"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"

}

#Basic Server Information
get_system_info(){
echo "========================="
   echo "Basic Server information"
echo "========================="

HOSTNAME=$(hostname)
CURRENT_USER=$(whoami)
CURRENT_DATE=$(date)
OS_NAME=$(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '\"')
KERNEL_VERSION=$(uname -r)

echo "Hostname: $HOSTNAME"
echo "current-user : $CURRENT_USER"
echo "date & time : $CURRENT_DATE"
echo "Os : $OS_NAME"
echo "kernel version : $KERNEL_VERSION"
}



#Network Information
get_network_info(){
echo ""
echo "===================="
echo "Network information"
echo "============"
DEFAULT_ROUTE=$(ip route | grep "^default")
NETWORK_INTERFACE=$(echo "$DEFAULT_ROUTE" | awk '{print $5}')
DEFAULT_GATEWAY=$(echo "$DEFAULT_ROUTE" | awk '{print $3}')
IP_ADDRESS=$(ip -4 addr show "$NETWORK_INTERFACE" | awk '/inet / {print $2}' | cut -d/ -f1) 

echo "ip Address        : $IP_ADDRESS"
echo "network interface : $NETWORK_INTERFACE"
echo "Default Gateway   : $DEFAULT_GATEWAY"
echo ""
}



#Internet Check
check_internet(){
echo "==========================="
echo "internet connectivity check"
echo "================="

if  curl --connect-timeout 5 --max-time 10 -I https://google.com >/dev/null 2>&1 
then
     INTERNET_STATUS="PASS"
    HEALTH_SCORE=$((HEALTH_SCORE+40))
else
    INTERNET_STATUS="FAIL"

fi
log_message "Internet Status : $INTERNET_STATUS"
echo ""
}



#DNS Check
check_dns(){
echo ""
echo "======"
echo "DNS Check"
echo "=========="

if  nslookup google.com >/dev/null 2>&1 
then
 DNS_STATUS="PASS"
HEALTH_SCORE=$((HEALTH_SCORE+25))

else
 DNS_STATUS="FAIL"

fi
log_message "DNS Status : $DNS_STATUS"
echo ""
}


# Open Ports
show_open_ports(){
echo "==========="
echo "Open Ports"
echo "================"
ss -tuln | grep LISTEN
echo 
}


#Check Critical service
check_services(){
echo "==============================="
echo "Critical Services Check"
echo "==========================="

SSHD_STATUS=$(systemctl is-active sshd)
FIREWALLD_STATUS=$(systemctl is-active firewalld)
log_message "SSHD Service      : $SSHD_STATUS"
log_message "Firewalld Service : $FIREWALLD_STATUS"
if [ "$SSHD_STATUS" = "active" ]
then
    HEALTH_SCORE=$((HEALTH_SCORE + 20))
fi

if [ "$FIREWALLD_STATUS" = "active" ]
then
    HEALTH_SCORE=$((HEALTH_SCORE + 15))
fi
echo

}



#Firewalld Information
check_firewalld(){
echo "====================="
echo "Firewall Information"
echo "====================="

FIREWALL_STATE=$(firewall-cmd --state 2>/dev/null)
if [ "$FIREWALL_STATE" = "running" ]
then
    ACTIVE_ZONES=$(firewall-cmd --get-active-zones)
    SERVICES_LIST=$(firewall-cmd --list-services)
    OPEN_PORTS=$(firewall-cmd --list-ports)
else
    ACTIVE_ZONES=""
    SERVICES_LIST=""
    OPEN_PORTS=""
fi

echo "Active Zone       : ${ACTIVE_ZONES:-N/A}"
echo "Services List     : ${SERVICES_LIST:-N/A}"
echo "Open Ports        : ${OPEN_PORTS:-N/A}"
}


#Disk Health
check_disk(){
echo "==================="
echo "Disk Health"
echo "============="
df -h /
}

#Memory Health
check_memory(){
echo ""
echo "==========="
echo "Memory Health"
echo "==================="
free -h

}

#Summarry
show_summary(){
echo ""
echo "============================"
echo "NETWORK HEALTH SUMMARY"
echo "======================"


echo "Internet Status   : $INTERNET_STATUS"
echo "DNS Status       : $DNS_STATUS"
echo "SSHD Service      : $SSHD_STATUS"
echo "Firewalld Service : $FIREWALLD_STATUS"
echo "Active Zone       : $ACTIVE_ZONES"
echo "Services List     : $SERVICES_LIST"
echo "Open Ports        : ${OPEN_PORTS:-N/A}"
echo
}

main() {
   log_message "Script Started"
   check_dependencies
    get_system_info
    get_network_info
    check_internet
    check_dns
    show_open_ports
    check_services
    check_firewalld
    check_disk
    check_memory
    show_summary
    log_message "Health Score : $HEALTH_SCORE/100"
    log_message "Script Completed"
}

main
