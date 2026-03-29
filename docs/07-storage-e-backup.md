# Storage e backup

## Objetivo

Registrar como o ambiente armazena discos, ISOs, templates e backups, além de definir um mínimo de organização operacional.

## Itens que devem ser acompanhados

- storages locais por nó;
- eventual storage compartilhado;
- espaço livre disponível;
- snapshots em uso;
- discos órfãos;
- localização dos backups.

## Política mínima recomendada

- backup não é a mesma coisa que snapshot;
- snapshots devem ser temporários e justificados;
- backups relevantes devem ter data, destino e responsável;
- testes de restore devem ser feitos periodicamente.

## Rotina básica

```bash
pvesm status
df -h
lsblk
```

## Alerta operacional

Storage cheio, snapshot antigo e disco órfão costumam causar falhas de criação, clone ou boot de VM. Esse ponto deve ser revisado com frequência.
