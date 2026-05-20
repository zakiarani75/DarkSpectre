# ⚔ DARKSPECTRE - AI-Powered Autonomous Pentesting Framework

![Purple](https://img.shields.io/badge/Purple-Hacker-brightgreen)
![Version](https://img.shields.io/badge/Version-2.0-9b30ff)
![Kali](https://img.shields.io/badge/Platform-Kali%20Linux-9b30ff)
![Author](https://img.shields.io/badge/Author-Zakia%20Rani-9b30ff)

---

## 🌟 Project Overview

**DarkSpectre** is an advanced, AI-powered autonomous penetration testing framework for **Kali Linux**. It combines **11+ industry-standard security tools** into one automated pipeline - from network discovery to exploitation and professional HTML report generation.

> **Author:** Zakia Rani  
> **GitHub:** [@zakiarani75](https://github.com/zakiarani75)

---

## ✨ Features

| # | Feature | Description |
|---|---------|-------------|
| 1 | **Network Discovery** | Find all live devices on network |
| 2 | **Port Scanning** | Detect open ports and services |
| 3 | **Vulnerability Detection** | CVE-based scanning |
| 4 | **Web Reconnaissance** | Technology detection |
| 5 | **Hidden Directory Discovery** | Find admin panels |
| 6 | **Web Vulnerability Scan** | Misconfiguration checks |
| 7 | **SMB Enumeration** | Shared folders and users |
| 8 | **WordPress Scan** | CMS vulnerability detection |
| 9 | **SQL Injection** | Database vulnerability testing |
| 10 | **Brute Force** | SSH password cracking |
| 11 | **Auto Exploitation** | Metasploit integration |
| 12 | **HTML Report** | Professional purple-themed report |

---

## 🛠️ Tools Used

| Tool | Version | Purpose |
|------|---------|---------|
| **Netdiscover** | Latest | Network host discovery |
| **Nmap** | Latest | Port, service, OS & vuln scanning |
| **WhatWeb** | Latest | Web technology detection |
| **Dirb** | Latest | Hidden directory discovery |
| **Nikto** | Latest | Web vulnerability scanner |
| **WPScan** | Latest | WordPress vulnerability scanner |
| **SQLMap** | Latest | SQL injection detection |
| **Hydra** | Latest | Brute force password cracking |
| **Enum4Linux** | Latest | SMB/Windows enumeration |
| **Metasploit** | Latest | Exploitation framework |
| **Python 3** | 3.x | Automation & report generation |

---

## 📋 Requirements

- ✅ **Kali Linux** (2024+ recommended)
- ✅ **8GB+ RAM**
- ✅ **20GB+ free disk space**
- ✅ **VirtualBox** (for Metasploitable 2 target)

---

## 🔧 Installation

```bash
# Clone the repository
git clone https://github.com/zakiarani75/DarkSpectre.git
cd DarkSpectre

# Make script executable
chmod +x final_scan.sh

# Install dependencies
sudo apt update
sudo apt install -y nmap netdiscover hydra dirb nikto whatweb \
  metasploit-framework sqlmap wpscan enum4linux python3-pip

# Install Python libraries
pip3 install colorama requests
## Project Screenshots
### 1. Web Report Dashboard
![DarkSpectre Dashboard](44529.jpg)

### 2. Execution Complete & Server Setup
![DarkSpectre Execution Complete](44530.jpg)

### 3. Scanning Process (Terminal)
![DarkSpectre Scanning Process](44531.jpg)



