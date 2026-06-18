# Linux Network Monitoring Toolkit

A Bash-based Linux monitoring tool that collects system and network health information.

## Features

- Basic Server Information
  - Hostname
  - Current User
  - Date & Time
  - OS Information
  - Kernel Version

- Network Information
  - IP Address
  - Network Interface
  - Default Gateway

- Internet Connectivity Check

- DNS Resolution Check

- Open Ports Check

- Critical Services Check
  - SSH Service
  - Firewall Service

- Firewall Information
  - Active Zone
  - Allowed Services
  - Open Ports

- Disk Health Check

- Memory Health Check

- Network Health Summary

## Technologies Used

- Linux (CentOS Stream 10)
- Bash Scripting
- Networking Commands
- Firewalld
- Systemctl

## Commands Used

- hostname
- whoami
- date
- uname
- ip
- grep
- awk
- curl
- nslookup
- ss
- firewall-cmd
- systemctl
- df
- free

## Project Structure

```text
linux-network-monitoring-toolkit/
├── README.md
├── network-health.sh
├── screenshots/
├── docs/
└── reports/
