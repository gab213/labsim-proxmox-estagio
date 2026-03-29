#!/usr/bin/env bash
set -euo pipefail

OUT_DIR="/tmp/labsim-inventory-$(date +%Y%m%d-%H%M%S)"
mkdir -p "${OUT_DIR}"

echo "[INFO] Salvando inventário em ${OUT_DIR}"

hostname > "${OUT_DIR}/hostname.txt"
hostname -I > "${OUT_DIR}/hostname-I.txt" || true
pveversion -v > "${OUT_DIR}/pveversion.txt" || true
pvecm status > "${OUT_DIR}/pvecm-status.txt" || true
pvecm nodes > "${OUT_DIR}/pvecm-nodes.txt" || true
qm list > "${OUT_DIR}/qm-list.txt" || true
pct list > "${OUT_DIR}/pct-list.txt" || true
pvesm status > "${OUT_DIR}/pvesm-status.txt" || true
ip -br a > "${OUT_DIR}/ip-br-a.txt" || true
ip route > "${OUT_DIR}/ip-route.txt" || true
cp /etc/hosts "${OUT_DIR}/hosts.txt" || true
cp /etc/network/interfaces "${OUT_DIR}/interfaces.txt" || true
cp /etc/pve/corosync.conf "${OUT_DIR}/corosync.conf" || true

echo "[INFO] Inventário concluído em ${OUT_DIR}"
