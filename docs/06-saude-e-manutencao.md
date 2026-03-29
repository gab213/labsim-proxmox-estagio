# Saúde e manutenção

## Checagem diária

- acessar a UI de pelo menos um nó;
- validar `pvecm status`;
- conferir se todos os nós estão online;
- verificar uso de CPU, RAM e storage;
- observar erros recentes em serviços do Proxmox.

## Checagem semanal

- revisar espaço livre nos storages;
- revisar VMs paradas, órfãs ou sem uso;
- revisar snapshots antigos;
- validar conectividade entre os nós;
- checar atualizações pendentes.

## Checagem mensal

- atualizar inventário do ambiente;
- revisar permissões e contas administrativas;
- validar política de backup;
- registrar manutenção física ou troca de hardware;
- testar um procedimento simples de recuperação.

## Sinais de ambiente saudável

- quorum presente;
- todos os nós online;
- UI acessível;
- serviços `pve-cluster`, `corosync` e `pveproxy` ativos;
- storages montados e com espaço livre aceitável.
