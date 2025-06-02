# 🧪 CCDC 2025 Guide: ELK/SIEM Setup & Threat Hunting/Incident Response

A focused guide tailored for Blue Team operations in CCDC 2025, demonstrating setup and usage of the ELK Stack for monitoring, threat detection, and incident response.

---

## 📦 ELK/SIEM Setup Guide

### 1. Initial Setup

#### 1.1 Accessing ELK Stack

- Ensure ELK is installed or identify pre-existing instances.
- Access Kibana: `http://<elk-ip>:5601`
- Verify services are running:
```bash
systemctl status elasticsearch
systemctl status logstash
systemctl status kibana
```

#### 1.2 Log Forwarding

- **Linux syslog forwarding to Logstash:**
```bash
echo '*.* @<elk-ip>:514' >> /etc/rsyslog.conf
systemctl restart rsyslog
```

- **Windows (Winlogbeat):**
```powershell
.\winlogbeat.exe setup
.\winlogbeat.exe -e
```

#### 1.3 Ingesting Logs (Logstash Config)

Sample `logstash.conf`:
```bash
input {
  udp {
    port => 514
    type => "syslog"
  }
}
output {
  elasticsearch {
    hosts => ["http://localhost:9200"]
  }
}
```
Restart Logstash:
```bash
systemctl restart logstash
```

---

## 📊 Dashboard and Alerting Setup

### 2.1 Creating Dashboards

- Navigate: Kibana → Dashboard → Create New
- Add visualizations:
  - Failed SSH/RDP logins
  - Suspicious traffic
  - Event ID anomalies

### 2.2 Setting Up Alerts

- Navigate: Kibana → Alerts & Actions
- Create detection rules for:
  - Multiple failed login attempts
  - New admin account creation
  - Unexpected service restarts

---

## 🔍 Threat Hunting Techniques

### 1.1 SSH & RDP Monitoring

- **Linux SSH failures:**
```bash
cat /var/log/auth.log | grep "Failed password"
```

- **Windows RDP failures:**
```powershell
Get-WinEvent -LogName Security | Where-Object {$_.Id -eq 4625}
```

### 1.2 Network Traffic Analysis

- **Capture traffic with tcpdump:**
```bash
tcpdump -i eth0 -nn port 22 or port 3389
```

- **Analyze in Kibana:** Look for spikes or anomalies.

---

## 🚨 Incident Response Procedures

### 2.1 Isolating Compromised Hosts

- **Linux isolation:**
```bash
ifconfig eth0 down
```

- **Windows:**
```powershell
netsh advfirewall set allprofiles state off
```

### 2.2 Analyzing Malware & Logs

- **Use strings for malware inspection:**
```bash
strings malware_sample | less
```

- **Check PowerShell logs:**
```powershell
Get-WinEvent -LogName Microsoft-Windows-PowerShell/Operational
```

---

## 🧾 Reporting & Documentation

- Maintain an **Incident Response Form**
  - Timestamps
  - Actions taken
  - Results
- Share findings and mitigation strategies with the team.

---

## 🛠️ Additional Tools & Resources

| Tool         | Purpose                             |
|--------------|-------------------------------------|
| Velociraptor | Endpoint monitoring & threat hunting|
| MITRE ATT&CK | Threat intelligence framework       |
| Wireshark    | Packet analysis & network inspection|
| KAPE         | Windows forensic triage             |

---

**✅ Pro Tip:** This guide is intended for fast-paced Blue Team readiness in competitions like CCDC. Automate where possible, monitor continuously, and document everything.

