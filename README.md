# LabSim Proxmox Estágio

> Repositório dedicado à implantação, documentação, operação e evolução do **Datacenter didático do LabSim** em **Proxmox VE**, construído a partir da reutilização de quatro workstations do laboratório para fins de ensino, prática, simulação e experimentação em **redes móveis 4G/LTE, 5G e futuras gerações**.

---

## 1. Visão geral

Este projeto nasceu de uma necessidade simples e extremamente prática: o **LabSim** possuía quatro workstations sem uso produtivo, enquanto as disciplinas e atividades de laboratório ligadas a **redes móveis**, **virtualização**, **sistemas distribuídos**, **orquestração** e **infraestrutura** exigiam um ambiente mais flexível, reproduzível e moderno para aulas, testes e pesquisa aplicada.

A proposta, então, foi transformar esse hardware ocioso em um **testbed de virtualização de datacenter**, baseado em **Proxmox VE**, capaz de sustentar a criação de múltiplos ambientes de laboratório sob demanda.

Na prática, isso permite que alunos, monitores e professores possam criar e operar **máquinas virtuais e ambientes isolados**, com liberdade para instalar sistemas operacionais como:

- Ubuntu
- Debian
- Fedora
- CentOS
- AlmaLinux
- e outras distribuições ou sistemas necessários ao experimento

Além disso, o ambiente passa a suportar a instalação e execução de ferramentas e stacks modernas de redes móveis e computação, como:

- **OpenAirInterface (OAI)**
- **UERANSIM**
- **Open5GS**
- **free5GC**
- **srsRAN**
- Docker
- Wireshark / tshark
- Nmap
- Git
- linguagens e pacotes diversos para automação, análise, observabilidade e desenvolvimento

O resultado é um laboratório muito mais útil, vivo e reaproveitável. Em vez de máquinas paradas, o LabSim passa a ter um **datacenter didático virtualizado**, pronto para apoiar aulas, TCCs, pesquisas, provas de conceito e treinamento prático.

---

## 2. Motivação do projeto

A motivação deste projeto pode ser resumida em cinco pontos:

1. **Reaproveitamento de infraestrutura existente**  
   Em vez de depender imediatamente da compra de novos servidores, a iniciativa parte do uso inteligente de recursos já disponíveis no laboratório.

2. **Criação de um ambiente flexível para ensino**  
   Disciplinas de redes móveis e sistemas precisam de um ambiente que permita instalar, remover, quebrar e reconstruir serviços com rapidez. Em laboratório, isso vale ouro.

3. **Padronização e repetibilidade**  
   Com virtualização, templates e documentação, torna-se possível repetir experimentos, criar cenários semelhantes entre turmas e reduzir o “funciona só na máquina de fulano”.

4. **Aproximação entre teoria e prática**  
   Em redes móveis, muita coisa fica abstrata quando o aluno só vê slides. Quando ele sobe um core 5G, gera tráfego, observa interface, captura pacotes e mede comportamento, a curva de aprendizado muda de patamar.

5. **Formação aderente ao mercado e à pesquisa**  
   Virtualização, Linux, redes, containers, automação e observabilidade já fazem parte do mundo real. Trazer isso para o laboratório universitário é preparar melhor o aluno para indústria, pesquisa e pós-graduação.

---

## 3. História do ambiente

O ambiente foi concebido no contexto do estágio e da necessidade de estruturar um espaço de experimentação para o **Laboratório de Comunicações Sem Fio, Simulação e Prototipagem de Sistemas (LabSim)**, vinculado à **Universidade Federal do Rio Grande do Norte (UFRN)**.

A ideia central foi montar um **datacenter em escala de laboratório**, usando quatro máquinas físicas, agrupadas em cluster, para fornecer capacidade de virtualização centralizada.

Em um segundo momento, o cluster foi **migrado fisicamente de um datacenter para outro**, exigindo a adequação à nova VLAN e ao novo plano de endereçamento IP. Essa migração foi feita com **reconfiguração manual dos IPs de cada nó Proxmox**, preservando a lógica do cluster e adequando o ambiente à rede atual do datacenter de destino.

Ou seja: não foi só instalar Proxmox e ligar máquina. Houve também trabalho real de infraestrutura, migração, reorganização de rede e recuperação operacional do ambiente. É exatamente o tipo de experiência que transforma laboratório em plataforma séria.

---

## 4. Objetivo principal

O objetivo deste repositório e do cluster é prover uma base estável para:

- ensino prático em disciplinas de redes móveis;
- criação de ambientes de laboratório sob demanda;
- execução de softwares open source de redes 4G/LTE e 5G;
- testes de core móvel, emulação, tráfego, análise e integração;
- suporte a pesquisa, extensão, TCC e prototipagem;
- treinamento de alunos em administração básica de infraestrutura virtualizada.

---

## 5. Arquitetura atual do cluster

Atualmente o ambiente é composto por **4 nós Proxmox VE**, agrupados em cluster.

### Endereçamento atual dos nós

| Nó | Endereço de gerenciamento | CIDR | Acesso Web |
|---|---:|---:|---|
| `pve1` | `10.17.5.210` | `/22` | `https://10.17.5.210:8006/` |
| `pve2` | `10.17.5.211` | `/22` | `https://10.17.5.211:8006/` |
| `pve3` | `10.17.5.212` | `/22` | `https://10.17.5.212:8006/` |
| `pve4` | `10.17.5.213` | `/22` | `https://10.17.5.213:8006/` |

### Observação importante

Em ambiente Proxmox em cluster, **qualquer um dos nós com interface Web acessível e cluster saudável pode exibir a visão consolidada do Datacenter**.  
Na prática, isso significa que o acesso por qualquer uma das URLs acima pode levar à administração central do cluster, desde que:

- o nó esteja online;
- os serviços do Proxmox estejam saudáveis;
- o cluster tenha quorum;
- a rede entre os membros esteja funcional.

---

## 6. Por que Proxmox VE?

A escolha do **Proxmox VE** faz sentido neste cenário por vários motivos:

- é uma plataforma madura e amplamente usada para virtualização;
- integra **KVM** para VMs e **LXC** para containers;
- oferece interface Web simples para operação didática;
- permite clusterização;
- facilita snapshots, templates, storage e administração de recursos;
- funciona muito bem em ambiente de laboratório e pesquisa;
- reduz barreira de entrada para quem está começando.

Em bom português: ele entrega muita coisa útil sem transformar o laboratório num ritual de sofrimento. E isso ajuda muito quando o foco é ensino.

---

## 7. Ganhos esperados para ensino, prática e pesquisa

A criação deste testbed traz ganhos técnicos e acadêmicos concretos.

### 7.1 Para a disciplina de Redes Móveis / Comunicações Móveis

- criação de ambientes por turma, grupo ou experimento;
- possibilidade de subir elementos de rede reais em software;
- prática com core 4G/5G e componentes associados;
- experimentação com topologias, interfaces e análise de tráfego;
- comparação entre arquiteturas, distribuições Linux e ferramentas.

### 7.2 Para pesquisa e TCC

- base para PoCs com OAI, UERANSIM, Open5GS, free5GC, srsRAN etc.;
- ambiente reconfigurável para artigos, relatórios e testes comparativos;
- facilidade para documentar cenários reproduzíveis;
- maior autonomia para iterar, errar, corrigir e medir.

### 7.3 Para formação técnica do aluno

- contato com virtualização real;
- noções práticas de cluster, storage, rede e isolamento;
- operação de Linux em ambiente de datacenter;
- uso de ferramentas modernas de diagnóstico e automação;
- aproximação com práticas atuais de DevOps, observabilidade e troubleshooting.

---

## 8. Casos de uso previstos

Este ambiente foi pensado para suportar, entre outros, os seguintes cenários:

- criação de VMs Linux para aulas práticas;
- instalação de **OpenAirInterface (OAI)** para experimentos RAN/Core;
- instalação de **UERANSIM** para geração de UE/gNB simulados;
- instalação de **Open5GS** ou **free5GC** para core de rede;
- uso de **Docker** para empacotamento de serviços de laboratório;
- análise de tráfego com **Wireshark**, **tcpdump** e **tshark**;
- testes de conectividade, portas e serviços com **Nmap**;
- uso de **Git** para versionamento de artefatos das disciplinas;
- instalação de stacks complementares de desenvolvimento e automação.

---

## 9. Premissa diretiva do estágio

A linha de trabalho definida para o estágio pode ser resumida da seguinte forma:

### 9.1 Entregas-base

- criação do **Datacenter do LabSim via Proxmox** com 4 servidores;
- priorização de **acesso via rede da UFRN**, sem restrição operacional indevida para o uso acadêmico;
- criação de documentação para administradores e usuários;
- criação de template padrão para disciplina;
- integração das máquinas ao datacenter;
- implantação futura de acesso via VPN;
- uso do ambiente na disciplina de **Comunicações Móveis 2025.2**.

### 9.2 Desdobramentos previstos

1. **Criar tutorial de criação de máquina virtual (administrador)**  
2. **Criar tutorial de uso do datacenter (usuário)**  
3. **Criar template padrão para disciplina**  
   - 4 vCPU  
   - 16 GB de RAM  
   - 100 GB de disco  
4. **Limpar e integrar as máquinas restantes ao Datacenter**  
5. **Instalar acesso via VPN**  
6. **Aplicar o uso do ambiente em Comunicações Móveis 2025.2**

---

## 10. Diretriz de acesso

### Prioridade
O acesso institucional deve privilegiar o uso pela **rede da UFRN**.

### Complemento planejado
Para cenários remotos controlados, está prevista a **implantação de VPN**, permitindo acesso mais seguro e administrável ao ambiente.

Isso ajuda a equilibrar dois objetivos:

- facilitar o uso acadêmico legítimo;
- reduzir exposição desnecessária da camada de administração.

---

## 11. Conceitos básicos do ambiente

Antes de operar o cluster, vale fixar alguns conceitos:

| Conceito | Descrição |
|---|---|
| **Datacenter** | Visão lógica agregada do ambiente no Proxmox |
| **Node** | Cada máquina física membro do cluster (`pve1`, `pve2`, `pve3`, `pve4`) |
| **VM** | Máquina virtual baseada em KVM |
| **CT / LXC** | Container Linux leve, útil em alguns cenários |
| **Template** | VM-base preparada para clonagem rápida |
| **Cluster** | Conjunto de nós Proxmox operando de forma integrada |
| **Quorum** | Estado mínimo de consenso do cluster para operação segura |
| **Storage** | Área onde discos, ISOs, backups e templates ficam armazenados |
| **Bridge** | Interface virtual de rede usada para conectar VMs à rede |

---

## 12. Estrutura operacional desejada

A ideia não é só “ter Proxmox instalado”. A ideia é que o LabSim passe a ter uma estrutura mínima de operação com:

- cluster documentado;
- padrão de criação de VMs;
- convenção de nomes;
- template por disciplina ou caso de uso;
- regras básicas de uso para usuários;
- rastreabilidade de alterações;
- material de apoio para administração.

É o tipo de coisa que evita o clássico laboratório em modo “cada um faz de um jeito e depois ninguém sabe como ficou”.

---

## 13. Arquivos importantes no Proxmox

Os seguintes caminhos são essenciais para administração e troubleshooting:

| Caminho | Finalidade |
|---|---|
| `/etc/network/interfaces` | Configuração de rede do nó |
| `/etc/hosts` | Resolução local de nomes |
| `/etc/pve/corosync.conf` | Configuração do cluster/corosync |
| `/etc/pve/storage.cfg` | Definição dos storages no Proxmox |
| `/etc/pve/qemu-server/` | Configurações das VMs KVM |
| `/etc/pve/lxc/` | Configurações dos containers LXC |
| `/var/log/pve/tasks/` | Histórico de tarefas do Proxmox |
| `/var/log/syslog` | Logs gerais do sistema |
| `/etc/pve/` | Área distribuída de configuração do cluster |

> **Atenção:** alterações em arquivos do cluster devem ser feitas com critério. Mexer sem entender é a rota mais curta para transformar manutenção em arqueologia forense.

---

## 14. Comandos essenciais de administração

Os comandos abaixo ajudam na operação básica do ambiente.

### 14.1 Informações gerais do nó

```bash
pveversion -v
hostname
hostname -I
uptime
```

### 14.2 Estado do cluster

```bash
pvecm status
pvecm nodes
pvesh get /cluster/status
```

### 14.3 Verificar VMs e containers

```bash
qm list
pct list
```

### 14.4 Verificar storage

```bash
pvesm status
df -h
lsblk
```

### 14.5 Verificar rede do nó

```bash
ip -br a
ip route
bridge link
cat /etc/network/interfaces
cat /etc/hosts
```

### 14.6 Verificar serviços principais do Proxmox

```bash
systemctl status pve-cluster
systemctl status corosync
systemctl status pvedaemon
systemctl status pveproxy
systemctl status pvestatd
```

### 14.7 Verificar a porta Web do Proxmox

```bash
ss -tulpn | grep 8006
```

### 14.8 Logs úteis para troubleshooting

```bash
journalctl -u corosync -n 100 --no-pager
journalctl -u pve-cluster -n 100 --no-pager
journalctl -u pveproxy -n 100 --no-pager
journalctl -u pvedaemon -n 100 --no-pager
tail -n 100 /var/log/syslog
```

### 14.9 Consultar configuração de uma VM específica

```bash
qm config 100
```

### 14.10 Iniciar, parar e reiniciar VM

```bash
qm start 100
qm stop 100
qm reboot 100
```

### 14.11 Console de uma VM via shell do host

```bash
qm terminal 100
```

### 14.12 Snapshot de VM

```bash
qm snapshot 100 pre-teste
qm listsnapshot 100
```

> **Boas práticas:** snapshot antes de experimento arriscado é barato. Reconstruir laboratório sem snapshot é esporte radical.

---

## 15. Verificações básicas após migração de rede

Como o cluster foi migrado de datacenter e os IPs foram alterados manualmente, um checklist mínimo de verificação é altamente recomendado:

### 15.1 Confirmar se todos os nós respondem

```bash
ping -c 4 10.17.5.210
ping -c 4 10.17.5.211
ping -c 4 10.17.5.212
ping -c 4 10.17.5.213
```

### 15.2 Confirmar saúde do cluster

```bash
pvecm status
pvecm nodes
```

### 15.3 Confirmar serviços do Proxmox

```bash
systemctl status pve-cluster corosync pveproxy pvedaemon pvestatd
```

### 15.4 Confirmar acesso Web

Abrir no navegador:

- `https://10.17.5.210:8006/`
- `https://10.17.5.211:8006/`
- `https://10.17.5.212:8006/`
- `https://10.17.5.213:8006/`

### 15.5 Confirmar consistência de nomes e IPs

```bash
cat /etc/hosts
hostname
hostname -I
```

### 15.6 Confirmar configuração do cluster

```bash
cat /etc/pve/corosync.conf
```

---

## 16. Tutorial de criação de máquina virtual (administrador)

Abaixo está um fluxo básico para criação de VM no Proxmox.

### 16.1 Pré-requisitos

Antes de criar a VM, o administrador deve garantir:

- acesso ao Proxmox via interface Web;
- imagem ISO disponível;
- storage com espaço suficiente;
- recursos livres de CPU, RAM e disco no nó escolhido;
- padrão de nome e finalidade da VM definidos.

### 16.2 Fluxo básico pela interface Web

1. Acessar um dos nós do cluster:
   - `https://10.17.5.210:8006/`
   - `https://10.17.5.211:8006/`
   - `https://10.17.5.212:8006/`
   - `https://10.17.5.213:8006/`

2. No painel esquerdo, selecionar o **Datacenter** e em seguida o **nó** de destino.

3. Enviar a ISO para o storage apropriado:
   - selecionar `local` ou storage configurado;
   - abrir **ISO Images**;
   - clicar em **Upload**.

4. Clicar em **Create VM**.

5. Preencher os campos principais:
   - **VM ID**
   - **Name**
   - **Node**
   - **ISO image**

6. Definir os recursos da VM:
   - **CPU**
   - **Memory**
   - **Disk**
   - **Network**

7. Finalizar a criação.

8. Ligar a VM.

9. Abrir o console e instalar o sistema operacional desejado.

10. Após instalar o sistema operacional, instalar o agente de integração, quando aplicável.

### 16.3 Recomendação inicial para VMs de disciplina

Para uso em disciplinas e laboratórios de redes móveis, adotar, como padrão inicial:

| Recurso | Valor sugerido |
|---|---|
| vCPU | 4 |
| RAM | 16 GB |
| Disco | 100 GB |
| Rede | bridge padrão do ambiente (`vmbr0`, se esta for a bridge operacional) |
| SO sugerido | Ubuntu Server LTS ou Debian |

---

## 17. Template padrão da disciplina

Um dos objetivos do projeto é criar um template que acelere a criação de ambientes.

### 17.1 Especificação do template

| Item | Valor |
|---|---|
| Perfil | VM padrão para disciplina/laboratório |
| vCPU | 4 |
| RAM | 16 GB |
| Disco | 100 GB |
| Finalidade | laboratório de redes móveis, testes de software e análise |
| Base sugerida | Ubuntu Server LTS ou Debian |

### 17.2 Pacotes recomendados na VM base

Dependendo da disciplina e da política do laboratório, a VM template pode sair com:

```bash
sudo apt-get update
sudo apt-get install -y vim git curl wget net-tools iproute2 tcpdump tshark nmap htop unzip qemu-guest-agent
```

Pacotes que podem ser adicionados conforme a necessidade da disciplina:

- Docker
- Python
- pip
- build-essential
- OpenJDK
- ferramentas de automação
- bibliotecas de redes
- dependências específicas de OAI / UERANSIM / Open5GS / free5GC / srsRAN

### 17.3 Fluxo sugerido para criação do template

1. Criar uma VM base.
2. Instalar o sistema operacional.
3. Atualizar pacotes.
4. Instalar ferramentas base.
5. Ajustar hostname inicial e configurações genéricas.
6. Limpar artefatos desnecessários.
7. Instalar `qemu-guest-agent`.
8. Desligar a VM.
9. Converter a VM em template.

---

## 18. Guia de uso do Datacenter (usuário)

O usuário final não precisa administrar o cluster. Ele precisa saber usar o ambiente sem causar caos operacional.

### 18.1 O que o usuário normalmente fará

- acessar uma VM já disponibilizada;
- usar console Web ou SSH;
- instalar software de laboratório autorizado;
- executar experimentos;
- registrar resultados;
- desligar ou encerrar o uso corretamente.

### 18.2 Boas práticas para o usuário

- não alterar VMs-template;
- não mudar configuração de rede sem autorização;
- não consumir recursos além do necessário;
- não excluir snapshots, discos ou VMs de terceiros;
- registrar o que foi instalado e alterado;
- versionar scripts e artefatos em repositório Git, quando possível.

### 18.3 Fluxo recomendado para o usuário

1. Receber credenciais e orientações do administrador.
2. Acessar a VM designada.
3. Validar conectividade de rede.
4. Atualizar apenas o necessário para o experimento.
5. Instalar ferramentas permitidas.
6. Executar o experimento.
7. Salvar logs, capturas e scripts.
8. Encerrar o ambiente de forma organizada.

---

## 19. Convenções recomendadas

Para manter o ambiente utilizável ao longo do tempo, algumas convenções ajudam bastante.

### 19.1 Nomes de VMs

Padrões sugeridos:

- `cm-2025-2-grupo01-vm01`
- `oai-core-lab01`
- `ueransim-ue01`
- `open5gs-core01`
- `analise-trafego-01`

### 19.2 Organização por finalidade

Separar VMs por tipo:

- ensino
- teste
- pesquisa
- templates
- infraestrutura auxiliar

### 19.3 Documentação mínima por experimento

Cada experimento deveria registrar ao menos:

- objetivo;
- VMs utilizadas;
- software instalado;
- topologia;
- portas/interfaces relevantes;
- passos executados;
- resultados;
- problemas encontrados.

---

## 20. Boas práticas operacionais do administrador

### 20.1 Antes de mudanças sensíveis

- verificar quorum;
- verificar uso de storage;
- verificar uso de RAM/CPU;
- registrar a alteração;
- fazer snapshot quando apropriado.

### 20.2 Antes de manutenção em rede

- revisar `/etc/network/interfaces`;
- revisar `/etc/hosts`;
- revisar `/etc/pve/corosync.conf`;
- confirmar gateway e bridge;
- validar acesso por console local quando possível.

### 20.3 Antes de atualizar o ambiente

- verificar saúde do cluster;
- validar backups/snapshots relevantes;
- executar atualização de forma controlada;
- observar logs após atualização.

---

## 21. Segurança e governança

Mesmo em ambiente didático, segurança não é enfeite.

### Diretrizes recomendadas

- restringir administração à rede institucional e/ou VPN;
- evitar exposição desnecessária da interface de gerenciamento;
- usar credenciais fortes;
- revisar permissões periodicamente;
- manter registro de mudanças relevantes;
- separar uso administrativo de uso discente quando possível.

### Observação

O objetivo do laboratório é ser flexível, mas flexível não significa desorganizado. Em infraestrutura, liberdade sem governança vira incidente com sotaque acadêmico.

---

## 22. Acesso via VPN (planejado)

A implantação de VPN é uma das frentes previstas do projeto.  
Ela é importante para:

- acesso remoto seguro ao ambiente;
- controle mais claro de quem entra;
- redução de exposição direta da administração;
- melhor suporte a atividades fora do espaço físico do laboratório.

Essa etapa deve ser tratada como evolução natural do ambiente.

---

## 23. Exercício do uso do Datacenter na disciplina de Comunicações Móveis 2025.2

Um dos objetivos mais importantes desta iniciativa é que ela não fique só no papel nem só na bancada do administrador.

A ideia é que o cluster seja efetivamente usado como base para atividades da disciplina de **Comunicações Móveis 2025.2**, permitindo que os alunos tenham contato com:

- criação e uso de VMs;
- instalação de sistemas e ferramentas;
- experimentos com core móvel e emulação;
- análise de tráfego;
- troubleshooting;
- documentação de laboratório.

Isso transforma o laboratório em espaço de aprendizagem aplicada e não apenas em local de demonstração passiva.

---

## 24. Roadmap do projeto

### Curto prazo

- consolidar a documentação do ambiente;
- padronizar criação de VMs;
- finalizar material do administrador;
- finalizar material do usuário.

### Médio prazo

- criar template oficial da disciplina;
- organizar convenções de nomenclatura;
- estruturar rotina mínima de operação.

### Longo prazo

- implantar VPN;
- ampliar uso em disciplinas e pesquisas;
- evoluir o cluster como plataforma permanente do LabSim.

---

## 25. Resumo executivo

Este projeto transforma quatro workstations antes subutilizadas em uma **plataforma acadêmica de virtualização**, com valor real para:

- ensino;
- pesquisa;
- extensão;
- formação prática em infraestrutura e redes móveis.

Mais do que “ter um Proxmox rodando”, a proposta é consolidar no LabSim um **testbed de datacenter virtualizado**, útil para experimentação com 4G/LTE, 5G e futuras redes, apoiando a formação de alunos de Engenharia de Telecomunicações da UFRN com uma abordagem prática, moderna e reproduzível.

---

## 26. Autor e contexto acadêmico

Projeto desenvolvido no contexto do estágio de **Gabriel**, aluno concluinte do **Bacharelado em Engenharia de Telecomunicações** na **Universidade Federal do Rio Grande do Norte (UFRN)**, com foco na criação de infraestrutura didática e experimental para o **LabSim**.

---

## 27. Próximos passos para este repositório

Este repositório pode evoluir para armazenar:

- documentação operacional;
- diagramas de rede;
- tutoriais de uso;
- padrões de templates;
- checklists de manutenção;
- scripts auxiliares;
- relatórios de evolução do ambiente.

---

## 28. Licença de uso acadêmico

Definir conforme orientação do laboratório e da universidade.

---

## 29. Referência rápida de acesso

```text
pve1 -> https://10.17.5.210:8006/
pve2 -> https://10.17.5.211:8006/
pve3 -> https://10.17.5.212:8006/
pve4 -> https://10.17.5.213:8006/
```

---

## 30. Mensagem final

Este cluster não é só um conjunto de máquinas virtualizadas.  
Ele representa a criação de uma base prática para aprender fazendo.

Em redes móveis e infraestrutura, isso faz diferença de verdade.
