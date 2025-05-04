#!/bin/bash

echo "[*] Running simulated attack traffic..."
# Port scan
nmap -sS 127.0.0.1 -p 22,80,443

# Brute force
for i in {1..10}; do
  curl -X POST http://127.0.0.1/login -d "username=admin&password=wrong"
done
