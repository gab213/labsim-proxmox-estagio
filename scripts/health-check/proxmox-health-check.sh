#!/usr/bin/env bash
set -euo pipefail

echo "[INFO] Hostname: $(hostname)"
echo "[INFO] Data: $(date)"
echo

echo "[INFO] Versão do Proxmox"
pveversion -v || true
echo

echo "[INFO] Estado do cluster"
pvecm status || true
echo

echo "[INFO] Nós do cluster"
pvecm nodes || true
echo

echo "[INFO] Serviços principais"
systemctl --no-pager --full status pve-cluster corosync pveproxy pvedaemon pvestatd || true
echo

echo "[INFO] Storages"
pvesm status || true
echo

echo "[INFO] Rede"
ip -br a || true
ip route || true
echo

echo "[INFO] VMs e containers"
qm list || true
pct list || true
