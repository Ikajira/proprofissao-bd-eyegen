CREATE DATABASE IF NOT EXISTS eyegen_db;
USE eyegen_db;

CREATE TABLE USUARIO (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome_usuario VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    senha_hash VARCHAR(255) NOT NULL,
    data_nascimento DATE,
    tipo_def_visual ENUM('cegueira_total', 'baixa_visao') NOT NULL,
    cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    ultimo_login DATETIME
);

CREATE TABLE DISPOSITIVO (
    id_dispositivo INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    numero_serie VARCHAR(50) UNIQUE NOT NULL,
    modelo_cor VARCHAR(50) NOT NULL,
    data_ativacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('ativo', 'inativo', 'manutencao') DEFAULT 'ativo',
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE
);

CREATE TABLE ASSINATURA (
    id_assinatura INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    plano ENUM('origin', 'infinity', 'guardian') NOT NULL,
    valor_mensal DECIMAL(10,2) NOT NULL,
    data_inicio DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_vencimento DATETIME NOT NULL,
    status ENUM('ativa', 'cancelada', 'suspensa') DEFAULT 'ativa',
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE
);

CREATE TABLE PEDIDO (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,
    status_pedido ENUM('pendente', 'pago', 'enviado', 'entregue', 'cancelado') DEFAULT 'pendente',
    data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    metodo_pagamento ENUM('cartao', 'pix', 'boleto') NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE
);

CREATE TABLE ITEM_PEDIDO (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_dispositivo INT NULL, -- Pode ser NULL se for compra de assinatura apenas
    tipo_item ENUM('dispositivo', 'assinatura') NOT NULL,
    quantidade INT DEFAULT 1,
    preco_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES PEDIDO(id_pedido) ON DELETE CASCADE,
    FOREIGN KEY (id_dispositivo) REFERENCES DISPOSITIVO(id_dispositivo)
);

CREATE TABLE MANUTENCAO (
    id_manutencao INT AUTO_INCREMENT PRIMARY KEY,
    id_dispositivo INT NOT NULL,
    tipo_manutencao ENUM('preventiva', 'corretiva', 'atualizacao') NOT NULL,
    descricao_problema TEXT,
    data_solicitacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    status_manutencao ENUM('aberta', 'em_andamento', 'concluida', 'cancelada') DEFAULT 'aberta',
    FOREIGN KEY (id_dispositivo) REFERENCES DISPOSITIVO(id_dispositivo) ON DELETE CASCADE
);

CREATE INDEX idx_usuario_email ON USUARIO(email);
CREATE INDEX idx_dispositivo_usuario ON DISPOSITIVO(id_usuario);
CREATE INDEX idx_assinatura_usuario ON ASSINATURA(id_usuario);
CREATE INDEX idx_assinatura_status ON ASSINATURA(status);
CREATE INDEX idx_pedido_usuario ON PEDIDO(id_usuario);
CREATE INDEX idx_pedido_status ON PEDIDO(status_pedido);
CREATE INDEX idx_item_pedido ON ITEM_PEDIDO(id_pedido);
CREATE INDEX idx_manutencao_dispositivo ON MANUTENCAO(id_dispositivo);
CREATE INDEX idx_manutencao_status ON MANUTENCAO(status_manutencao);

INSERT INTO USUARIO (nome_usuario, email, senha_hash, data_nascimento, tipo_def_visual) VALUES
('Yasmin Silva', 'yasmin@email.com', '$2y$10$ExampleHash', '1992-05-15', 'cegueira_total'),
('Carlos Oliveira', 'carlos@email.com', '$2y$10$ExampleHash', '1985-08-22', 'baixa_visao');

INSERT INTO DISPOSITIVO (id_usuario, numero_serie, modelo_cor) VALUES
(1, 'EYG2024001', 'Preto Standard'),
(2, 'EYG2024002', 'Azul Pro');

INSERT INTO ASSINATURA (id_usuario, plano, valor_mensal, data_vencimento) VALUES
(1, 'guardian', 60.00, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 30 DAY)),
(2, 'infinity', 30.00, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 30 DAY));

INSERT INTO PEDIDO (id_usuario, valor_total, status_pedido, metodo_pagamento) VALUES
(1, 3060.00, 'entregue', 'pix'),
(2, 3030.00, 'pago', 'cartao');

INSERT INTO ITEM_PEDIDO (id_pedido, id_dispositivo, tipo_item, quantidade, preco_unitario) VALUES
(1, 1, 'dispositivo', 1, 3000.00),
(1, NULL, 'assinatura', 12, 60.00),
(2, 2, 'dispositivo', 1, 3000.00),
(2, NULL, 'assinatura', 12, 30.00);