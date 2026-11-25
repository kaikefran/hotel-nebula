# Hotel Nebula - Projeto de Banco de Dados

Projeto de banco de dados relacional (MySQL 8) para organizar reservas, hospedagens,
pagamentos, serviços extras, funcionários e avaliações do Hotel Nebula.
Os dados de exemplo são fictícios.

## Estrutura do repositório

| Pasta | Conteúdo |
|-------|----------|
| `01-origem-do-sistema/` | Modelagem: entidades, relacionamentos, regras de negócio, modelo lógico e diagrama ER |
| `02-montagem-do-nucleo/` | Scripts de criação e de inserção de dados + documentação da estrutura |
| `03-radar-de-comando/` | Consultas SQL de gestão |

## Como executar

Com o MySQL 8 instalado (ou pelo MySQL Workbench, abrindo e executando cada arquivo na ordem):

```bash
mysql -u root -p < 02-montagem-do-nucleo/01_criar_banco.sql
mysql -u root -p < 02-montagem-do-nucleo/02_inserir_dados.sql
mysql -u root -p hotel_nebula < 03-radar-de-comando/consultas.sql
```
