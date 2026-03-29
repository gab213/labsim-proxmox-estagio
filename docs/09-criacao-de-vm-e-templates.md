# Criação de VM e templates

## Perfil padrão sugerido

- 4 vCPU
- 16 GB de RAM
- 100 GB de disco
- bridge `vmbr0`
- Ubuntu Server LTS ou Debian

## Fluxo via interface Web

1. acessar o nó;
2. enviar ISO ao storage;
3. clicar em **Create VM**;
4. ajustar CPU, RAM, disco e rede;
5. instalar o sistema operacional;
6. instalar `qemu-guest-agent`;
7. desligar a VM;
8. converter em template.

## Fluxo via CLI

Comandos úteis:

```bash
qm create 9000 --name tmpl-ubuntu-redes-moveis --memory 16384 --cores 4 --net0 virtio,bridge=vmbr0 --agent enabled=1
qm importdisk 9000 /var/lib/vz/template/cache/jammy-server-cloudimg-amd64.img local-lvm
qm set 9000 --scsi0 local-lvm:vm-9000-disk-0 --boot c --bootdisk scsi0
qm resize 9000 scsi0 100G
qm template 9000
```

## Observação

Template bom reduz improviso e acelera a preparação de ambientes para aula e pesquisa.
