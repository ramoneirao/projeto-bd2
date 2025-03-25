-- Transação 1 (executada timestamp anterior)
START TRANSACTION;
SELECT * FROM Cliente WHERE Id = 2 FOR UPDATE;  -- Bloqueio exclusivo
SELECT FROM SLEEP(5);
UPDATE Cliente SET Endereco = 'Rua D, 111' WHERE Id = 2;
COMMIT;

-- Transação 2 (executada com timestamp posterior)
START TRANSACTION;
SELECT * FROM Cliente WHERE Id = 2 FOR UPDATE;  -- Tentativa de bloqueio
SELECT FROM SLEEP(5);
UPDATE Cliente SET Endereco = 'Rua E, 999' WHERE Id = 2;
COMMIT;

-- Cadastro de resposta

INSERT INTO Tentativas (equipe_id, questao_id, resposta) VALUES
(3, 9, 'Os protocolos baseados em timestamps garantem a serializabilidade por meio da imposição de uma ordem temporal na execução das transações. Cada transação recebe um timestamp único no momento em que é iniciada, e as operações de leitura e escrita de cada transação são controladas com base nesses timestamps. A ideia é garantir que as transações sejam executadas de maneira que os efeitos de suas operações possam ser reordenados de forma que o sistema se comporte como se fosse executado de maneira serial (sem concorrência).
Cada transação recebe um timestamp único no momento em que é iniciada. Daí, uma transação pode ler um dado X apenas se seu timestamp for anterior ao timestamp da transação que escreve em X, assim como uma transação pode apenas escrever em X se seu timestamp for posterior ao timestamp da transação que já tenha escrito em X. Isso ajuda a prevenir inconsistências de leitura (ler valores desatualizados) e/ou violação de serializabilidade (evitar que as operações sejam executadas de forma desordenada).
Os timestamps mais antigos são associados a transações que foram iniciadas primeiro, tendo mais prioridade sobre transações mais recentes. Quando uma transação mais antiga tenta acessar um dado que foi escrito por uma transação mais recente, essa operação é bloqueada, pois a transação mais nova pode ter modificado um dado que a transação antiga ainda não viu.');
