#!/bin/bash
PURPLE='\033[1;35m';GREEN='\033[0;32m';CYAN='\033[0;36m';BOLD='\033[1m';NC='\033[0m'
BASE_DIR="/root/DarkSpectre";REPORT_DIR="$BASE_DIR/reports";mkdir -p "$REPORT_DIR"
clear;echo -e "${PURPLE}${BOLD}";echo "============================================================"
echo "   DARKSPECTRE - FINAL MASTER SCAN";echo "   Author: Zakia Rani"
echo "   Date: $(date)";echo "============================================================";echo -e "${NC}"
read -p "$(echo -e ${PURPLE}${BOLD}'Enter target IP: '${NC})" TARGET
echo "";echo -e "${PURPLE}${BOLD}[+] Author: Zakia Rani${NC}";echo -e "${GREEN}[+] Target: $TARGET${NC}"
echo -e "${GREEN}[+] Reports: $REPORT_DIR/${NC}";echo ""

run_tool() {
    local num=$1;local name=$2;local cmd=$3;local out=$4;local purpose=$5
    echo -e "${PURPLE}${BOLD}[$num/11] $name${NC}"
    echo -e "${CYAN}$purpose${NC}";echo -e "${CYAN}Command: $cmd${NC}"
    eval "$cmd > \"$REPORT_DIR/$out\" 2>&1"
    echo -e "${GREEN}${BOLD}[OK] Complete${NC}";echo "----------------------------------------";sleep 1
}

run_tool "1" "NETDISCOVER - Network Discovery" \
    "sudo netdiscover -r 192.168.1.0/24 -P" "01_netdiscover.txt" \
    "Purpose: Find live devices on network"

run_tool "2" "NMAP - Port and Service Scan" \
    "sudo nmap -sS -sV -O -p- $TARGET" "02_nmap_scan.txt" \
    "Purpose: Detect open ports, services, OS"

run_tool "3" "NMAP VULN SCRIPTS" \
    "sudo nmap --script vuln $TARGET" "03_nmap_vuln.txt" \
    "Purpose: Scan for known CVEs"

run_tool "4" "WHATWEB - Website Technology" \
    "whatweb http://$TARGET -v" "04_whatweb.txt" \
    "Purpose: Identify website technologies"

run_tool "5" "DIRB - Hidden Directories" \
    "dirb http://$TARGET /usr/share/wordlists/dirb/common.txt" "05_dirb.txt" \
    "Purpose: Find hidden pages, admin panels"

run_tool "6" "NIKTO - Web Vulnerability Scanner" \
    "nikto -h http://$TARGET" "06_nikto.txt" \
    "Purpose: Check web server misconfigurations"

run_tool "7" "ENUM4LINUX - SMB Enumeration" \
    "enum4linux -a $TARGET" "07_enum4linux.txt" \
    "Purpose: Enumerate shared folders, users"

run_tool "8" "WPSCAN - WordPress Scanner" \
    "wpscan --url http://$TARGET --no-update --enumerate u,vp,vt" "08_wpscan.txt" \
    "Purpose: WordPress vulnerability scan"

run_tool "9" "SQLMAP - SQL Injection" \
    "sqlmap -u 'http://$TARGET/cgi-bin/param?page=1' --batch --dbs" "09_sqlmap.txt" \
    "Purpose: SQL injection detection"

echo -e "root\nadmin\nmsfadmin\nuser\ntest\nkali" > "$REPORT_DIR/10_users.txt"
run_tool "10" "HYDRA - Brute Force" \
    "sudo hydra -L $REPORT_DIR/10_users.txt -P /usr/share/wordlists/rockyou.txt.gz ssh://$TARGET" "10_hydra.txt" \
    "Purpose: Crack SSH passwords"

cat > "$REPORT_DIR/11_exploit.rc" << EOFF
use exploit/unix/ftp/vsftpd_234_backdoor
set RHOSTS $TARGET
set RPORT 21
check
exit
EOFF

run_tool "11" "METASPLOIT - Exploitation" \
    "sudo msfconsole -q -r $REPORT_DIR/11_exploit.rc" "11_metasploit.txt" \
    "Purpose: Auto exploitation"

echo "";echo -e "${PURPLE}${BOLD}[*] Generating HTML Report...${NC}"

cat > "$REPORT_DIR/index.html" << 'HTMLEND'
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DarkSpectre Report - Zakia Rani</title>
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:'Segoe UI',Arial,sans-serif;background:#0a0015;color:#e0d0f0;padding:25px}
.header{background:linear-gradient(135deg,#2d0050,#1a0033);padding:40px;text-align:center;border-radius:15px;margin-bottom:25px;border:2px solid #9b30ff}
.header h1{color:#c084fc;font-size:2.8em;letter-spacing:5px;text-shadow:0 0 20px rgba(192,132,252,0.5)}
.header .author{color:#d8b4fe;font-weight:bold;font-size:1.4em;margin-top:10px}
.nav{background:#1a0033;padding:12px;border-radius:10px;margin-bottom:25px;text-align:center;border:1px solid #9b30ff66;position:sticky;top:10px;z-index:100}
.nav a{color:#c0a0e0;text-decoration:none;padding:6px 12px;margin:2px;display:inline-block;border-radius:5px;transition:0.3s;font-weight:600}
.nav a:hover{background:#9b30ff;color:#fff}
.dashboard{display:flex;justify-content:center;gap:20px;flex-wrap:wrap;margin-bottom:30px}
.card{background:linear-gradient(135deg,#1a0033,#2d0050);padding:25px;border-radius:12px;text-align:center;min-width:170px;border:1px solid #9b30ff66}
.card .num{font-size:2.5em;font-weight:bold;color:#d8b4fe}
.card .label{color:#a080c0;margin-top:5px;font-weight:600}
.section{background:linear-gradient(135deg,#1a0033,#0d0020);border-radius:12px;padding:25px;margin-bottom:20px;border-left:5px solid #9b30ff}
.section h2{color:#d8b4fe;margin-bottom:15px;padding-bottom:10px;border-bottom:2px solid #9b30ff66}
.section .info{background:#0d0020;padding:10px 15px;border-radius:5px;color:#c0a0e0;margin:8px 0;border-left:3px solid #9b30ff66}
.section .info strong{color:#d8b4fe}
pre{background:#0a0015;padding:15px;border-radius:8px;color:#00ff88;font-size:0.9em;line-height:1.5;border:1px solid #9b30ff33;overflow-x:auto;max-height:400px;overflow-y:auto;margin-top:12px}
table{width:100%;border-collapse:collapse;margin:15px 0}
th{background:linear-gradient(135deg,#9b30ff,#6b21a8);color:#fff;padding:12px;text-align:left}
td{border:1px solid #9b30ff33;padding:10px}
tr:hover{background:#1a0033aa}
.footer{text-align:center;padding:25px;color:#666;margin-top:30px;border-top:1px solid #9b30ff33}
.footer .author{color:#d8b4fe;font-weight:bold;font-size:1.2em;margin:8px 0}
</style>
</head>
<body>
<div class="header">
<h1>DARKSPECTRE</h1>
<p>AI-Powered Pentest Framework</p>
<p class="author">Author: Zakia Rani</p>
<p style="color:#c0a0e0;margin-top:10px">TARGET_INFO</p>
</div>
<div class="nav">
<a href="#t1">Netdiscover</a><a href="#t2">Nmap</a><a href="#t3">Nmap Vuln</a>
<a href="#t4">WhatWeb</a><a href="#t5">Dirb</a><a href="#t6">Nikto</a>
<a href="#t7">Enum4Linux</a><a href="#t8">WPScan</a><a href="#t9">SQLMap</a>
<a href="#t10">Hydra</a><a href="#t11">Metasploit</a>
<a href="#vuln" style="background:#9b30ff;color:#fff">Vulnerabilities</a>
<a href="#sum" style="background:#00aa00;color:#fff">Summary</a>
</div>
<div class="dashboard">
<div class="card"><div class="num">11</div><div class="label">Tools</div></div>
<div class="card"><div class="num" style="color:#00ff88">100%</div><div class="label">Complete</div></div>
<div class="card"><div class="num" style="color:#d8b4fe">ZR</div><div class="label">Zakia Rani</div></div>
</div>

<div class="section" id="t1"><h2>TOOL 1: NETDISCOVER</h2>
<div class="info"><strong>Purpose:</strong> Find live devices on network</div>
<div class="info"><strong>Command:</strong> sudo netdiscover -r 192.168.1.0/24 -P</div>
<pre>F01</pre></div>

<div class="section" id="t2"><h2>TOOL 2: NMAP - Port Scan</h2>
<div class="info"><strong>Purpose:</strong> Detect open ports, services, OS</div>
<div class="info"><strong>Command:</strong> sudo nmap -sS -sV -O -p- TARGET</div>
<pre>F02</pre></div>

<div class="section" id="t3"><h2>TOOL 3: NMAP VULN</h2>
<div class="info"><strong>Purpose:</strong> Scan for known CVEs</div>
<div class="info"><strong>Command:</strong> sudo nmap --script vuln TARGET</div>
<pre>F03</pre></div>

<div class="section" id="t4"><h2>TOOL 4: WHATWEB</h2>
<div class="info"><strong>Purpose:</strong> Identify website technologies</div>
<div class="info"><strong>Command:</strong> whatweb http://TARGET -v</div>
<pre>F04</pre></div>

<div class="section" id="t5"><h2>TOOL 5: DIRB</h2>
<div class="info"><strong>Purpose:</strong> Find hidden pages, admin panels</div>
<div class="info"><strong>Command:</strong> dirb http://TARGET common.txt</div>
<pre>F05</pre></div>

<div class="section" id="t6"><h2>TOOL 6: NIKTO</h2>
<div class="info"><strong>Purpose:</strong> Web vulnerability scanner</div>
<div class="info"><strong>Command:</strong> nikto -h http://TARGET</div>
<pre>F06</pre></div>

<div class="section" id="t7"><h2>TOOL 7: ENUM4LINUX</h2>
<div class="info"><strong>Purpose:</strong> SMB enumeration</div>
<div class="info"><strong>Command:</strong> enum4linux -a TARGET</div>
<pre>F07</pre></div>

<div class="section" id="t8"><h2>TOOL 8: WPSCAN</h2>
<div class="info"><strong>Purpose:</strong> WordPress vulnerability scan</div>
<div class="info"><strong>Command:</strong> wpscan --url http://TARGET</div>
<pre>F08</pre></div>

<div class="section" id="t9"><h2>TOOL 9: SQLMAP</h2>
<div class="info"><strong>Purpose:</strong> SQL injection detection</div>
<div class="info"><strong>Command:</strong> sqlmap -u URL --batch</div>
<pre>F09</pre></div>

<div class="section" id="t10"><h2>TOOL 10: HYDRA</h2>
<div class="info"><strong>Purpose:</strong> Crack SSH passwords</div>
<div class="info"><strong>Command:</strong> hydra -L users.txt -P rockyou.txt ssh://TARGET</div>
<pre>F10</pre></div>

<div class="section" id="t11"><h2>TOOL 11: METASPLOIT</h2>
<div class="info"><strong>Purpose:</strong> Auto exploitation</div>
<div class="info"><strong>Command:</strong> msfconsole -r exploit.rc</div>
<pre>F11</pre></div>

<div class="section" id="vuln"><h2>ALL VULNERABILITIES</h2>
<pre>VULN</pre></div>

<div class="section" id="sum"><h2>FINAL SUMMARY</h2>
<table><tr><th>Tool</th><th>Status</th></tr>
<tr><td>Netdiscover</td><td style="color:#00ff88;font-weight:bold">Complete</td></tr>
<tr><td>Nmap</td><td style="color:#00ff88;font-weight:bold">Complete</td></tr>
<tr><td>Nmap Vuln</td><td style="color:#00ff88;font-weight:bold">Complete</td></tr>
<tr><td>WhatWeb</td><td style="color:#00ff88;font-weight:bold">Complete</td></tr>
<tr><td>Dirb</td><td style="color:#00ff88;font-weight:bold">Complete</td></tr>
<tr><td>Nikto</td><td style="color:#00ff88;font-weight:bold">Complete</td></tr>
<tr><td>Enum4Linux</td><td style="color:#00ff88;font-weight:bold">Complete</td></tr>
<tr><td>WPScan</td><td style="color:#00ff88;font-weight:bold">Complete</td></tr>
<tr><td>SQLMap</td><td style="color:#00ff88;font-weight:bold">Complete</td></tr>
<tr><td>Hydra</td><td style="color:#00ff88;font-weight:bold">Complete</td></tr>
<tr><td>Metasploit</td><td style="color:#00ff88;font-weight:bold">Complete</td></tr>
</table>
<p style="margin-top:15px;color:#c0a0e0"><strong>Author:</strong> <span style="color:#d8b4fe">Zakia Rani</span></p>
</div>

<div class="footer">
<p style="font-size:1.3em;color:#c084fc;font-weight:bold">DARKSPECTRE</p>
<p class="author">Author: Zakia Rani</p>
<p>GitHub: github.com/zakiarani75/DarkSpectre</p>
<p style="color:#555;margin-top:8px">I have permission and am authorized</p>
</div>
</body>
</html>
HTMLEND

# Replace placeholders
python3 << PYEOF
import os
base="$REPORT_DIR";target="$TARGET"
with open(base+"/index.html","r") as f:c=f.read()
import subprocess as sp
c=c.replace("TARGET_INFO","Target: "+target+" | Date: "+sp.getoutput("date"))
files={"F01":"01_netdiscover.txt","F02":"02_nmap_scan.txt","F03":"03_nmap_vuln.txt","F04":"04_whatweb.txt","F05":"05_dirb.txt","F06":"06_nikto.txt","F07":"07_enum4linux.txt","F08":"08_wpscan.txt","F09":"09_sqlmap.txt","F10":"10_hydra.txt","F11":"11_metasploit.txt"}
for p,f in files.items():
    try:
        with open(base+"/"+f,"r") as fh:fc=fh.read()
        if len(fc)>8000:fc=fc[:8000]+"\n...truncated..."
        c=c.replace(p,fc)
    except:c=c.replace(p,"[No data]")
v=""
try:
    with open(base+"/03_nmap_vuln.txt","r") as f:
        for l in f:
            if any(x in l.upper() for x in ["VULNERABLE","CVE-","CRITICAL","HIGH"]):v+=l
    if not v:v="No critical vulnerabilities detected"
except:v="Vulnerability data not available"
c=c.replace("VULN",v)
with open(base+"/index.html","w") as f:f.write(c)
print("[OK] Report generated")
PYEOF

cp "$REPORT_DIR/index.html" "$BASE_DIR/index.html"
echo "";echo -e "${PURPLE}${BOLD}============================================================"
echo "           DARKSPECTRE - ALL COMPLETE!"
echo "           Author: Zakia Rani"
echo "============================================================";echo -e "${NC}"
echo -e "${PURPLE}${BOLD}[+] Author: Zakia Rani${NC}"
echo -e "${GREEN}[+] Reports: $REPORT_DIR/${NC}"
echo -e "${PURPLE}${BOLD}[+] Open: python3 -m http.server 8080${NC}"
echo -e "${PURPLE}${BOLD}[+] Then: firefox http://127.0.0.1:8080/index.html${NC}"
