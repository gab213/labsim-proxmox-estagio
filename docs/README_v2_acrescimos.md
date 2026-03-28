## 31. Diagrama lógico do cluster

O diagrama abaixo resume a visão lógica do ambiente, considerando o **cluster Proxmox**, o **acesso pela rede da UFRN**, a futura **VPN** e os **workloads acadêmicos** usados em redes móveis.

```text
+---------------------------------------------------------------+
|                 Rede da UFRN / usuários autorizados           |
|         professores | alunos | monitores | administradores    |
+------------------------------+--------------------------------+
                               |
                               | HTTPS 8006 / SSH 22
                               v
+-----------------------------------------------------------------------+
|                   Datacenter didático LabSim - Proxmox VE             |
|                    VLAN do datacenter / rede 10.17.4.0/22             |
+------------------------+------------------------+----------------------+
                         |                        |
                         v                        v
        +-----------------------------+   +-----------------------------+
        | pve1 - 10.17.5.210/22       |   | pve2 - 10.17.5.211/22       |
        | UI: https://10.17.5.210:8006|   | UI: https://10.17.5.211:8006|
        | KVM / LXC / storage local   |   | KVM / LXC / storage local   |
        +-----------------------------+   +-----------------------------+
                         |                        |
                         +-----------+------------+
                                     |
                                     | cluster / corosync / quorum
                                     |
                         +-----------+------------+
                         |                        |
                         v                        v
        +-----------------------------+   +-----------------------------+
        | pve3 - 10.17.5.212/22       |   | pve4 - 10.17.5.213/22       |
        | UI: https://10.17.5.212:8006|   | UI: https://10.17.5.213:8006|
        | KVM / LXC / storage local   |   | KVM / LXC / storage local   |
        +-----------------------------+   +-----------------------------+
                                     |
                                     v
+-----------------------------------------------------------------------+
|                     Workloads acadêmicos e de pesquisa                |
| Ubuntu | Debian | AlmaLinux | Fedora | CentOS                         |
| OAI | UERANSIM | Open5GS | free5GC | srsRAN                           |
| Docker | Wireshark | Nmap | Git | Python | automação                  |
+-----------------------------------------------------------------------+
                                     |
                                     v
+-----------------------------------------------------------------------+
|                  Acesso remoto seguro (planejado)                     |
|                 VPN institucional / WireGuard / OpenVPN               |
+-----------------------------------------------------------------------+
```

### 31.1 Leitura do diagrama

- **Camada de acesso:** usuários entram preferencialmente pela rede da UFRN.
- **Camada de gerenciamento:** os quatro nós compõem o Datacenter Proxmox e expõem a interface Web na porta `8006`.
- **Camada de cluster:** os nós trocam informações de quorum e estado do ambiente.
- **Camada de workloads:** VMs e containers hospedam os cenários das disciplinas, pesquisas e testes.
- **Camada de acesso remoto planejado:** a VPN entra como evolução para acesso externo controlado.

Esse desenho deixa claro que o cluster não foi pensado só para “subir VM”, mas para servir como **plataforma didática reproduzível** para ensino, laboratório e pesquisa em telecomunicações.

---

## 32. Seção de VPN: proposta de evolução do acesso

A VPN é a etapa natural de maturidade do ambiente. Hoje, a prioridade é o acesso pela **rede institucional da UFRN**. O próximo passo lógico é permitir **acesso remoto controlado**, principalmente para:

- professores;
- monitores;
- pesquisadores;
- alunos autorizados em atividades específicas.

### 32.1 Por que implantar VPN

A VPN resolve vários problemas de uma vez:

- reduz a exposição direta da interface administrativa do Proxmox;
- permite acesso remoto com autenticação controlada;
- facilita uso fora do horário físico do laboratório;
- viabiliza manutenção e experimentos remotos;
- separa acesso público de acesso administrativo.

### 32.2 Modelo recomendado

O desenho mais prudente para este ambiente é:

1. manter a interface do Proxmox restrita à rede da UFRN e/ou à faixa da VPN;
2. subir uma VM ou appliance dedicada à VPN;
3. publicar apenas o serviço de VPN, e não a UI do Proxmox diretamente;
4. anunciar rota para alcançar os nós `10.17.5.210` a `10.17.5.213`;
5. manter registro claro de usuários autorizados.

### 32.3 Tecnologias candidatas

- **WireGuard:** simples, moderno, rápido e ótimo para operação enxuta;
- **OpenVPN:** tradicional e amplamente compatível;
- **Tailscale/Headscale:** interessantes se a política institucional permitir;
- **IPsec:** válido, mas normalmente mais burocrático em ambiente pequeno.

Para um laboratório universitário, **WireGuard** tende a ser o melhor equilíbrio entre simplicidade, desempenho e manutenção.

### 32.4 Topologia sugerida da VPN

```text
[ usuário remoto autorizado ]
             |
             | túnel VPN
             v
[ VM/servidor VPN do LabSim ]
             |
             | rota liberada
             v
[ VLAN / rede do datacenter Proxmox ]
   |-> pve1 10.17.5.210
   |-> pve2 10.17.5.211
   |-> pve3 10.17.5.212
   `-> pve4 10.17.5.213
```

### 32.5 Regras mínimas de segurança

- não expor a porta `8006` diretamente na internet;
- usar autenticação individual por usuário;
- revogar acesso quando o vínculo acabar;
- limitar quem pode acessar a camada administrativa;
- documentar sub-redes, portas, chaves e responsáveis.

---

## 33. Criação de template de VM via UI e via CLI

Template é o que transforma “criação manual repetitiva” em **laboratório reproduzível**. Sem template, cada VM começa quase do zero. Com template, a disciplina ganha velocidade, padrão e menos improviso.

### 33.1 Perfil recomendado do template

| Item | Valor recomendado |
|---|---|
| Nome | `tmpl-ubuntu-redes-moveis` |
| vCPU | 4 |
| RAM | 16 GB |
| Disco | 100 GB |
| Rede | `vmbr0` |
| SO base | Ubuntu Server LTS |
| Finalidade | aulas, práticas, laboratório de redes móveis |

### 33.2 Criação via interface Web (UI)

Fluxo recomendado:

1. acessar um dos nós do cluster;
2. enviar a ISO desejada para o storage;
3. clicar em **Create VM**;
4. definir um `VM ID`, por exemplo `9000`;
5. usar nome como `tmpl-ubuntu-redes-moveis`;
6. ajustar CPU, RAM, disco e bridge;
7. instalar o sistema operacional;
8. instalar pacotes-base e `qemu-guest-agent`;
9. desligar a VM;
10. clicar com o botão direito e usar **Convert to template**.

Pacotes-base sugeridos no guest Ubuntu/Debian:

```bash
sudo apt-get update
sudo apt-get install -y vim git curl wget net-tools iproute2 tcpdump tshark nmap htop unzip qemu-guest-agent ca-certificates
sudo systemctl enable qemu-guest-agent
sudo systemctl start qemu-guest-agent
```

### 33.3 Criação via CLI do Proxmox

Exemplo prático usando o shell do nó Proxmox.

Premissas do exemplo:

- VMID: `9000`
- bridge: `vmbr0`
- storage: `local-lvm`
- imagem cloud Ubuntu em `/var/lib/vz/template/cache/jammy-server-cloudimg-amd64.img`

#### 33.3.1 Baixar a imagem cloud

```bash
cd /var/lib/vz/template/cache
wget -O /var/lib/vz/template/cache/jammy-server-cloudimg-amd64.img https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img
```

#### 33.3.2 Criar a VM base

```bash
qm create 9000 \
  --name tmpl-ubuntu-redes-moveis \
  --memory 16384 \
  --cores 4 \
  --cpu host \
  --net0 virtio,bridge=vmbr0 \
  --agent enabled=1
```

#### 33.3.3 Importar o disco para o storage

```bash
qm importdisk 9000 /var/lib/vz/template/cache/jammy-server-cloudimg-amd64.img local-lvm
```

#### 33.3.4 Ajustar controladora, disco e cloud-init

```bash
qm set 9000 --scsihw virtio-scsi-pci
qm set 9000 --scsi0 local-lvm:vm-9000-disk-0
qm set 9000 --ide2 local-lvm:cloudinit
qm set 9000 --boot c --bootdisk scsi0
qm set 9000 --serial0 socket --vga serial0
```

#### 33.3.5 Redimensionar o disco para 100 GB

```bash
qm resize 9000 scsi0 100G
```

#### 33.3.6 Definir usuário, rede e chave SSH inicial

```bash
qm set 9000 --ciuser labsim
qm set 9000 --ipconfig0 ip=dhcp
qm set 9000 --sshkeys /root/.ssh/authorized_keys
```

> Se `/root/.ssh/authorized_keys` não existir no nó Proxmox, crie antes ou ajuste para o caminho correto.

#### 33.3.7 Converter em template

```bash
qm template 9000
```

### 33.4 Clonar o template para uma nova VM

```bash
qm clone 9000 110 --name cm-2025-2-grupo01-vm01 --full true
qm set 110 --memory 16384 --cores 4
qm start 110
```

### 33.5 Quando usar UI e quando usar CLI

| Método | Melhor uso |
|---|---|
| **UI** | ensino, operação visual, treinamento inicial |
| **CLI** | padronização, automação, repetibilidade, troubleshooting |

A regra prática é simples: **a UI ensina; a CLI escala**.

---

## 34. Troubleshooting comum no Proxmox

Abaixo está um bloco direto ao ponto com problemas recorrentes e como investigar.

### 34.1 A interface Web na porta 8006 não abre

Verificações:

```bash
ss -tulpn | grep 8006
systemctl status pveproxy
journalctl -u pveproxy -n 100 --no-pager
curl -k https://127.0.0.1:8006/
```

Possíveis causas:

- `pveproxy` parado;
- firewall ou ACL na rede;
- IP incorreto no nó;
- problema de DNS/hosts;
- serviço do cluster degradado.

### 34.2 O cluster aparece sem quorum

Verificações:

```bash
pvecm status
pvecm nodes
systemctl status corosync
journalctl -u corosync -n 100 --no-pager
cat /etc/pve/corosync.conf
```

Possíveis causas:

- falha de conectividade entre nós;
- IP antigo persistindo em configuração;
- hostname inconsistente;
- link de rede intermitente;
- muitos nós fora do ar ao mesmo tempo.

Depois de migração de datacenter, o primeiro suspeito quase sempre é rede ou inconsistência de IP/hostname.

### 34.3 Um nó está online no sistema, mas offline no Datacenter

```bash
hostname
hostname -I
cat /etc/hosts
ip -br a
ip route
systemctl status pve-cluster corosync
```

Revisar:

- se o hostname bate com o esperado;
- se o IP é o IP novo da VLAN atual;
- se `/etc/hosts` ainda tem entradas antigas;
- se `corosync.conf` ainda aponta para rede anterior.

### 34.4 Alterei o IP do nó e depois começaram erros estranhos

```bash
cat /etc/network/interfaces
cat /etc/hosts
cat /etc/pve/corosync.conf
ping -c 4 10.17.5.210
ping -c 4 10.17.5.211
ping -c 4 10.17.5.212
ping -c 4 10.17.5.213
```

Sempre validar o trio:

- rede do sistema;
- resolução local de nomes;
- configuração distribuída do cluster.

### 34.5 A VM foi criada, mas não tem rede

No host Proxmox:

```bash
qm config 110
bridge link
ip -br a
cat /etc/network/interfaces
```

No guest Linux:

```bash
ip -br a
ip route
ping -c 4 8.8.8.8
ping -c 4 1.1.1.1
```

Possíveis causas:

- bridge errada;
- interface virtual não conectada;
- DHCP indisponível;
- configuração estática errada;
- VLAN não entregue como esperado.

### 34.6 O storage está cheio e a criação de VM falha

```bash
pvesm status
df -h
lsblk
```

Ações comuns:

- remover ISOs antigas;
- apagar snapshots obsoletos;
- revisar discos órfãos;
- mover VMs para outro storage;
- evitar criar VM grande sem checar capacidade.

### 34.7 A VM está lenta ou travando

```bash
uptime
free -h
top
qm list
```

Verificação detalhada:

```bash
pvesh get /nodes/$(hostname)/status
```

Possíveis causas:

- oversubscription de RAM/CPU;
- storage saturado;
- disputa de recursos com outras VMs;
- guest mal configurado;
- carga pesada do laboratório.

### 34.8 O clone do template sobe, mas não aplica rede ou usuário esperado

```bash
qm config 9000
qm config 110
```

Revisar:

- disco `cloudinit` presente;
- parâmetros `--ciuser`, `--ipconfig0` e `--sshkeys`;
- compatibilidade da imagem cloud;
- necessidade de regenerar config cloud-init do clone.

### 34.9 O agente da VM não funciona

No host:

```bash
qm config 110 | grep agent
```

Na VM:

```bash
sudo systemctl status qemu-guest-agent
```

Correção comum:

```bash
sudo apt-get update
sudo apt-get install -y qemu-guest-agent
sudo systemctl enable qemu-guest-agent
sudo systemctl start qemu-guest-agent
```

### 34.10 Checklist rápido de sanidade do cluster

Quando bater dúvida, rode primeiro:

```bash
pveversion -v
pvecm status
pvecm nodes
qm list
pct list
pvesm status
ip -br a
ip route
systemctl status pve-cluster corosync pveproxy pvedaemon pvestatd
```

Esse bloco não resolve tudo, mas separa rápido se o problema está em rede, cluster, storage, serviço ou VM.

---

## 35. Fechamento da versão 2 do README

Com estas adições, o repositório passa a ter uma documentação mais completa para uso real do cluster do LabSim, cobrindo:

- narrativa e propósito do projeto;
- arquitetura lógica do ambiente;
- proposta de acesso por VPN;
- criação de templates via interface e via CLI;
- troubleshooting básico e recorrente.

Isso deixa o material mais útil não só para leitura institucional, mas para a operação prática do dia a dia.
