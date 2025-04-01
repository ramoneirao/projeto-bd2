-- Escalonamento Serial: Execução de transações de forma sequencial
START TRANSACTION;
UPDATE Contas SET saldo = saldo - 100 WHERE id = 1;
UPDATE Contas SET saldo = saldo + 100 WHERE id = 2;
COMMIT;

START TRANSACTION;
UPDATE Contas SET saldo = saldo - 50 WHERE id = 2;
UPDATE Contas SET saldo = saldo + 50 WHERE id = 3;
COMMIT;

-- Escalonamento Equivalente a Serial: Execução concorrente, mas mantendo a mesma ordem lógica
START TRANSACTION;
UPDATE Contas SET saldo = saldo - 100 WHERE id = 1;
-- Outra transação concorrente iniciada antes do commit
START TRANSACTION;
UPDATE Contas SET saldo = saldo - 50 WHERE id = 2;
UPDATE Contas SET saldo = saldo + 50 WHERE id = 3;
COMMIT;
UPDATE Contas SET saldo = saldo + 100 WHERE id = 2;
COMMIT;

-- Resposta da Equipe 3 para a questão 2 (Escalonamento Serial vs. Equivalente a Serial)
INSERT INTO Tentativas (equipe_id, questao_id, resposta, status) VALUES
(3, 2, 'Executamos dois tipos de escalonamento:
1) Escalonamento Serial: As transações são executadas uma após a outra, garantindo que cada uma seja completamente finalizada antes da próxima começar. Isso evita concorrência, mas pode reduzir a eficiência.
2) Escalonamento Equivalente a Serial: As transações são executadas de forma concorrente, mas a ordem final dos commits mantém um resultado equivalente ao de uma execução serial. Isso melhora o desempenho sem comprometer a consistência.', 
'PENDENTE');

-- Log da execução de escalonamentos na questão 2
INSERT INTO Logs_Testes (equipe_id, questao_id, evento) VALUES
(3, 2, 'Equipe 3 executou e verificou escalonamento serial e equivalente a serial. Ordem dos commits foi analisada.');

