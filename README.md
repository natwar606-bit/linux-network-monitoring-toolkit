# Linux Network Health Monitoring Toolkit

## Overview

Linux Network Health Monitoring Toolkit is a Bash scripting project that monitors the health of a Linux server by collecting important system and network information. It validates required dependencies, checks internet and DNS connectivity, monitors critical services, displays firewall information, analyzes disk and memory usage, calculates a network health score, and generates timestamped log files.

This project is designed for Linux Administrators, Cloud Engineers, DevOps Engineers, and Linux learners who want a lightweight monitoring tool built entirely with Bash.

---

## Features

* Dependency validation before execution
* Collects basic system information

  * Hostname
  * Current User
  * Operating System
  * Kernel Version
* Displays network information

  * IP Address
  * Network Interface
  * Default Gateway
* Internet connectivity check
* DNS resolution check
* Displays active listening ports
* Monitors critical services

  * SSHD
  * Firewalld
* Displays firewall information

  * Active Zone
  * Allowed Services
  * Open Ports
* Displays disk usage
* Displays memory usage
* Calculates a Network Health Score (0–100)
* Generates timestamped log files
* Modular Bash script using reusable functions

---

## Project Structure

```text
linux-network-monitoring-toolkit/
├── logs/
├── network-health.sh
├── README.md
└── .gitignore
```

---

## Prerequisites

* Linux (Tested on CentOS Stream 10)
* Bash
* curl
* iproute2 (`ip`)
* bind-utils (`nslookup`)
* iproute (`ss`)
* systemd (`systemctl`)
* firewalld (`firewall-cmd`)

---

## Installation

Clone the repository:

```bash
git clone git@github.com:natwar606-bit/linux-network-monitoring-toolkit.git 
cd linux-network-monitoring-toolkit
```

Make the script executable:

```bash
chmod +x network-health.sh
```

Run the script:

```bash
./network-health.sh
```

---

## Sample Output

The script displays:

* Dependency Check
* Basic System Information
* Network Information
* Internet Connectivity Status
* DNS Resolution Status
* Active Listening Ports
* SSHD Service Status
* Firewalld Service Status
* Firewall Configuration
* Disk Usage
* Memory Usage
* Network Health Summary
* Health Score

---

## Health Score Logic

| Check                 |   Score |
| --------------------- | ------: |
| Internet Connectivity |      40 |
| DNS Resolution        |      25 |
| SSH Service           |      20 |
| Firewalld Service     |      15 |
| **Total**             | **100** |

---

## Log Files

Each execution generates a timestamped log file inside the `logs/` directory.

Example:

```text
logs/network_monitor_2026-07-05_12-04-22.log
```

---

## Acknowledgements

This project was built and implemented by me as part of my Linux and Bash scripting learning journey.

I used AI as a learning assistant for concept clarification, debugging guidance, and code review. The project logic, implementation, testing, and understanding were completed by me.

---

## Author

**Natwar Kumar**

Learning Linux, Networking, Cloud, AWS, and DevOps through practical, production-oriented projects.
