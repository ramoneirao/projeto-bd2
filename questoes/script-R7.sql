-- Transação 1
START TRANSACTION;

-- Adquirindo bloqueio exclusivo (FOR UPDATE) na linha com id = 1 (conta bancária 1)
SELECT saldo FROM contas WHERE id = 1 FOR UPDATE;

-- Adquirindo bloqueio exclusivo (FOR UPDATE) na linha com id = 2 (conta bancária 2)
SELECT saldo FROM contas WHERE id = 2 FOR UPDATE;

-- Realizando a atualização de saldo para a conta com id = 1
UPDATE contas SET saldo = saldo - 100 WHERE id = 1;

-- Realizando a atualização de saldo para a conta com id = 2
UPDATE contas SET saldo = saldo - 50 WHERE id = 2;

-- Liberando os bloqueios e finalizando a transação com COMMIT
COMMIT;

-------------

-- Resposta da Equipe 3 para a questão Bloqueios em Duas Fases (Two-Phase Locking - 2PL)
INSERT INTO Tentativas (equipe_id, questao_id, resposta) VALUES
(3, 7, 
  'O 2PL é baseado em duas fases principais.
  Na fase de crescimento, uma transação pode adquirir bloqueios em dados, mas não pode liberá-los. Uma transação pode continuar a adquirir bloqueios durante esta fase, o que permite que ela leia ou escreva dados, terminando quando a transação decide liberar o primeiro bloqueio.
  Na fase de liberação, uma transação não pode mais adquirir novos bloqueios. Ela só pode liberar bloqueios que tenha adquirido durante a fase de crescimento, devendo completar a execução sem voltar a adquirir bloqueios.
  
  O 2PL impede que as transações adquiram bloqueios e façam modificações de forma desordenada, garantindo que, ao final, a ordem dos acessos aos dados seja consistente e respeite uma sequência de operações válida (sem violação de consistência).
  
  O 2PL pode reduzir a concorrência em sistemas com muitas transações simultâneas, visto que como as transações não podem adquirir novos bloqueios depois de começar a liberar os antigos, o SGBD pode acabar ficando menos eficiente, já que as transações ficam "presas" esperando bloqueios serem liberados.'
);

-- Log do conflito de transações
INSERT INTO Logs_Testes (equipe_id, questao_id, evento) VALUES
(3, 7, 'Equipe 3 implementou testes de bloqueios em duas fases.');