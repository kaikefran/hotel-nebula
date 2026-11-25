-- Hotel Nebula - consultas de gestão
USE hotel_nebula;

-- 1) Quartos disponíveis em determinado período
--    (sem reserva não cancelada que se sobreponha às datas e que não esteja em manutenção)
SET @inicio = '2026-12-01';
SET @fim    = '2026-12-10';

SELECT q.numero, t.nome AS tipo, t.preco_diaria
FROM quarto q
JOIN tipo_quarto t ON t.id_tipo_quarto = q.id_tipo_quarto
WHERE q.status = 'ATIVO'
  AND NOT EXISTS (
        SELECT 1
        FROM reserva r
        WHERE r.id_quarto = q.id_quarto
          AND r.status <> 'CANCELADA'
          AND r.data_checkin < @fim
          AND r.data_checkout > @inicio)
ORDER BY q.numero;

-- 2) Hóspedes que mais realizaram reservas
SELECT h.nome,
       COUNT(r.id_reserva)         AS total_reservas,
       SUM(r.status = 'CANCELADA') AS canceladas
FROM hospede h
JOIN reserva r ON r.id_hospede = h.id_hospede
GROUP BY h.id_hospede, h.nome
ORDER BY total_reservas DESC, h.nome;

-- 3) Faturamento por mês (somente pagamentos efetivamente pagos)
SELECT DATE_FORMAT(data_pagamento, '%Y-%m') AS mes,
       SUM(valor)                           AS faturamento
FROM pagamento
WHERE status = 'PAGO'
GROUP BY DATE_FORMAT(data_pagamento, '%Y-%m')
ORDER BY mes;

-- 4) Serviços extras mais consumidos
SELECT s.nome,
       SUM(c.quantidade)                    AS quantidade_total,
       SUM(c.quantidade * c.valor_unitario) AS receita
FROM servico s
JOIN consumo_servico c ON c.id_servico = s.id_servico
GROUP BY s.id_servico, s.nome
ORDER BY quantidade_total DESC;

-- 5) Quartos que receberam as melhores avaliações
SELECT q.numero,
       t.nome                AS tipo,
       ROUND(AVG(a.nota), 2) AS nota_media,
       COUNT(a.id_avaliacao) AS qtd_avaliacoes
FROM avaliacao a
JOIN hospedagem hp ON hp.id_hospedagem = a.id_hospedagem
JOIN reserva r     ON r.id_reserva = hp.id_reserva
JOIN quarto q      ON q.id_quarto = r.id_quarto
JOIN tipo_quarto t ON t.id_tipo_quarto = q.id_tipo_quarto
GROUP BY q.id_quarto, q.numero, t.nome
ORDER BY nota_media DESC, qtd_avaliacoes DESC;

-- 6) Reservas canceladas
SELECT r.id_reserva, h.nome AS hospede, q.numero AS quarto,
       r.data_checkin, r.data_checkout, r.data_cancelamento
FROM reserva r
JOIN hospede h ON h.id_hospede = r.id_hospede
JOIN quarto q  ON q.id_quarto = r.id_quarto
WHERE r.status = 'CANCELADA'
ORDER BY r.data_cancelamento;

-- 7) Quantidade de hospedagens atendidas por profissional
SELECT f.nome, f.cargo, COUNT(hp.id_hospedagem) AS hospedagens_atendidas
FROM funcionario f
LEFT JOIN hospedagem hp ON hp.id_funcionario = f.id_funcionario
GROUP BY f.id_funcionario, f.nome, f.cargo
ORDER BY hospedagens_atendidas DESC, f.nome;
