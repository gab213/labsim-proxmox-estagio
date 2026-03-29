# Operação básica

## Acesso

Cada nó pode ser acessado pela interface Web do Proxmox na porta `8006`.

## Comandos principais

```bash
pveversion -v
pvecm status
pvecm nodes
qm list
pct list
pvesm status
ip -br a
ip route
```

## Serviços principais

```bash
systemctl status pve-cluster
systemctl status corosync
systemctl status pveproxy
systemctl status pvedaemon
systemctl status pvestatd
```

## Tarefas comuns

- verificar estado do cluster;
- ligar, desligar e reiniciar VMs;
- consultar uso de storage;
- validar rede do nó;
- acompanhar logs básicos.

## Regra operacional

O técnico deve evitar mudanças em rede, storage e cluster sem registrar o que foi feito e sem validar o estado do quorum antes e depois.
