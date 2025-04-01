-- Transação 1
START TRANSACTION;
-- Bloqueia a conta 1 de modo compartilhado
SELECT saldo FROM contas WHERE id = 1 LOCK IN SHARE MODE;

-- Transação 2
START TRANSACTION;
-- Consegue acessar com sucesso por meio de leitura
SELECT saldo FROM contas WHERE id = 1 LOCK IN SHARE MODE;

-- Transação 1
UPDATE contas SET saldo = saldo - 100 WHERE id = 1;
-- O MySQL converte automaticamente o bloqueio compartilhado 
-- em um bloqueio exclusivo, impedindo que outras transações
-- modifiquem a linha até que esta transação seja finalizada.
COMMIT;

-- Resposta da Equipe 3 para a questão Conversão de Bloqueios de Transações
INSERT INTO Tentativas (equipe_id, questao_id, resposta) VALUES
(3, 6, 
  'Ao executar um comando de atualização (UPDATE), exclusão (DELETE), ou inserção (INSERT) em um registro que já tenha sido bloqueado com LOCK IN SHARE MODE, o MySQL automaticamente converte o bloqueio compartilhado em um exclusivo, sendo transparente ao usuário e ocorrendo de maneira implícita.

  A conversão pode reduzir a concorrência visto que, enquanto a transação com o bloqueio exclusivo está fazendo uma modificação, outras transações são impedidas de acessar ou modificar os dados, o que pode gerar esperas ou deadlocks.
  Ela também pode causar um impacto no desempenho, caso as transações sejam longas e houver muitas contendas entre elas.
  
  Um bloqueio exclusivo garante que uma transação que está atualizando dados não seja interferida por outras transações que poderiam ler ou modificar os mesmos dados simultaneamente, evitando resultados inconsistentes.
  Além disso, se uma transação que detém um bloqueio exclusivo precisar acessar dados que estão bloqueados por outra transação, um deadlock pode ocorrer após a conversão, obrigando o banco de dados a abortar uma das transações.'
);

-- Log do conflito de transações
INSERT INTO Logs_Testes (equipe_id, questao_id, evento) VALUES
(3, 6, 'Equipe 3 implementou testes de conversão de bloqueio.');