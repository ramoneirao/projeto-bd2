-- Simulação de Conflito de Transações
-- Transação 1 inicia
START TRANSACTION;
UPDATE Contas SET saldo = saldo - 100 WHERE id = 1;
-- Neste ponto, outra transação tenta acessar o mesmo recurso

-- Transação 2 inicia em paralelo (outra conexão)
START TRANSACTION;
UPDATE Contas SET saldo = saldo - 200 WHERE id = 1;
-- Ambas as transações agora tentam modificar o mesmo registro, causando um conflito

-- Caso 1: Condição de corrida (Race Condition)
-- Se nenhuma trava for aplicada corretamente, pode ocorrer perda de atualização

-- Caso 2: Deadlock
-- Se cada transação segurar um recurso e esperar pelo outro, pode ocorrer um deadlock

-- Resolvendo conflitos com bloqueios
-- Utilizando LOCK para evitar problemas
START TRANSACTION;
SELECT saldo FROM Contas WHERE id = 1 FOR UPDATE;
UPDATE Contas SET saldo = saldo - 100 WHERE id = 1;
COMMIT;

-- Outra tentativa de atualização aguardará até que a primeira finalize
START TRANSACTION;
SELECT saldo FROM Contas WHERE id = 1 FOR UPDATE;
UPDATE Contas SET saldo = saldo - 200 WHERE id = 1;
COMMIT;

-- Resposta da Equipe 3 para a questão Conflito de Transações
INSERT INTO Tentativas (equipe_id, questao_id, resposta, status) VALUES
(3, 3, 'Identificamos três tipos de conflitos possíveis:
1) Perda de Atualização: Quando duas transações alteram o mesmo dado, mas uma delas sobrescreve a outra.
2) Leitura Suja: Quando uma transação lê um dado não confirmado por outra transação, podendo gerar inconsistência.
3) Deadlock: Quando duas transações esperam por um recurso bloqueado pela outra, travando o sistema.', 'CORRETA');

-- Log do conflito de transações
INSERT INTO Logs_Testes (equipe_id, questao_id, evento) VALUES
(3, 3, 'Equipe 3 simulou conflitos de transações, identificando race conditions, dirty reads e deadlocks.');
