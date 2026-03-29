# Comandos rápidos

## Cluster

```bash
pvecm status
pvecm nodes
pvesh get /cluster/status
```

## VMs e containers

```bash
qm list
pct list
qm config 100
qm start 100
qm stop 100
```

## Storage

```bash
pvesm status
df -h
lsblk
```

## Rede

```bash
ip -br a
ip route
bridge link
cat /etc/network/interfaces
cat /etc/hosts
```

## Serviços

```bash
systemctl status pve-cluster corosync pveproxy pvedaemon pvestatd
```

## Logs

```bash
journalctl -u corosync -n 100 --no-pager
journalctl -u pveproxy -n 100 --no-pager
journalctl -u pve-cluster -n 100 --no-pager
```
