/**
*ATENÇÃO!!! PARA EXCLUIR A TABELA tb_folha_ponto, DESCOMENTE A LINHA ABAIXO
*/
--DROP TABLE tb_folha_ponto;


/**
*Criar a tabela "tb_folha_ponto". 
*/

CREATE TABLE tb_folha_ponto
(
	id serial,
	data_inicio timestamp  without time zone,
	data_saida timestamp without time zone
);

/**
*Incluir os registros na tabela "tb_folha_ponto".
*/
INSERT INTO tb_folha_ponto(id, data_inicio, data_saida) VALUES(DEFAULT, '2018-10-01 18:00', '2018-10-02 02:00');
INSERT INTO tb_folha_ponto(id, data_inicio, data_saida) VALUES(DEFAULT, '2018-10-02 19:00', '2018-10-03 03:00');
INSERT INTO tb_folha_ponto(id, data_inicio, data_saida) VALUES(DEFAULT, '2018-10-03 20:00', '2018-10-04 04:00');
INSERT INTO tb_folha_ponto(id, data_inicio, data_saida) VALUES(DEFAULT, '2018-10-04 21:00', '2018-10-05 05:00');
INSERT INTO tb_folha_ponto(id, data_inicio, data_saida) VALUES(DEFAULT, '2018-10-05 22:00', '2018-10-06 06:00');
INSERT INTO tb_folha_ponto(id, data_inicio, data_saida) VALUES(DEFAULT, '2018-10-08 08:00', '2018-10-08 16:01');
INSERT INTO tb_folha_ponto(id, data_inicio, data_saida) VALUES(DEFAULT, '2018-10-09 07:59', '2018-10-09 16:58');
INSERT INTO tb_folha_ponto(id, data_inicio, data_saida) VALUES(DEFAULT, '2018-10-10 08:00', '2018-10-10 16:01');
INSERT INTO tb_folha_ponto(id, data_inicio, data_saida) VALUES(DEFAULT, '2018-10-11 08:00', '2018-10-11 16:02');
INSERT INTO tb_folha_ponto(id, data_inicio, data_saida) VALUES(DEFAULT, '2018-10-12 08:00', '2018-10-12 16:03');



/**
*Consulta os registros da folha
*/
SELECT id, data_inicio, data_saida, data_saida - data_inicio AS horas_trabalhadas FROM tb_folha_ponto;


/**
*Soma total dos registros
*/ 
SELECT  sum(data_saida - data_inicio) AS total_horas_trabalhadas FROM tb_folha_ponto;


/**
*Soma parcial dos registros
*/
SELECT id, data_saida, data_inicio, sum(data_saida - data_inicio) OVER (ORDER BY id) AS soma_parcial_horas_trabalhadas FROM tb_folha_ponto;