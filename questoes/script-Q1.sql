-- Criando o banco de dados do projeto
CREATE DATABASE IF NOT EXISTS ProjetoBD;
USE ProjetoBD;

-- Tabela de alunos
CREATE TABLE IF NOT EXISTS Alunos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    matricula VARCHAR(20) UNIQUE NOT NULL
);

-- Tabela de equipes (até 3 integrantes por equipe)
CREATE TABLE IF NOT EXISTS Equipes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

-- Relacionamento entre Alunos e Equipes (máximo de 3 integrantes por equipe)
CREATE TABLE IF NOT EXISTS Equipe_Alunos (
    equipe_id INT NOT NULL,
    aluno_id INT NOT NULL,
    PRIMARY KEY (equipe_id, aluno_id),
    FOREIGN KEY (equipe_id) REFERENCES Equipes(id) ON DELETE CASCADE,
    FOREIGN KEY (aluno_id) REFERENCES Alunos(id) ON DELETE CASCADE
);

-- Tabela das questões do projeto
CREATE TABLE IF NOT EXISTS Questoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    descricao TEXT NOT NULL
);

-- Populando a tabela com as 10 questões do projeto
INSERT INTO Questoes (titulo, descricao) VALUES
('Estados e Propriedades das Transações (ACID)', 'Verifique a atomicidade e a consistência de uma transação.'),
('Tipos de Escalonamento de Transações', 'Teste a execução concorrente de transações e analise a ordem dos commits.'),
('Conflito de Transações', 'Simule duas transações concorrentes e observe os conflitos gerados.'),
('Seriabilidade de Escalonamento', 'Analise um escalonamento e verifique se ele é serializável.'),
('Técnicas de Bloqueio de Transações', 'Teste locks em registros para evitar acessos simultâneos indesejados.'),
('Conversão de Bloqueios', 'Verifique a conversão de bloqueios compartilhados para exclusivos.'),
('Bloqueios em Duas Fases (2PL)', 'Observe como funciona a fase de crescimento e liberação de bloqueios.'),
('Deadlock e Starvation', 'Crie um deadlock intencional entre duas transações e veja como o banco reage.'),
('Protocolos Baseados em Timestamps', 'Teste a execução de transações usando timestamps para escalonamento.'),
('Protocolos Multiversão (MVCC)', 'Verifique como o banco gerencia múltiplas versões de um mesmo dado.');

-- Tabela de tentativas de respostas dos alunos
CREATE TABLE IF NOT EXISTS Tentativas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    equipe_id INT NOT NULL,
    questao_id INT NOT NULL,
    resposta TEXT NOT NULL,
    data_envio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('CORRETA', 'INCORRETA', 'PENDENTE') DEFAULT 'PENDENTE',
    FOREIGN KEY (equipe_id) REFERENCES Equipes(id) ON DELETE CASCADE,
    FOREIGN KEY (questao_id) REFERENCES Questoes(id) ON DELETE CASCADE
);

-- Tabela para logs das transações realizadas nos testes das questões
CREATE TABLE IF NOT EXISTS Logs_Testes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    equipe_id INT NOT NULL,
    questao_id INT NOT NULL,
    evento VARCHAR(255) NOT NULL,
    data_evento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (equipe_id) REFERENCES Equipes(id) ON DELETE CASCADE,
    FOREIGN KEY (questao_id) REFERENCES Questoes(id) ON DELETE CASCADE
);

-- Inserir alunos
INSERT INTO Alunos (nome, email, matricula) VALUES
('Raphael Pinho', 'raphael@email.com', '20241001'),
('Guilherme Leite', 'guilherme@email.com', '20241002'),
('Christian de Jesus', 'christian@email.com', '20241003'),
('Andreya Paiva', 'andreya@email.com', '20241004'),
('Luan Farias', 'luan@email.com', '20241005'),
('Heloisa Silva', 'heloisa@email.com', '20241006'),
('Enzo Santos', 'enzo@email.com', '20241007'),
('Jesse Barros', 'jesse@email.com', '20241008'),
('Ramon Mendes', 'ramon@email.com', '20241009'),
('Lucas Ferreira', 'lucas@email.com', '20241010'),
('Lucas Moreno', 'lucas_moreno@email.com', '20241011'),
('Luis Carlos', 'luis@email.com', '20241012'),
('Marcos Thiago S. Horsford', 'marcos@email.com', '20241013'),
('José Lucas S. Cantão', 'jose@email.com', '20241014'),
('Luan Souza', 'luan_souza@email.com', '20241015');

-- Criar equipes
INSERT INTO Equipes (nome) VALUES
('Equipe 1'), ('Equipe 2'), ('Equipe 3'),
('Equipe 4'), ('Equipe 5'), ('Equipe 6');

-- Equipes
INSERT INTO Equipe_Alunos (equipe_id, aluno_id) VALUES
(1, 1), (1, 2), (1, 3),
(2, 4), (2, 5), (2, 6),
(3, 7), (3, 8), (3, 9),
(4, 10), (4, 11), (4, 12),
(5, 13),
(6, 14), (6, 15);