# Parte 2 - Montagem do Núcleo: estrutura do banco

Banco: `hotel_nebula` (MySQL 8, motor InnoDB, charset utf8mb4).

## Tabelas

| Tabela | Função | Chaves |
|--------|--------|--------|
| `hospede` | Clientes do hotel | PK `id_hospede`; `cpf` e `email` únicos |
| `tipo_quarto` | Categorias de quarto e preço da diária | PK `id_tipo_quarto`; `nome` único |
| `quarto` | Quartos físicos | PK `id_quarto`; FK `id_tipo_quarto`; `numero` único |
| `funcionario` | Profissionais do hotel | PK `id_funcionario`; `cpf` e `email` únicos |
| `reserva` | Reservas de quartos | PK `id_reserva`; FK `id_hospede`, `id_quarto` |
| `hospedagem` | Estadias reais | PK `id_hospedagem`; FK `id_reserva` (única), `id_funcionario` |
| `pagamento` | Pagamentos de uma hospedagem | PK `id_pagamento`; FK `id_hospedagem` |
| `servico` | Catálogo de serviços extras | PK `id_servico`; `nome` único |
| `consumo_servico` | Serviços consumidos em cada hospedagem (tabela associativa) | PK `id_consumo`; FK `id_hospedagem`, `id_servico` |
| `avaliacao` | Nota e comentário da estadia | PK `id_avaliacao`; FK `id_hospedagem` (única) |

## Restrições aplicadas

- **NOT NULL** nos campos obrigatórios e **UNIQUE** em CPF, e-mail, número do quarto e nomes de catálogo.
- **CHECK**: capacidade, preços, valores e quantidades maiores que zero; nota entre 1 e 5; `data_checkout > data_checkin` na reserva; check-out real posterior ao check-in real; data de cancelamento obrigatória somente quando a reserva está `CANCELADA`.
- **ENUM** nos campos com poucas opções fixas (status, forma de pagamento), evitando valores digitados errados.
- **UNIQUE em `hospedagem.id_reserva` e `avaliacao.id_hospedagem`** garante os relacionamentos 1:0..1.

## Tipos de dados

- Dinheiro em `DECIMAL(10,2)` (nunca `FLOAT`, para evitar erro de arredondamento).
- CPF em `CHAR(11)`, datas em `DATE` e momentos exatos (check-in/check-out reais) em `DATETIME`.

## Dados de teste

O script `02_inserir_dados.sql` cria 8 hóspedes, 3 tipos e 10 quartos (1 em manutenção), 4 funcionários, 14 reservas (2 canceladas, 3 futuras ou em curso), 10 hospedagens, 5 serviços, 15 consumos, 11 pagamentos e 9 avaliações.

## Limitação conhecida

A regra "um quarto não pode ter reservas sobrepostas" não é possível só com restrições do MySQL. Ela é conferida pela consulta de disponibilidade e deverá ser validada na futura API antes de gravar uma reserva.
