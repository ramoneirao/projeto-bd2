START TRANSACTION;

INSERT INTO Alunos (nome, email, matricula) VALUES 
('João Pedro', 'joao@email.com', '20241016');

INSERT INTO Equipes (nome) VALUES ('Equipe Gama');

-- Associando João Pedro à Equipe Gama
INSERT INTO Equipe_Alunos (equipe_id, aluno_id) 
VALUES ((SELECT id FROM Equipes WHERE nome='Equipe Gama'), 
        (SELECT id FROM Alunos WHERE email='joao@email.com'));

COMMIT;

START TRANSACTION;

INSERT INTO Alunos (nome, email, matricula) VALUES 
('Maria Clara', 'maria@email.com', '20241017');

-- Forçando um erro: Tentando associar Maria a uma equipe que não existe
INSERT INTO Equipe_Alunos (equipe_id, aluno_id) 
VALUES (9999, (SELECT id FROM Alunos WHERE email='maria@email.com'));

-- O erro acontece aqui e a transação é revertida
ROLLBACK;

-- Consultando para conferir 
SELECT * FROM Alunos;

-- Resposta da Equipe 3 para a questão 1 (ACID)
INSERT INTO Tentativas (equipe_id, questao_id, resposta, status) VALUES
(3, 1, 'Executamos duas transações: 
1) Uma com COMMIT bem-sucedido, garantindo a atomicidade e consistência. 
2) Uma com erro forçado, resultando em ROLLBACK, provando que dados inconsistentes não foram salvos.
Transação com COMMIT bem-sucedido: 
        Iniciou no estado Active, onde realizou suas operações. 
        Ao finalizar todas as operações, entrou no estado Partially Committed. 
        Com o COMMIT bem-sucedido, atingiu o estado Committed, garantindo que todas as mudanças foram permanentemente aplicadas ao banco de dados. 
Transação com erro forçado e ROLLBACK: 
        Começou no estado Active, executando operações. 
        Quando ocorreu o erro, entrou no estado Failed, indicando que não poderia prosseguir. 
        Com a execução do ROLLBACK, retornou ao estado Aborted, assegurando que nenhuma alteração parcial fosse salva, preservando a integridade dos dados.', 
'PENDENTE');

-- Log de uma transação realizada na questão 1 (ACID)
INSERT INTO Logs_Testes (equipe_id, questao_id, evento) VALUES
(3, 1, 'Equipe 3 executou transação ACID e verificou rollback.');
