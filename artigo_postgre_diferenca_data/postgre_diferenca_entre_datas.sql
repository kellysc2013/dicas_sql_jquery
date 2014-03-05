/**
*ATENÇÃO!!! PARA EXCLUIR A TABELA tb_locacao, DESCOMENTE A LINHA ABAIXO
*/
--DROP TABLE tb_locacao;

/**
*ATENÇÃO!!! PARA EXCLUIR A TABELA tb_cadastro, DESCOMENTE A LINHA ABAIXO
*/
--DROP TABLE tb_cadastro;
/**
*ATENÇÃO!!! PARA EXCLUIR A TABELA tb_manutencao, DESCOMENTE A LINHA ABAIXO
*/
--DROP TABLE tb_manutencao;

/**
*Criar a tabela "tb_locacao". 
*/
CREATE TABLE tb_locacao
(
imovel_id serial,
data_oferta date,
data_locacao date
);

/**
*Incluir os registros na tabela "tb_locacao".
*/
INSERT INTO tb_locacao(imovel_id, data_oferta, data_locacao) VALUES(DEFAULT, '2013-01-14', '2013-02-17');
INSERT INTO tb_locacao(imovel_id, data_oferta, data_locacao) VALUES(DEFAULT, '2013-11-27', '2014-02-09');
INSERT INTO tb_locacao(imovel_id, data_oferta, data_locacao) VALUES(DEFAULT, '2013-07-27', '2014-03-01');
INSERT INTO tb_locacao(imovel_id, data_oferta, data_locacao) VALUES(DEFAULT, '2013-01-05', '2014-02-28');
INSERT INTO tb_locacao(imovel_id, data_oferta, data_locacao) VALUES(DEFAULT, '2014-01-05', '2014-02-08');
INSERT INTO tb_locacao(imovel_id, data_oferta, data_locacao) VALUES(DEFAULT, '2014-02-06', '2014-02-09');

/**
*Calculo da diferença entre a data da locação e a data de oferta, em dias 
*/
SELECT
imovel_id,
data_oferta,
data_locacao,
data_locacao - data_oferta AS quantidade_dias
FROM tb_locacao;

/**
*Calculo do intervalo, em ano(s), mes(es) e dia(s) entre a data da locação e a data de oferta.
*/
SELECT
imovel_id,
data_oferta,
data_locacao,
/*Calculo da diferença entre a data da locação e a data de oferta*/
AGE(data_locacao, data_oferta) AS intervalo
FROM tb_locacao;

/**
*Calculo do intervalo, em ano(s), mes(es) e dia(s) entre a data da locação e a data de oferta.
*Intervalo, formatado com a função to_char.
*/
SELECT
imovel_id,
data_oferta,
data_locacao,
/*Calculo da diferença entre a data da locação e a data de oferta*/
TO_CHAR ( AGE(data_locacao, data_oferta) , 'YY "ano(s)" MM "mes(es)" DD "dia(s)" ' ) AS intervalo
FROM tb_locacao;

/**
*Criar tabela "tb_cadastro".
*/
CREATE TABLE tb_cadastro (
    cliente_id serial,
    data_cadastro date
);

/**
*Incluir o registros na tabela "tb_cadastro".
*/
INSERT INTO tb_cadastro (cliente_id, data_cadastro) VALUES
(DEFAULT, '2013-06-13'),
(DEFAULT, '2013-07-15'),
(DEFAULT, '2013-08-13'),
(DEFAULT, '2013-10-20'),
(DEFAULT, '2013-11-25'),
(DEFAULT, '2014-01-10'),
(DEFAULT, '2014-02-15'),
(DEFAULT, '2014-03-25');

/**
*Exibir a data atual.
*/
SELECT CURRENT_DATE;

/**
*Exibir clientes cadastrados a mais de 90 dias
*/
SELECT 
cliente_id,
data_cadastro,
/*calcula a diferença de dias*/
CURRENT_DATE  - data_cadastro AS quantidade_dias
FROM tb_cadastro
/*filtra somente os clientes que são cadastrados há mais que 90 dias*/
WHERE CURRENT_DATE  - data_cadastro > 90;

/**
*Criar a tabela "tb_manutencao".
*/
CREATE TABLE tb_manutencao
(
equipamento_id serial,
data_inicio timestamp,
data_final  timestamp
);

/**
*Inseri os registros na tabela "tb_manutencao"
*/
INSERT INTO tb_manutencao VALUES(DEFAULT, '2014-03-04 13:42:21', '2014-03-08 06:34:15');
INSERT INTO tb_manutencao VALUES(DEFAULT, '2014-03-08 07:12:15', '2014-03-11 20:16:10');
INSERT INTO tb_manutencao VALUES(DEFAULT, '2014-02-15 17:14:18', '2014-02-16 09:40:52');
INSERT INTO tb_manutencao VALUES(DEFAULT, '2014-01-20 21:24:14', '2014-01-22 11:10:15');

/**
*Exibe os equipamentos que tiveram manutenção maior ou igual a 80 horas
*/
SELECT
equipamento_id,
data_inicio,
data_final,
age(data_final, data_inicio)
FROM tb_manutencao
WHERE age(data_final, data_inicio) >= '80 hour';