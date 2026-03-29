# Inventário do ambiente

## Nós do cluster

| Nó | IP de gerenciamento | CIDR | Acesso Web | Papel |
|---|---|---|---|---|
| pve1 | 10.17.5.210 | /22 | https://10.17.5.210:8006/ | nó Proxmox do cluster |
| pve2 | 10.17.5.211 | /22 | https://10.17.5.211:8006/ | nó Proxmox do cluster |
| pve3 | 10.17.5.212 | /22 | https://10.17.5.212:8006/ | nó Proxmox do cluster |
| pve4 | 10.17.5.213 | /22 | https://10.17.5.213:8006/ | nó Proxmox do cluster |

## Campos para levantamento local

Os itens abaixo devem ser preenchidos pelo técnico sempre que houver inventário físico ou troca de hardware:

- modelo da workstation;
- quantidade de CPU e RAM por nó;
- discos instalados em cada nó;
- interface física principal;
- bridge em uso no cluster;
- storages locais e compartilhados;
- observações sobre saúde do hardware.

## Inventário mínimo recomendado

Cada nó deve ter registro próprio contendo:

- hostname;
- IP atual;
- gateway;
- versão do Proxmox;
- status do cluster;
- storages disponíveis;
- VMs hospedadas;
- data da última verificação.
