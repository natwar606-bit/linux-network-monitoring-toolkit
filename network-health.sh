#!/bin/bash
echo "========================="
   echo "Basic Server information"
echo "========================="


echo "Hostname: $(hostname)"
echo ""
echo "current-user : $(whoami)"
echo ""
echo "date & time : $(date)"
echo ""
echo "Os : $(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '\"')"
echo ""
echo "kernal version : $(uname -r)"
echo ""


echo ""
echo "================"
echo "Network information"
echo "============"
echo "ip Address: $(ip route | grep default | awk '{print $9}')"
echo "network interface : $(ip route |grep default | awk '{print $5}')"
echo "Default Gateway :$(ip route | grep default | awk '{print $3}')"
echo ""
echo ""
echo "==========================="
echo "internet connectivity check"
echo "================="

if  curl -I https://google.com >/dev/null 2>&1 
then
     Internet_status="pass"
else
    Internet_status="fail"
fi
echo "internet status : $Internet_status"
echo ""

echo ""
echo "======"
echo "DNS Check"
echo "=========="

if  nslookup google.com >/dev/null 2>&1 
then
 DNS_status="pass "
else
 DNS_status="fail"
fi
echo "DNS_status : $DNS_status"
echo ""
echo ""

echo "==========="
echo "Open Ports"
echo "================"
echo "$(ss -tuln | grep LISTEN)"
echo ""

echo "==============================="
echo "Critical Services Check"
echo "==========================="
echo "sshd servese : $(systemctl is-active sshd)"
echo "firewalled servese : $(systemctl is-active firewalld)"

echo ""
echo "====================="
echo "Firewall information"
echo "=============="
echo "Active zone:"
Active_zones=$(firewall-cmd --get-active-zones)
echo "$Active_zones"
echo "services list:"
Services_list=$(firewall-cmd --list-services)
echo "$Services_list"
echo ""
echo "open ports:"
Open_ports=$(firewall-cmd --list-ports)
echo "$Open_ports"
echo ""

echo ""
echo "==================="
echo "Disk Health"
echo "============="
df -h /

echo ""
echo "==========="
echo "Memory Health"
echo "==================="
free -h


echo ""
echo "============================"
echo "NETWORK HEALTH SUMMARY"
echo "======================"


echo "internet status : $Internet_status"
echo "DNS_status : $DNS_status"

echo "sshd servese : $(systemctl is-active sshd)"
echo "firewalled servese : $(systemctl is-active firewalld)"

echo "Active zone : $Active_zones"
echo "Services list : $Services_list"
echo "open ports : $Open_ports"
