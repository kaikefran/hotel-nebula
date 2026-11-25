-- Hotel Nebula - dados iniciais para teste (todos fictícios)
USE hotel_nebula;

INSERT INTO hospede (id_hospede, nome, cpf, email, telefone, data_nascimento, cidade) VALUES
(1, 'Ana Beatriz Lima',    '10000000001', 'ana.lima@email.com',     '11990000001', '1990-03-14', 'São Paulo'),
(2, 'Bruno Carvalho',      '10000000002', 'bruno.c@email.com',      '11990000002', '1985-07-22', 'Osasco'),
(3, 'Carla Souza',         '10000000003', 'carla.souza@email.com',  '19990000003', '1992-11-05', 'Campinas'),
(4, 'Diego Martins',       '10000000004', 'diego.m@email.com',      '21990000004', '1979-01-30', 'Rio de Janeiro'),
(5, 'Elisa Fernandes',     '10000000005', 'elisa.f@email.com',      '41990000005', '1995-09-18', 'Curitiba'),
(6, 'Felipe Ramos',        '10000000006', 'felipe.r@email.com',     '31990000006', '1988-05-09', 'Belo Horizonte'),
(7, 'Gabriela Torres',     '10000000007', 'gabi.t@email.com',       '13990000007', '2000-12-25', 'Santos'),
(8, 'Henrique Alves',      '10000000008', 'henrique.a@email.com',   '71990000008', '1983-08-12', 'Salvador');

INSERT INTO tipo_quarto (id_tipo_quarto, nome, descricao, capacidade, preco_diaria) VALUES
(1, 'Standard',  'Quarto simples com cama de casal',   2, 250.00),
(2, 'Executivo', 'Quarto com escritório e frigobar',   3, 340.00),
(3, 'Luxo',      'Suíte ampla com varanda e banheira', 4, 450.00);

INSERT INTO quarto (id_quarto, numero, andar, status, id_tipo_quarto) VALUES
(1, '101', 1, 'ATIVO',      1),
(2, '102', 1, 'ATIVO',      1),
(3, '103', 1, 'ATIVO',      1),
(4, '201', 2, 'ATIVO',      2),
(5, '202', 2, 'ATIVO',      2),
(6, '203', 2, 'ATIVO',      2),
(7, '301', 3, 'ATIVO',      3),
(8, '302', 3, 'ATIVO',      3),
(9, '303', 3, 'ATIVO',      3),
(10,'104', 1, 'MANUTENCAO', 1);

INSERT INTO funcionario (id_funcionario, nome, cpf, cargo, email, data_admissao, ativo) VALUES
(1, 'Marta Oliveira',  '20000000001', 'Recepcionista', 'marta@nebula.com',   '2023-02-01', TRUE),
(2, 'Rafael Gomes',    '20000000002', 'Recepcionista', 'rafael@nebula.com',  '2024-05-15', TRUE),
(3, 'Paulo Nogueira',  '20000000003', 'Gerente',       'paulo@nebula.com',   '2021-08-10', TRUE),
(4, 'Juliana Prado',   '20000000004', 'Recepcionista', 'juliana@nebula.com', '2025-01-20', TRUE);

INSERT INTO reserva (id_reserva, id_hospede, id_quarto, data_reserva, data_checkin, data_checkout, status, data_cancelamento) VALUES
(1,  1, 1, '2026-06-01', '2026-06-10', '2026-06-13', 'CONCLUIDA', NULL),
(2,  2, 3, '2026-06-05', '2026-06-15', '2026-06-18', 'CONCLUIDA', NULL),
(3,  1, 2, '2026-07-01', '2026-07-10', '2026-07-12', 'CONCLUIDA', NULL),
(4,  3, 5, '2026-07-02', '2026-07-20', '2026-07-25', 'CONCLUIDA', NULL),
(5,  4, 4, '2026-08-01', '2026-08-05', '2026-08-08', 'CANCELADA', '2026-08-02'),
(6,  2, 6, '2026-08-10', '2026-08-20', '2026-08-23', 'CONCLUIDA', NULL),
(7,  5, 1, '2026-09-01', '2026-09-10', '2026-09-14', 'CONCLUIDA', NULL),
(8,  1, 7, '2026-09-05', '2026-09-18', '2026-09-20', 'CONCLUIDA', NULL),
(9,  6, 3, '2026-10-01', '2026-10-12', '2026-10-15', 'CANCELADA', '2026-10-08'),
(10, 3, 8, '2026-10-05', '2026-10-20', '2026-10-24', 'CONCLUIDA', NULL),
(11, 7, 2, '2026-10-20', '2026-11-02', '2026-11-05', 'CONCLUIDA', NULL),
(12, 4, 5, '2026-11-01', '2026-11-20', '2026-11-26', 'CONFIRMADA', NULL),
(13, 8, 4, '2026-11-10', '2026-12-05', '2026-12-08', 'CONFIRMADA', NULL),
(14, 2, 9, '2026-11-15', '2026-12-20', '2026-12-27', 'CONFIRMADA', NULL);

-- hospedagens: só as reservas que foram usadas (não canceladas e já iniciadas)
INSERT INTO hospedagem (id_hospedagem, id_reserva, id_funcionario, checkin_real, checkout_real, status) VALUES
(1,  1,  1, '2026-06-10 14:10:00', '2026-06-13 11:30:00', 'FINALIZADA'),
(2,  2,  2, '2026-06-15 15:00:00', '2026-06-18 11:00:00', 'FINALIZADA'),
(3,  3,  1, '2026-07-10 14:30:00', '2026-07-12 10:45:00', 'FINALIZADA'),
(4,  4,  4, '2026-07-20 16:00:00', '2026-07-25 11:15:00', 'FINALIZADA'),
(5,  6,  2, '2026-08-20 14:00:00', '2026-08-23 11:50:00', 'FINALIZADA'),
(6,  7,  1, '2026-09-10 13:40:00', '2026-09-14 10:30:00', 'FINALIZADA'),
(7,  8,  4, '2026-09-18 15:20:00', '2026-09-20 11:00:00', 'FINALIZADA'),
(8,  10, 2, '2026-10-20 14:45:00', '2026-10-24 12:00:00', 'FINALIZADA'),
(9,  11, 1, '2026-11-02 14:00:00', '2026-11-05 11:10:00', 'FINALIZADA'),
(10, 12, 4, '2026-11-20 15:30:00', NULL,                  'EM_ANDAMENTO');

INSERT INTO servico (id_servico, nome, preco) VALUES
(1, 'Café da manhã',        45.00),
(2, 'Lavanderia',           60.00),
(3, 'Spa',                 180.00),
(4, 'Transfer aeroporto',  120.00),
(5, 'Room service',         75.00);

INSERT INTO consumo_servico (id_consumo, id_hospedagem, id_servico, quantidade, valor_unitario, data_consumo) VALUES
(1,  1, 1, 3,  45.00, '2026-06-11'),
(2,  1, 5, 1,  75.00, '2026-06-12'),
(3,  2, 2, 2,  60.00, '2026-06-16'),
(4,  3, 1, 2,  45.00, '2026-07-11'),
(5,  4, 3, 1, 180.00, '2026-07-22'),
(6,  4, 4, 2, 120.00, '2026-07-20'),
(7,  5, 1, 3,  45.00, '2026-08-21'),
(8,  6, 2, 1,  60.00, '2026-09-12'),
(9,  6, 5, 2,  75.00, '2026-09-11'),
(10, 7, 3, 2, 180.00, '2026-09-19'),
(11, 7, 1, 2,  45.00, '2026-09-19'),
(12, 8, 4, 1, 120.00, '2026-10-20'),
(13, 8, 1, 4,  45.00, '2026-10-22'),
(14, 9, 5, 1,  75.00, '2026-11-03'),
(15, 10, 1, 3, 45.00, '2026-11-22');

INSERT INTO pagamento (id_pagamento, id_hospedagem, valor, forma_pagamento, data_pagamento, status) VALUES
(1,  1,  960.00, 'CARTAO_CREDITO', '2026-06-13', 'PAGO'),
(2,  2,  870.00, 'PIX',            '2026-06-18', 'PAGO'),
(3,  3,  590.00, 'DINHEIRO',       '2026-07-12', 'PAGO'),
(4,  4, 1000.00, 'CARTAO_CREDITO', '2026-07-25', 'PAGO'),
(5,  4, 1120.00, 'PIX',            '2026-07-25', 'PAGO'),
(6,  5, 1155.00, 'CARTAO_DEBITO',  '2026-08-23', 'PAGO'),
(7,  6, 1210.00, 'PIX',            '2026-09-14', 'PAGO'),
(8,  7, 1350.00, 'CARTAO_CREDITO', '2026-09-20', 'PAGO'),
(9,  8, 2100.00, 'CARTAO_CREDITO', '2026-10-24', 'PAGO'),
(10, 9,  825.00, 'PIX',            '2026-11-05', 'PAGO'),
(11, 10, 500.00, 'PIX',            '2026-11-20', 'PAGO');

INSERT INTO avaliacao (id_avaliacao, id_hospedagem, nota, comentario, data_avaliacao) VALUES
(1, 1, 5, 'Quarto limpo e atendimento excelente.',            '2026-06-14'),
(2, 2, 4, 'Boa estadia, só o café poderia ser mais variado.', '2026-06-19'),
(3, 3, 3, 'Quarto um pouco barulhento.',                      '2026-07-13'),
(4, 4, 5, 'Suíte incrível e spa maravilhoso.',                '2026-07-26'),
(5, 5, 4, 'Ótimo custo-benefício.',                           '2026-08-24'),
(6, 6, 5, 'Voltarei com certeza!',                            '2026-09-15'),
(7, 7, 4, 'Banheira ótima, wi-fi instável.',                  '2026-09-21'),
(8, 8, 2, 'Ar-condicionado com defeito durante a estadia.',   '2026-10-25'),
(9, 9, 5, 'Equipe muito atenciosa.',                          '2026-11-06');
