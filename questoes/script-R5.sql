-- BLOQUEIO EXCLUSIVO

-- Transação 1
START TRANSACTION;
-- Por causa do `FOR UPDATE`, nenhuma outra transação pode modificar esse
-- saldo até que esta transação faça o COMMIT ou ROLLBACK.
SELECT Saldo FROM Contas WHERE Id = 1 FOR UPDATE;
UPDATE Contas SET Saldo = Saldo - 100 WHERE Id = 1;
COMMIT;

-- Transação 2
START TRANSACTION;
-- Esta transação precisa esperar até que a transação 1 seja concluída 
-- (persistida ou abortada) até que possa realizar o `SELECT` com sucesso.
SELECT Saldo FROM Contas WHERE id = 1 FOR UPDATE;
UPDATE Contas SET Saldo = Saldo - 50 WHERE Id = 1;
COMMIT;

-- BLOQUEIO COMPARTILHADO

-- Transação 1
START TRANSACTION;
-- Por causa do `LOCK IN SHARE MODE`, outras transações podem ler a 
-- conta, mas não podem modificar o saldo até que esta transação seja finalizada.
SELECT saldo FROM contas WHERE id = 1 LOCK IN SHARE MODE;
COMMIT;

-- Transação 2
START TRANSACTION;
SELECT saldo FROM contas WHERE id = 1 LOCK IN SHARE MODE;
COMMIT;

-- Resposta da Equipe 3 para a questão Técnicas de Bloqueio de Transações
INSERT INTO Tentativas (equipe_id, questao_id, resposta) VALUES
(3, 5, 
  'Um bloqueio exclusivo (X) impede que outras transações acessem ou modifiquem o dado bloqueado até que o bloqueio seja liberado, utilizado quando uma transação deseja modificar um dado e garantir que nenhuma outra transação possa alterá-lo ou lê-lo enquanto este está sendo alterado.
  Um bloqueio compartilhado (S) permite que múltiplas transações leiam o dado, mas impede que qualquer transação modifique o dado até que o bloqueio seja liberado.
  
  Um bloqueio exclusivo garante que uma transação que está atualizando dados não seja interferida por outras transações que poderiam ler ou modificar os mesmos dados simultaneamente, evitando resultados inconsistentes.
  Além disso, os bloqueios ajudam a evitar que uma transação receba dados inválidos devido a alterações feitas por outra transação.'
);

-- Log do conflito de transações
INSERT INTO Logs_Testes (equipe_id, questao_id, evento) VALUES
(3, 5, 'Equipe 3 implementou bloqueios exclusivos e compartilhados.');