/**
 *Descomente o comando abaixo somente se desejar excluir a tabela tb_produtos.
 */
--DROP TABLE IF EXISTS tb_produtos;

/**
 *Descomente o comando abaixo somente se desejar excluir a tabela tb_locacao.
 */
--DROP TABLE IF EXISTS tb_locacao;

/**
 *Descomente o comando abaixo somente se desejar excluir a tabela tb_matriculas.
 */
 --DROP TABLE IF EXISTS tb_matriculas;

/**
 *Descomente o comando abaixo somente se desejar excluir a tabela tb_loc_imoveis.
 */
--DROP TABLE IF EXISTS tb_loc_imoveis;

/**
 *1ºExemplo.
 */

/**
 *Cria a tabela tb_produtos.
 */
CREATE TABLE tb_produtos
(
  produto_id serial,
  data_vencimento date
);

/**
 *Inclui os registros na tabela tb_produtos.
 */
INSERT INTO 
tb_produtos(produto_id, data_vencimento)
VALUES
(DEFAULT, '2014-04-18'),
(DEFAULT, '2014-05-13'),
(DEFAULT, '2014-06-04'),
(DEFAULT, '2014-09-20');

/**
 *Seleciona os registros na tabela tb_produtos.
 */
SELECT * FROM tb_produtos;

/**
 *1ª Solução - Exibe a data de recolhimento.
 */
SELECT
produto_id,
data_vencimento,
data_vencimento - 3 AS data_recolhimento
FROM tb_produtos;

/**
 *Exibe a data de recolhimento formatada.
 */
SELECT
produto_id,
to_char (data_vencimento, 'dd/mm/yyyy') AS data_vencimento,
to_char (data_vencimento - 3, 'dd/mm/yyyy') AS data_recolhimento
FROM tb_produtos;

/**
 *2ª Solução - Exibe a data de recolhimento.
 */
SELECT
produto_id,
data_vencimento,
data_vencimento - interval '3 days' AS data_recolhimento
FROM tb_produtos;

/**
 *Exibe a data de recolhimento formatada.
 */
SELECT
produto_id,
to_char (data_vencimento, 'dd/mm/yyyy') AS data_vencimento,
to_char (data_vencimento - interval '3 days', 'dd/mm/yyyy') AS data_recolhimento
FROM tb_produtos;

/**
 *2º Exemplo
 */

/**
 *Cria a tabela tb_locacao.
 */
CREATE TABLE tb_locacao
(
	locatario_id integer,
	imovel_id integer,
	data_fim_contrato date
);

/**
 *Inclui os registros na tabela tb_locacao.
 */
INSERT INTO tb_locacao (locatario_id, imovel_id, data_fim_contrato)
VALUES 
(1221, 454, '2014-08-12'),
(1421, 842, '2014-09-17'),
(1423, 845, '2014-10-20');

/**
 *Exibe os registros da tabela tb_locacao.
 */
SELECT * FROM tb_locacao;

/**
 *Exibe a data de oferta de renovação de contrato.
 */
SELECT
locatario_id,
imovel_id,
data_fim_contrato,
data_fim_contrato - interval '3 months' AS oferta_renovacao
FROM tb_locacao;

/**
 *Exibe a data de oferta de renovação de contrato formatada.
 */
SELECT
locatario_id,
imovel_id,
to_char (data_fim_contrato, 'dd/mm/yyyy'),
to_char (data_fim_contrato - interval '3 months', 'dd/mm/yyyy') AS oferta_renovacao
FROM tb_locacao;

/**
 *3º Exemplo
 */

/**
 *Cria a tabela tb_matriculas.
 */
CREATE TABLE tb_matriculas
(
	matricula_id serial,
	data_matricula date
);

/**
 *Inclui os registros na tabela tb_matriculas.
 */
INSERT INTO 
tb_matriculas(matricula_id, data_matricula)
VALUES
(DEFAULT, '2014-03-21'),
(DEFAULT, '2014-03-22'),
(DEFAULT, '2014-03-25'),
(DEFAULT, '2014-03-26'),
(DEFAULT, '2014-03-27'),
(DEFAULT, '2014-03-28'),
(DEFAULT, '2014-03-29'),
(DEFAULT, '2014-03-30'),
(DEFAULT, '2014-03-31'),
(DEFAULT, '2014-04-01');

/**
 *Exibe o dia atual.
 */
SELECT CURRENT_DATE;

/**
 *Exibe os registros da tabela tb_matriculas.
 */
SELECT * FROM tb_matriculas;

/**
 *Exibe a quantidade de alunos matriculados na última semana.
 */
SELECT 
COUNT(matricula_id) AS quantidade_alunos
FROM tb_matriculas
WHERE data_matricula > CURRENT_DATE - interval '7 days';


/**
 *4º Exemplo
 */
 
/*Cria a tabela "tb_loc_imoveis"*/
CREATE TABLE tb_loc_imoveis
(
	loc_id integer,
	tipo_id_loc integer,
	periodo_renovacao interval,
	data_fim_contrato date
);

/*Inserir registros na tabela "tb_loc_imoveis"*/
INSERT INTO tb_loc_imoveis (loc_id, tipo_id_loc, periodo_renovacao, data_fim_contrato)
VALUES
(1221, 1, '1 month 5 days 3 hours 23 minutes', '2021-03-01'),
(1421, 2, '1 year 1 month',  '2021-04-05'),
(1423, 3, '15 days 1 hour',  '2021-05-15'),
(1221, 1, '1 month 5 days 3 hours 23 minutes',  '2021-08-12'),
(1421, 2, '1 year 1 month', '2021-09-17'),
(1423, 3, '15 days 1 hour',  '2021-10-20');


/*
Para calcular as datas de oferta de renovação executamos a consulta abaixo.
Após a execução da consulta, será exibido o resultado na coluna com o alias "oferta_renovacao".
*/
SELECT
loc_id,
tipo_id_loc,
periodo_renovacao,
data_fim_contrato,
data_fim_contrato - periodo_renovacao AS oferta_renovacao
FROM tb_loc_imoveis;
