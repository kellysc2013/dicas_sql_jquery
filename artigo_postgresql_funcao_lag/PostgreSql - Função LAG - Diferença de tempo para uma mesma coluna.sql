/**
 *Caso queira excluir as tabelas do exemplo. Descomente o comando "DROP" abaixo:
 */
--DROP TABLE IF EXISTS tb_venda, tb_venda_depart;

/**
 *1º Exemplo
 */

/**
 *Cria a tabela tb_venda
 */
CREATE TABLE tb_venda
(
  cliente_id integer,
  data_hora timestamp without time zone
);

/**
 *Insere os registros na tabela tb_venda 
 */
INSERT INTO tb_venda VALUES
(542, '2014-11-26 23:30:01'),
(543, '2014-11-26 23:36:45'),
(544, '2014-11-26 23:47:13'),
(545, '2014-11-26 23:58:17'),
(546, '2014-11-27 01:05:19'),
(547, '2014-11-27 01:12:27'),
(548, '2014-11-27 01:20:08'),
(549, '2014-11-27 01:25:06');


/**
 *Visualiza os registros na tabela tb_venda 
 */
SELECT * FROM tb_venda;

/**
 *Calcula o intervalo de tempo de espera para cada cliente
 */
SELECT
cliente_id,
data_hora, 
data_hora - LAG(data_hora) OVER (ORDER BY data_hora) AS tempo_espera
FROM tb_venda; 


/**
 *2º Exemplo
 */

/**
 *Cria a tabela tb_venda_depart
 */
CREATE TABLE tb_venda_depart
(
  cliente_id integer,
  data_hora timestamp without time zone
);


/**
 *Insere os registros na tabela tb_venda_depart 
 */
INSERT INTO tb_venda_depart VALUES
(542, '2014-11-26 22:22:01'),
(543, '2014-11-26 22:24:45'),
(544, '2014-11-26 22:26:13'),
(545, '2014-11-26 22:35:17'),
(546, '2014-11-27 08:03:19'),
(547, '2014-11-27 08:07:27'),
(548, '2014-11-27 08:10:08'),
(549, '2014-11-27 08:16:06');

/**
 *Visualiza os registros na tabela tb_venda_depart 
 */
SELECT * FROM tb_venda_depart;

/**
 *Calcula o intervalo de tempo de espera para cada cliente, desconsiderando o tempo 
 *em que a loja estava fechada, ou seja o calculo de intervalo de tempo é feito por dia. 
*/
SELECT
cliente_id,
data_hora, 
data_hora - LAG(data_hora)  
OVER (PARTITION BY(DATE_TRUNC('DAY', data_hora)) ORDER BY data_hora) AS tempo_espera
FROM tb_venda_depart;

/**
 *3º Exemplo
 */

/**
 *Calcula a média do intervalo de espera
 */
WITH cliente_periodo AS
(
	SELECT
	cliente_id,
	data_hora, 
	data_hora - LAG(data_hora)  
	OVER (PARTITION BY(DATE_TRUNC('DAY', data_hora)) ORDER BY data_hora) AS tempo_espera
	FROM tb_venda_depart
)
SELECT  AVG(tempo_espera) AS media_tempo_espera
FROM cliente_periodo;

/**
 *4º Exemplo
 */
 
/**
 *Calcula a média de espera por dia
 */
WITH cliente_periodo AS
(
	SELECT
	cliente_id,
	data_hora, 
	data_hora - LAG(data_hora)  
	OVER (PARTITION BY(DATE_TRUNC('DAY', data_hora)) ORDER BY data_hora) AS tempo_espera
	FROM tb_venda_depart
)
SELECT DATE_TRUNC('DAY', data_hora), AVG(tempo_espera)
FROM cliente_periodo
GROUP BY DATE_TRUNC('DAY', data_hora);

/**
 *Formata a data
 */
WITH cliente_periodo AS
(
	SELECT
	cliente_id,
	data_hora, 
	data_hora - LAG(data_hora)  
	OVER (PARTITION BY(DATE_TRUNC('DAY', data_hora)) ORDER BY data_hora) AS tempo_espera
	FROM tb_venda_depart
)
SELECT TO_CHAR(data_hora, 'DD/MM/YYYY') AS DATA, AVG(tempo_espera) AS media_tempo_espera
FROM cliente_periodo
GROUP BY TO_CHAR(data_hora, 'DD/MM/YYYY');

/**
 *Truncar a média de tempo de espera
 */
WITH cliente_periodo AS
(
	SELECT
	cliente_id,
	data_hora, 
	data_hora - LAG(data_hora)  
	OVER (PARTITION BY(DATE_TRUNC('DAY', data_hora)) ORDER BY data_hora) AS tempo_espera
	FROM tb_venda_depart
)
SELECT TO_CHAR(data_hora, 'DD/MM/YYYY') AS DATA, 
DATE_TRUNC('SECOND',AVG(tempo_espera)) AS media_tempo_espera
FROM cliente_periodo
GROUP BY TO_CHAR(data_hora, 'DD/MM/YYYY');
