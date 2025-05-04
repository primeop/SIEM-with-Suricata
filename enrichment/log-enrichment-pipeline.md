# 🔍 Log Enrichment in Logstash

This Logstash filter enriches Suricata alerts with contextual data:
- Adds GeoIP location for `src_ip`
- Parses `http_user_agent` strings
- Can be extended with threat intel (MISP, VirusTotal, etc.)
