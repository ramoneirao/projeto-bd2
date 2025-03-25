-- Transação 1
START TRANSACTION;

-- Ler o saldo da conta 1
SELECT Saldo FROM Contas WHERE Id = 1;

-- A transação está "segurando" a leitura do saldo da conta

-- Tentar atualizar o saldo
UPDATE Contas SET Saldo = Saldo + 100 WHERE Id = 1;

SELECT FROM SLEEP(5);

COMMIT;

-- Transação 2
START TRANSACTION;

-- Tentar ler o saldo da conta 1
SELECT Saldo FROM Contas WHERE Id = 1;

SELECT FROM SLEEP(5);

-- Tentar atualizar o saldo
UPDATE contas SET saldo = saldo + 50 WHERE id = 1;

COMMIT;

-- Cadastro de resposta
-- -----------------------------------------------------------------------------
-- Como o controle de concorrência multiversão (MVCC) melhora o desempenho do
-- banco de dados em relação a técnicas baseadas em bloqueios? Quais são as
-- vantagens e desvantagens desse método? Observar como o banco de dados 
-- gerencia múltiplas versões de um mesmo dado.
INSERT INTO Tentativas (equipe_id, questao_id, resposta) VALUES
(
  3,
  10,
  'No MVCC, ao invés de bloquear uma linha de dados durante uma transação (como 
  ocorre nas técnicas tradicionais de bloqueio), o banco de dados mantém 
  múltiplas versões de uma mesma linha. Cada versão de dados é associada a um 
  timestamp ou a um ID de transação. Quando uma transação lê dados, ela acessa a
  versão mais recente dos dados que não tenha sido modificada por transações 
  posteriores a ela. Quando uma transação modifica dados, o banco cria uma nova
  versão da linha, marcando a versão anterior como obsoleta, mas ainda 
  disponível para transações que começaram antes da modificação.
  O MVCC faz com que as transações de leitura não se bloqueiem entre si, o que 
  pode melhorar o desempenho em ambientes com muitas leituras e poucas 
  gravações, além de fazer com que o banco de dados possa processar mais 
  transações sem esperar que outras transações sejam finalizadas. Outra vantagem
  é que como não há bloqueios explícitos para leituras e os dados podem ser 
  acessados sem aguardar a liberação de locks, o risco de deadlocks é reduzido.
  Como desvantagens, pode haver um aumento no uso de armazenamento, visto que o
  MVCC mantém várias versões de dados. Dependendo da frequência de atualizações,
  o banco pode acabar acumulando muitas versões obsoletas de dados, o que exige
  um processo de limpeza para liberar espaço. O banco também precisa implementar
  bem o mecanismo de limpeza (garbage collection) das versões antigas para não 
  sobrecarregar o sistema.'
);
