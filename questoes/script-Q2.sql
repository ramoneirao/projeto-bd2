-- Criando tabelas do banco
CREATE TABLE IF NOT EXISTS Clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) UNIQUE NOT NULL, -- CPF padronizado sem formatação
    data_nascimento DATE NOT NULL,
    endereco TEXT
);

CREATE TABLE IF NOT EXISTS Agencias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    endereco TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS Contas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    agencia_id INT NOT NULL,
    tipo ENUM('CORRENTE', 'POUPANCA') NOT NULL, -- ENUM otimiza o CHECK
    saldo DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    status ENUM('ATIVA', 'BLOQUEADA', 'ENCERRADA') DEFAULT 'ATIVA',
    FOREIGN KEY (cliente_id) REFERENCES Clientes(id) ON DELETE CASCADE,
    FOREIGN KEY (agencia_id) REFERENCES Agencias(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Transacoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    conta_origem INT NOT NULL,
    conta_destino INT DEFAULT NULL,
    tipo ENUM('DEPOSITO', 'SAQUE', 'TRANSFERENCIA', 'PAGAMENTO') NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    data_transacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('PENDENTE', 'CONFIRMADA', 'CANCELADA') DEFAULT 'PENDENTE',
    FOREIGN KEY (conta_origem) REFERENCES Contas(id) ON DELETE CASCADE,
    FOREIGN KEY (conta_destino) REFERENCES Contas(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Logs_Transacoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    transacao_id INT NOT NULL,
    evento VARCHAR(255) NOT NULL,
    data_evento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (transacao_id) REFERENCES Transacoes(id) ON DELETE CASCADE
);

-- Populando tabelas
INSERT INTO Clientes (nome, cpf, data_nascimento, endereco) VALUES
('Alice Silva', '11122233344', '1985-07-15', 'Rua A, 123'),
('Bruno Costa', '22233344455', '1990-08-20', 'Rua B, 456'),
('Carla Souza', '33344455566', '1995-09-25', 'Rua C, 789');

INSERT INTO Agencias (nome, endereco) VALUES
('Agência Centro', 'Av. Principal, 1000'),
('Agência Sul', 'Rua Secundária, 200');

INSERT INTO Contas (cliente_id, agencia_id, tipo) VALUES
(1, 1, 'CORRENTE'),
(2, 1, 'POUPANCA'),
(3, 2, 'CORRENTE');

-- Criando índices para otimização
CREATE INDEX idx_cliente ON Contas (cliente_id);
CREATE INDEX idx_conta_origem ON Transacoes (conta_origem);
CREATE INDEX idx_conta_destino ON Transacoes (conta_destino);