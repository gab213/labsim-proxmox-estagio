# Histórico da migração

## Resumo

O cluster Proxmox do LabSim foi migrado fisicamente de um datacenter para outro.

Após a mudança, os IPs de gerenciamento dos nós foram ajustados manualmente para a faixa da VLAN do novo datacenter.

## Endereçamento atual

- pve1: `10.17.5.210/22`
- pve2: `10.17.5.211/22`
- pve3: `10.17.5.212/22`
- pve4: `10.17.5.213/22`

## Cuidados críticos após migração

Sempre revisar em conjunto:

- `/etc/network/interfaces`
- `/etc/hosts`
- `/etc/pve/corosync.conf`

## Validação mínima

- todos os nós respondem a ping;
- `pvecm status` mostra cluster saudável;
- a interface Web em `:8006` abre em cada nó;
- nomes e IPs estão coerentes.

## Registro operacional

Qualquer mudança futura de VLAN, gateway ou IP deve ser registrada neste documento e no changelog do repositório.
