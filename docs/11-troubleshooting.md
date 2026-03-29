# Troubleshooting

## Interface Web não abre

```bash
ss -tulpn | grep 8006
systemctl status pveproxy
journalctl -u pveproxy -n 100 --no-pager
```

## Cluster sem quorum

```bash
pvecm status
pvecm nodes
systemctl status corosync
cat /etc/pve/corosync.conf
```

## Nó online no sistema, mas offline no Datacenter

```bash
hostname
hostname -I
cat /etc/hosts
ip -br a
ip route
```

## VM sem rede

No host:

```bash
qm config 110
bridge link
cat /etc/network/interfaces
```

No guest:

```bash
ip -br a
ip route
```

## Storage cheio

```bash
pvesm status
df -h
lsblk
```

## Regra prática

Na maioria dos incidentes, validar primeiro rede, cluster, storage, serviços e só depois a VM.
