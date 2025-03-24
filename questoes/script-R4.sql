-- Criando a tabela para simular os dados A e B
CREATE TABLE IF NOT EXISTS Dados (
    id INT PRIMARY KEY,
    A DECIMAL(10,2),
    B DECIMAL(10,2)
);

-- Inserindo valores iniciais em A e B
INSERT INTO Dados (id, A, B) VALUES (1, 100.00, 50.00);

-- Iniciando a transação T1
START TRANSACTION;

-- T1: R(A), W(A), R(B), W(B)
-- T1 lê A e atualiza A
UPDATE Dados SET A = A - 10 WHERE id = 1;

-- T1 lê B
SELECT B FROM Dados WHERE id = 1;

-- T1 escreve B
UPDATE Dados SET B = B + 20 WHERE id = 1;

-- Commit de T1
COMMIT;

-- Iniciando a transação T2
START TRANSACTION;

-- T2: R(B), W(B), R(A), W(A)
-- T2 lê B
SELECT B FROM Dados WHERE id = 1;

-- T2 escreve B
UPDATE Dados SET B = B - 10 WHERE id = 1;

-- T2 lê A
SELECT A FROM Dados WHERE id = 1;

-- T2 escreve A
UPDATE Dados SET A = A + 5 WHERE id = 1;

-- Commit de T2
COMMIT;

-- Verificando os valores de A e B após as transações
SELECT * FROM Dados WHERE id = 1;

-- Resposta da Equipe 3 para a questão 4 (Seriabilidade de Escalonamento de Transações)
INSERT INTO Tentativas (equipe_id, questao_id, resposta, status) VALUES
(3, 4, 'O escalonamento das transações T1 e T2 não é serializável. 
1) Ambas as transações tentam modificar os mesmos dados (`A` e `B`), gerando dependências cruzadas.
2) O grafo de precedência mostra que há um ciclo de dependências entre as transações, o que impede a serialização do escalonamento.
3) O resultado final de `A = 95` e `B = 60` não pode ser reordenado para um escalonamento serial sem inconsistências.', 
'CORRETA');

-- Log de uma transação realizada na questão 4 (Seriabilidade de Escalonamento de Transações)
INSERT INTO Logs_Testes (equipe_id, questao_id, evento) VALUES
(3, 4, 'Equipe 3 analisou o escalonamento das transações T1 e T2 e determinou que não é serializável.');

