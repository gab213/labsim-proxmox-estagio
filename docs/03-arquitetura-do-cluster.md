# Arquitetura do cluster

## Visão geral

O ambiente é composto por quatro nós Proxmox VE agrupados em cluster.

## Elementos principais

- nós `pve1`, `pve2`, `pve3` e `pve4`;
- interface Web do Proxmox na porta `8006`;
- comunicação interna de cluster via corosync e quorum;
- VMs e containers hospedando workloads didáticos.

## Endereçamento atual

- pve1: `10.17.5.210/22`
- pve2: `10.17.5.211/22`
- pve3: `10.17.5.212/22`
- pve4: `10.17.5.213/22`

## Lógica operacional

- qualquer nó saudável pode apresentar a visão do Datacenter;
- a saúde do cluster depende de conectividade entre nós;
- alterações de IP exigem revisão de rede, hosts e corosync;
- a operação do usuário final ocorre dentro das VMs, não na camada administrativa do cluster.
