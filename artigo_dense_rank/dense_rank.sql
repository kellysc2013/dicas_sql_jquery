/**
 *Script do exemplo: Função DENSE_RANK DO BLOG DICAS SQL & JQUERY
 *Data: 30/08/2014 Hora: 18:25
 */

/**
 *Criação da tabela "tb_corrida"
 */


--1º Exemplo

CREATE TABLE tb_corrida
(
	inscricao integer,
	tempo_gasto time,
	sexo char(1),	
	CONSTRAINT pk_inscricao PRIMARY KEY(inscricao)
);


/**
 *Inclusão dos registros na tabela "tb_corrida"
 */
INSERT INTO tb_corrida VALUES
(2480, '00:57:42', 'M'),
(2481, '00:58:42', 'M'),
(2482, '00:55:32', 'F'),
(2483, '00:58:42', 'F'),
(2484, '01:10:42', 'M'),
(2485, '00:59:42', 'F');

/**
 *Seleção dos registros na tabela "tb_corrida"
 */
SELECT * FROM tb_corrida;


/**
 *Classificação da posição dos corredores de acordo com o tempo.
 */
SELECT
DENSE_RANK() OVER(ORDER BY tempo_gasto ASC) AS posicao,
inscricao,
tempo_gasto,
sexo
FROM tb_corrida;  

--2º Exemplo

/**
 *Classificação dos corredores separados por sexo.
 */
SELECT
DENSE_RANK() OVER(PARTITION BY sexo ORDER BY tempo_gasto ASC) AS posicao,
inscricao,
tempo_gasto,
sexo
FROM tb_corrida;

--3º Exemplo

/**
 *Criação da tabela "tb_vendas"
 */
CREATE TABLE tb_vendas
(
	codigo_vendedor integer,
	produto_id integer,
	valor numeric(10,2),	
	data date,
	setor integer
); 

/**
 *Inclusão dos registros na tabela "tb_vendas"
 */
INSERT INTO tb_vendas VALUES
(52154, 5152 , 102.24, '01/04/2014', 21),
(52154, 2127 , 502.23, '05/04/2014', 10),
(52154, 2721 , 472.82, '20/04/2014', 12),
(52154, 7121 , 701.27, '22/04/2014', 13),
(53153, 9228 , 9005.24, '06/04/2014', 41),
(53153, 9235 , 7138.40, '13/04/2014', 82),
(93142, 1440 , 8005.00, '06/04/2014', 20),
(93142, 1530 , 9130.00, '13/04/2014', 30);

/**
 *Seleção dos registros na tabela "tb_vendas"
 */
SELECT * FROM tb_vendas;

/**
 *Classificação dos vendedores de acordo com o total de vendas
 */
SELECT
codigo_vendedor,
SUM(valor),
DENSE_RANK() OVER(ORDER BY SUM(valor) DESC) AS posicao
FROM tb_vendas
GROUP BY codigo_vendedor;
