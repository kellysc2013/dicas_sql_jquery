/**
*DESCOMENTE O COMANDO ABAIXO SOMENTE SE DESEJAR EXCLUIR A TABELA tb_ordem_servico 
*/
/*DROP TABLE IF EXISTS tb_ordem_servico;*/ 

/**
*Criar a tabela tb_ordem_servico. 
*/
CREATE TABLE tb_ordem_servico
(
  cod_ordem integer,
  cod_servico character varying(1),
  data_inicial date,
  data_final date
);

/**
*Incluir os dados na tabela tb_ordem_servico 
*/
INSERT INTO tb_ordem_servico(cod_ordem, cod_servico, data_inicial, data_final) 
VALUES
(34330, 'A', '2013-11-10', '2013-11-12'),
(34331, 'A', '2013-12-06', '2013-12-08'),
(34332, 'A', '2013-01-05', '2014-01-06'),
(34333, 'A', '2014-01-30', NULL),  
(34334, 'B', '2013-11-15', '2013-11-17'),
(34335, 'B', '2013-12-18', '2013-12-19'),
(34336, 'B', '2013-01-05', '2014-01-06'),
(34337, 'B', '2014-01-28', NULL),
(34338, 'C', '2013-11-08', '2013-11-11'),
(34339, 'C', '2013-12-05', '2013-12-08'),
(34340, 'C', '2013-01-15', '2014-01-17'),
(34341, 'C', '2014-01-27', NULL);  

/**
*Exibir os dados da tabela tb_ordem_servico 
*/
SELECT * FROM tb_ordem_servico;

/**
*1º EXEMPLO
*/

/**
*Exibe a quantidade de registros da tabela tb_ordem_servico
*/
SELECT COUNT(*) FROM tb_ordem_servico;

/**
*Criação do alias quantidade
*/
SELECT COUNT(*) AS quatidade FROM tb_ordem_servico;

/**
*2º EXEMPLO
*/

/**
*Exibir a quantidade de registros onde o código do serviço seja do tipo "A".
*/
SELECT 
COUNT(cod_servico) AS quantidade
FROM tb_ordem_servico
WHERE cod_servico = 'A';

/**
*3º EXEMPLO
*/

/**
*Exibir a quantidade de ordens de serviços que já foram finalizadas. 
**/
SELECT 
COUNT(data_final) AS quantidade
FROM tb_ordem_servico;

/**
*4º EXEMPLO
*/

/**
*Exibir a quantidade de ordens de serviços que não foram finalizadas.
*/
SELECT 
COUNT(*) AS quantidade
FROM tb_ordem_servico WHERE data_final IS NULL;

/**
*5º Exemplo
*/

/**
*Distribuição por tipo de serviço:
*Quantidade de solicitações para o serviço "A";
*Quantidade de solicitações para o serviço "B";
*Quantidade de solicitações para o serviço "C";
*/

SELECT
cod_servico,
COUNT(cod_servico) AS quantidade
FROM tb_ordem_servico 
GROUP BY cod_servico;

/**
*6º Exemplo
*/

/**
*Quantidade de ordens finalizadas por mês e ano (mm/aaaa).
*Quando utilizamos a função COUNT(nome_da_coluna), valores nulos não entram na contagem, 
*/
SELECT
CASE WHEN data_final IS NOT NULL
    THEN  date_format(data_final, '%m/%Y')
END mes_ano,
COUNT(data_final) AS qtd_os
FROM tb_ordem_servico
GROUP BY mes_ano;

/**
*Quantidade de ordens finalizadas por mês e ano (mm/aaaa).
*Quando utilizamos a função COUNT(*), valores nulos entram na contagem, 
*/
SELECT
date_format(data_final, '%m/%Y') AS mes_ano,
COUNT(*) AS qtd_os
FROM tb_ordem_servico
GROUP BY date_format(data_final, '%m/%Y');

/**
*Podemos colocar a mensagem "Pendente" para indicar a quantidade de ordens de serviço 
*que não possuem data de encerramento.
*/
SELECT
CASE WHEN data_final IS NOT NULL
    THEN  date_format(data_final, '%m/%Y')
    ELSE 'Pendente'
END mes_ano,
COUNT(*) AS qtd_os
FROM tb_ordem_servico
GROUP BY mes_ano;

/**
*Para não exibir a contagem de valores nulos, utilizamos um filtro no "WHERE":
*/
SELECT
date_format(data_final, '%m/%Y') AS mes_ano,
COUNT(data_final) AS qtd_os
FROM tb_ordem_servico
WHERE data_final IS NOT NULL
GROUP BY mes_ano;

/**
*Para ordenar por ano/mês em ordem crescente utilize o comando "ORDER BY".
*/
SELECT
date_format(data_final, '%m/%Y') AS mes_ano,
COUNT(*) AS qtd_os_finalizadas
FROM tb_ordem_servico
WHERE data_final IS NOT NULL
GROUP BY date_format(data_final, '%m/%Y')
ORDER BY date_format(data_final, '%Y/%m');

/**
*7º Exemplo
*/

/**
*Quantidade de ordens finalizadas por mês e ano (mm/aaaa) e por tipo de serviço.
*/
SELECT
date_format(data_final, '%m/%Y') AS mes_ano, 
cod_servico,
COUNT(*) AS qtd_os
FROM tb_ordem_servico
WHERE data_final IS NOT NULL
GROUP BY mes_ano, cod_servico;

/**
*Ordenar em crescente o ano/mês e o serviço
*/
SELECT
date_format(data_final, '%m/%Y') AS mes_ano,
cod_servico,
COUNT(*) AS qtd_os_finalizadas
FROM tb_ordem_servico
WHERE data_final IS NOT NULL
GROUP BY date_format(data_final, '%m/%Y'), cod_servico
ORDER BY date_format(data_final, '%Y/%m'), cod_servico;


/**
*8º Exemplo
*/

/**
*Incluir a coluna "cliente" na tabela "tb_ordem_servico". 
*/
ALTER TABLE tb_ordem_servico ADD COLUMN cliente character varying(50);

/**
*Exibir os dados da tabela tb_ordem_servico 
*/
SELECT * FROM tb_ordem_servico;

/**
*Vamos alterar os dados da coluna "cliente"
*/

UPDATE tb_ordem_servico SET cliente = 'Padaria P' WHERE cod_ordem >=34330 AND cod_ordem <=34333;
UPDATE tb_ordem_servico SET cliente = 'Marcenaria M' WHERE cod_ordem >34333 AND cod_ordem <=34336;
UPDATE tb_ordem_servico SET cliente = 'HOSPITAL H' WHERE cod_ordem >34336;

/**
*Exibir os dados da tabela tb_ordem_servico após a atualização 
*/
SELECT * FROM tb_ordem_servico;

/**
*Exibir quantas empresas fizeram solicitação de ordem de serviço.
*Se observarmos a coluna "cliente" observamos que 3 empresas 
*fizeram solicitação a "Padaria P", a  "Marcenaria M" e o "HOSPITAL H".
*/
SELECT COUNT(DISTINCT(cliente)) FROM tb_ordem_servico;
