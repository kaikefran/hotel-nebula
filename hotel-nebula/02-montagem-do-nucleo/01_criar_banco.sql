-- Hotel Nebula - criação do banco e das tabelas (MySQL 8)

DROP DATABASE IF EXISTS hotel_nebula;
CREATE DATABASE hotel_nebula CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE hotel_nebula;

CREATE TABLE hospede (
    id_hospede      INT AUTO_INCREMENT PRIMARY KEY,
    nome            VARCHAR(100) NOT NULL,
    cpf             CHAR(11)     NOT NULL UNIQUE,
    email           VARCHAR(100) NOT NULL UNIQUE,
    telefone        VARCHAR(20),
    data_nascimento DATE         NOT NULL,
    cidade          VARCHAR(60),
    data_cadastro   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tipo_quarto (
    id_tipo_quarto INT AUTO_INCREMENT PRIMARY KEY,
    nome           VARCHAR(30)   NOT NULL UNIQUE,
    descricao      VARCHAR(200),
    capacidade     INT           NOT NULL,
    preco_diaria   DECIMAL(10,2) NOT NULL,
    CONSTRAINT ck_tipo_capacidade CHECK (capacidade > 0),
    CONSTRAINT ck_tipo_preco CHECK (preco_diaria > 0)
);

CREATE TABLE quarto (
    id_quarto      INT AUTO_INCREMENT PRIMARY KEY,
    numero         VARCHAR(5) NOT NULL UNIQUE,
    andar          INT        NOT NULL,
    status         ENUM('ATIVO', 'MANUTENCAO') NOT NULL DEFAULT 'ATIVO',
    id_tipo_quarto INT        NOT NULL,
    CONSTRAINT fk_quarto_tipo FOREIGN KEY (id_tipo_quarto) REFERENCES tipo_quarto (id_tipo_quarto)
);

CREATE TABLE funcionario (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome           VARCHAR(100) NOT NULL,
    cpf            CHAR(11)     NOT NULL UNIQUE,
    cargo          VARCHAR(40)  NOT NULL,
    email          VARCHAR(100) NOT NULL UNIQUE,
    data_admissao  DATE         NOT NULL,
    ativo          BOOLEAN      NOT NULL DEFAULT TRUE
);

CREATE TABLE reserva (
    id_reserva        INT AUTO_INCREMENT PRIMARY KEY,
    id_hospede        INT  NOT NULL,
    id_quarto         INT  NOT NULL,
    data_reserva      DATE NOT NULL,
    data_checkin      DATE NOT NULL,
    data_checkout     DATE NOT NULL,
    status            ENUM('CONFIRMADA', 'CANCELADA', 'CONCLUIDA') NOT NULL DEFAULT 'CONFIRMADA',
    data_cancelamento DATE NULL,
    CONSTRAINT fk_reserva_hospede FOREIGN KEY (id_hospede) REFERENCES hospede (id_hospede),
    CONSTRAINT fk_reserva_quarto  FOREIGN KEY (id_quarto)  REFERENCES quarto (id_quarto),
    CONSTRAINT ck_reserva_datas CHECK (data_checkout > data_checkin),
    CONSTRAINT ck_reserva_cancelamento CHECK (
        (status = 'CANCELADA' AND data_cancelamento IS NOT NULL) OR
        (status <> 'CANCELADA' AND data_cancelamento IS NULL))
);

CREATE TABLE hospedagem (
    id_hospedagem  INT AUTO_INCREMENT PRIMARY KEY,
    id_reserva     INT      NOT NULL UNIQUE,   -- UNIQUE: cada reserva gera no máximo uma hospedagem
    id_funcionario INT      NOT NULL,
    checkin_real   DATETIME NOT NULL,
    checkout_real  DATETIME NULL,
    status         ENUM('EM_ANDAMENTO', 'FINALIZADA') NOT NULL DEFAULT 'EM_ANDAMENTO',
    CONSTRAINT fk_hospedagem_reserva     FOREIGN KEY (id_reserva)     REFERENCES reserva (id_reserva),
    CONSTRAINT fk_hospedagem_funcionario FOREIGN KEY (id_funcionario) REFERENCES funcionario (id_funcionario),
    CONSTRAINT ck_hospedagem_datas CHECK (checkout_real IS NULL OR checkout_real > checkin_real)
);

CREATE TABLE pagamento (
    id_pagamento    INT AUTO_INCREMENT PRIMARY KEY,
    id_hospedagem   INT           NOT NULL,
    valor           DECIMAL(10,2) NOT NULL,
    forma_pagamento ENUM('PIX', 'CARTAO_CREDITO', 'CARTAO_DEBITO', 'DINHEIRO') NOT NULL,
    data_pagamento  DATE          NOT NULL,
    status          ENUM('PAGO', 'PENDENTE', 'ESTORNADO') NOT NULL DEFAULT 'PAGO',
    CONSTRAINT fk_pagamento_hospedagem FOREIGN KEY (id_hospedagem) REFERENCES hospedagem (id_hospedagem),
    CONSTRAINT ck_pagamento_valor CHECK (valor > 0)
);

CREATE TABLE servico (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    nome       VARCHAR(60)   NOT NULL UNIQUE,
    preco      DECIMAL(10,2) NOT NULL,
    CONSTRAINT ck_servico_preco CHECK (preco > 0)
);

CREATE TABLE consumo_servico (
    id_consumo     INT AUTO_INCREMENT PRIMARY KEY,
    id_hospedagem  INT           NOT NULL,
    id_servico     INT           NOT NULL,
    quantidade     INT           NOT NULL,
    valor_unitario DECIMAL(10,2) NOT NULL,   -- preço no dia do consumo
    data_consumo   DATE          NOT NULL,
    CONSTRAINT fk_consumo_hospedagem FOREIGN KEY (id_hospedagem) REFERENCES hospedagem (id_hospedagem),
    CONSTRAINT fk_consumo_servico    FOREIGN KEY (id_servico)    REFERENCES servico (id_servico),
    CONSTRAINT ck_consumo_quantidade CHECK (quantidade > 0),
    CONSTRAINT ck_consumo_valor CHECK (valor_unitario > 0)
);

CREATE TABLE avaliacao (
    id_avaliacao   INT AUTO_INCREMENT PRIMARY KEY,
    id_hospedagem  INT          NOT NULL UNIQUE,   -- uma avaliação por hospedagem
    nota           TINYINT      NOT NULL,
    comentario     VARCHAR(300),
    data_avaliacao DATE         NOT NULL,
    CONSTRAINT fk_avaliacao_hospedagem FOREIGN KEY (id_hospedagem) REFERENCES hospedagem (id_hospedagem),
    CONSTRAINT ck_avaliacao_nota CHECK (nota BETWEEN 1 AND 5)
);
