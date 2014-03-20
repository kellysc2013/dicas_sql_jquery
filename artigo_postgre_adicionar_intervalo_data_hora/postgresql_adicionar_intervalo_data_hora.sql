/**
*Atenção!!! Descomente o comando abaixo somente se deseja excluir a tabela tb_exame_paciente.
*/
--DROP TABLE IF EXISTS tb_exame_paciente;

/**
*Atenção!!! Descomente o comando abaixo somente se deseja excluir a tabela tb_equipamentos.
*/
--DROP TABLE IF EXISTS tb_equipamentos;

/**
*Atenção!!! Descomente o comando abaixo somente se deseja excluir a tabela tb_turma.
*/
--DROP TABLE IF EXISTS tb_turma;

/**
*Atenção!!! Descomente o comando abaixo somente se deseja excluir a tabela tb_locacao.
*/
--DROP TABLE IF EXISTS tb_locacao;

/**
*Atenção!!! Descomente o comando abaixo somente se deseja excluir a tabela tb_pedido.
*/
--DROP TABLE IF EXISTS tb_pedido;

--Inicio do 1º exemplo
/**
*Cria a tabela "tb_exame_paciente". Esta tabela armazena os exames dos pacientes.
*/
CREATE TABLE tb_exame_paciente
(
paciente_codigo integer,
exame_codigo integer,
exame_data date 
);

/**
*Inclui os registros na tabela "tb_exame_paciente". 
*/
INSERT INTO tb_exame_paciente (paciente_codigo, exame_codigo, exame_data)
VALUES
(1346, 124, '2014-03-16'),
(1517, 248, '2014-03-17'),
(1732, 426, '2014-03-15');

/**
*1ª solução - Exibir as datas de entrega do exame.
*/
SELECT 
paciente_codigo,
exame_codigo,
exame_data,
exame_data + 3 AS exame_entrega  
FROM tb_exame_paciente;

/**
*1ª solução - com as datas formatadas.
*/
SELECT
paciente_codigo,
exame_codigo,
to_char (exame_data, 'dd/mm/yyyy') AS exame_data,
to_char (exame_data + 3, 'dd/mm/yyyy') AS exame_entrega
FROM tb_exame_paciente;

/**
*2ª solução - Exibir as datas de entrega do exame.
*/
SELECT
paciente_codigo,
exame_codigo,
exame_data,
exame_data + interval '3 days' AS exame_entrega
FROM tb_exame_paciente;

/**
*2ª solução - com as datas formatadas.
*/
SELECT
paciente_codigo,
exame_codigo,
to_char(exame_data, 'dd/mm/yyyy') AS exame_data,
to_char(exame_data + interval '3 days' ,'dd/mm/yyyy') AS exame_entrega
FROM tb_exame_paciente;

--Fim do 1º exemplo

--Inicio do 2º exemplo
/**
*Cria a tabela "tb_equipamentos". Esta tabela armazena os equipamentos de uma fábrica.
*/
CREATE TABLE tb_equipamentos
(
	equipamento_id serial,
	data_inicio date
);

/**
*Insere os registros na tabela "tb_equipamentos"
*/
INSERT INTO tb_equipamentos(equipamento_id, data_inicio)
VALUES
(DEFAULT, '2014-01-05'),
(DEFAULT, '2014-02-24'),
(DEFAULT, '2014-09-19');

/**
*Exibe as datas de manutenção dos equipamentos.
*/
SELECT 
equipamento_id,
data_inicio,
data_inicio + interval '3 months' AS pri_manutencao,
data_inicio + interval '6 months' AS seg_manutencao
FROM tb_equipamentos;

/**
*Exibe as datas de manutenção dos equipamentos formatadas.
*/
SELECT 
equipamento_id,
to_char(data_inicio, 'dd/mm/yyyy') AS data_inicio,
to_char(data_inicio + interval '3 months', 'dd/mm/yyyy') AS pri_manutencao,
to_char(data_inicio + interval '6 months', 'dd/mm/yyyy') AS seg_manutencao
FROM tb_equipamentos;
--Fim do 2º exemplo

--Inicio do 3º exemplo

/**
*Cria a tabela tb_turma. Armazena turmas.
*/
CREATE TABLE tb_turma
(
	turma_id serial,
	curso_id integer,
	data_inicio date
);

/**
*Insere os registros na tabela tb_turmas.
*/
INSERT INTO tb_turma (turma_id, curso_id, data_inicio)
VALUES
(DEFAULT, 5421, '2014-03-24'),
(DEFAULT, 1243, '2014-04-09'),
(DEFAULT, 6423, '2014-05-27');


/**
*Exibe as datas do 1º e 2º teste. 
*/
SELECT 
turma_id,
curso_id,
data_inicio,
data_inicio + interval '1 year' AS pri_teste,
data_inicio + interval '2 years' AS seg_teste
FROM tb_turma;

/**
*Exibe as datas do 1º e 2º teste formatadas. 
*/
SELECT
turma_id,
curso_id,
to_char(data_inicio, 'dd/mm/yyyy') AS data_inicio,
to_char(data_inicio + interval '1 year',  'dd/mm/yyyy') AS pri_teste,
to_char(data_inicio + interval '2 years', 'dd/mm/yyyy') AS seg_teste
FROM tb_turma;

--Fim do 3º exemplo

--Inicio do 4º exemplo

/**
*Criação da tabela "tb_locacao". Armazena os registros de locação.
*/
CREATE TABLE tb_locacao
(
	imovel_id serial,
	cliente_id integer, 
	data_inicio_locacao date
);

/**
*Insere os registros na tabela "tb_locacao".
*/
INSERT INTO tb_locacao(imovel_id, cliente_id, data_inicio_locacao)
VALUES
(DEFAULT, 7154 ,'2014-03-19'), 
(DEFAULT, 6432 ,'2013-12-23'),
(DEFAULT, 1431 ,'2013-10-25');

/**
*Exibe as datas de encerramento dos contratos de locação.
*/
SELECT
imovel_id,
cliente_id,
data_inicio_locacao,
data_inicio_locacao + interval '2 years 5 months' AS data_fim_locacao
FROM tb_locacao;

/**
*Exibe as datas do exemplo formatadas.
*/
SELECT
imovel_id,
cliente_id,
to_char (data_inicio_locacao, 'dd/mm/yyyy'),
to_char (data_inicio_locacao + interval '2 year 5 months' , 'dd/mm/yyyy') AS data_fim_locacao
FROM tb_locacao;
--Fim do do 4º exemplo

--Inicio do 5º exemplo

/**
*Cria a tabela "tb_pedido". Esta tabela armazena os pedidos dos clientes.
*/
CREATE TABLE tb_pedido
(
	pedido_codigo serial,
	pedido_data timestamp
);

/**
*Insere os registros na tabela "tb_pedido".
*/
INSERT INTO tb_pedido(pedido_codigo, pedido_data)
VALUES
(DEFAULT, '2014-03-17 13:24:12'),
(DEFAULT, '2014-03-17 19:30:15'),
(DEFAULT, '2014-03-17 23:45:42'),
(DEFAULT, '2014-03-17 23:59:30');

/**
*Exibe as datas de entrega dos pedidos.
*/
SELECT
pedido_codigo,
pedido_data,
pedido_data + interval '40 min'AS data_entrega
FROM tb_pedido;

SELECT
pedido_codigo,
pedido_data,
pedido_data + interval '40 minutes' AS data_entrega
FROM tb_pedido;

/**
*Exibe as datas de entrega dos pedidos formatadas.
*/
SELECT
pedido_codigo,
to_char(pedido_data, 'dd/mm/yyyy hh24:mi:ss') AS pedido_data,
to_char(pedido_data + interval '40 minutes' , 'dd/mm/yyyy hh24:mi:ss') AS data_entrega
FROM tb_pedido;

--Fim do 5º exemplo