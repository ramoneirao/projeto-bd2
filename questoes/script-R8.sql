-- T1.sql: tenta transferir da conta 1 para a conta 2
START TRANSACTION;

-- Bloqueia a conta 1
UPDATE Contas SET Saldo = Saldo - 100 WHERE Id = 1; 

-- Simula um atraso para que a transação 2 tenha tempo de bloquear a conta 2
SELECT SLEEP(5);

-- Tenta bloquear a conta 2 (que pode estar bloqueada pela transação 2)
UPDATE Contas SET Saldo = Saldo + 100 WHERE Id = 2;  

COMMIT;

-- T2.sql: tenta transferir da conta 2 para a conta 1
START TRANSACTION;

-- Bloqueia a conta 2
UPDATE Contas SET Saldo = Saldo - 100 WHERE Id = 2;  

-- Simula um atraso para que a transação 1 tenha tempo de bloquear a conta 1
SELECT SLEEP(5); 

-- Tenta bloquear a conta 1 (que pode estar bloqueada pela transação 1)
UPDATE Contas SET Saldo = Saldo + 100 WHERE Id = 1;

COMMIT;

-- Cadastro de resposta

INSERT INTO Tentativas (equipe_id, questao_id, resposta) VALUES
(3, 8, 'O deadlock ocorre quando duas ou mais transações ficam bloqueadas indefinidamente, onde uma transação espera por um recurso que está sendo mantido por outra transação, e nenhuma das transações pode continuar, pois estão esperando a outra liberar esses recursos.
Já o starvation ocorre quando uma transação não consegue obter os recursos necessários para ser executada por um longo período de tempo, devido à priorização constante de outras transações.
Para resolver um deadlock, o SGBD detecta quando ele ocorre por meio de grafos e tenta resolvê-lo, identificando o ciclo de dependências e abortando uma das transações envolvidas para liberar seus recursos. Uma forma de prevenção é impor que as transações adquiram recursos em uma ordem predefinida, evitando esses ciclos.
Para resolver um starvation, o SGBD aumenta a prioridade de transações que estão esperando por muito tempo, garantindo que elas sejam eventualmente executadas mesmo que outras transações tenham maior prioridade inicialmente. Uma forma de prevenção é implementar algoritmos de escalonamento justos, como Round-Robin, onde todas as transações recebem uma fatia de tempo igual para execução, evitando que transações fiquem bloqueadas por um período muito longo.
Ao executar a transação 1 e em seguida a transação 2, a transação 1 foi finalizada com sucesso, enquanto a transação 2 exibiu a mensagem de erro "ERROR 1213 (40001) at line 11: Deadlock found when trying to get lock; try restarting transaction". Neste caso, percebe-se que o MySQL detectou o deadlock na transação 2 e conseguiu abortá-la, sem afetar a transação 1.');
