
# 🛡️ SIEM Implementation with Suricata & ELK Stack – PoC

A practical Proof of Concept demonstrating how to deploy a SIEM using the ELK Stack, forward logs from multiple systems, perform threat hunting, and respond to security incidents.

---

## ✅ 1. ELK Stack Installation

```bash
wget https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-8.17.1-linux-x86_64.tar.gz
tar xzvf elastic-agent-8.17.1-linux-x86_64.tar.gz
cd elastic-agent-8.17.1-linux-x86_64
sudo ./elastic-agent install
```

### 1.1 Docker & Docker Compose

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y docker.io docker-compose
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
```

*Log out and back in to apply group changes.*

### 1.2 Clone Docker-ELK

```bash
git clone https://github.com/deviantony/docker-elk.git
cd docker-elk
```

### 1.3 Change Default Password

```bash
curl -XPOST -D- 'http://localhost:9200/_security/user/elastic/_password' \
  -H 'Content-Type: application/json' \
  -u elastic:changeme \
  -d '{"password" : "<your_new_password>"}'
```

### 1.4 Start the Stack

```bash
docker-compose up -d
```

### 1.5 Verify Containers

```bash
docker ps
```

### 1.6 Access Kibana

Visit: [http://localhost:5601](http://localhost:5601)

---

## 📡 2. Log Forwarding to Logstash

### 2.1 Linux Syslog Forwarding

```bash
echo '*.* @<elk-ip>:514' >> /etc/rsyslog.conf
systemctl restart rsyslog
```

### 2.2 Windows Logs via Winlogbeat

```powershell
.\winlogbeat.exe setup
.\winlogbeat.exe -e
```

### 2.3 Logstash Syslog Input

**logstash.conf**

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

```bash
systemctl restart logstash
```

---

## 🔎 3. Threat Hunting Techniques

### 3.1 Login Attempt Detection

**Linux (SSH):**
```bash
grep "Failed password" /var/log/auth.log
```

**Windows (RDP):**
```powershell
Get-WinEvent -LogName Security | Where-Object {$_.Id -eq 4625}
```

### 3.2 Network Traffic Monitoring

```bash
tcpdump -i eth0 -nn port 22 or port 3389
```

---

## 🚨 4. Incident Response Procedures

### 4.1 Host Isolation

**Linux:**
```bash
ifconfig eth0 down
```

**Windows:**
```powershell
netsh advfirewall set allprofiles state off
```

### 4.2 Malware Triage

**Analyze Binary:**
```bash
strings malware_sample | less
```

**PowerShell Logs:**
```powershell
Get-WinEvent -LogName Microsoft-Windows-PowerShell/Operational
```

---

## 📊 5. Dashboards & Alerts in Kibana

### 5.1 Create Dashboards

- Failed SSH/RDP logins
- Unusual traffic patterns
- User behavior anomalies

### 5.2 Alerting Rules

- Multiple failed logins
- New user creation
- Unexpected service restarts

---

## 🧾 6. Documentation & Reporting

- Maintain Incident Response Forms
- Log:
  - Timestamps
  - Actions taken
  - Impact and resolution

---

## 🛠️ 7. Additional Tools

| Tool         | Purpose                             |
|--------------|-------------------------------------|
| Velociraptor | Endpoint detection & monitoring     |
| MITRE ATT&CK | Threat classification & modeling    |
| Wireshark    | Deep packet inspection              |
| KAPE         | Windows artifact collection         |

---

## 🧠 8. Final Takeaways

- **Proactive Monitoring**: Real-time insights via dashboards.
- **Immediate Isolation**: Minimize damage during incidents.
- **Thorough Documentation**: Improve response and analysis.

