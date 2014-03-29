/**
 *Descomente o comando abaixo somente se desejar excluir a tabela tb_exame. 
 */
--DROP TABLE IF EXISTS tb_exame;

/**
 *Descomente o comando abaixo somente se desejar excluir a tabela tb_funcionarios. 
 */
--DROP TABLE IF EXISTS tb_funcionarios;

/**
 *Cria a tabela tb_exame. 
 */
CREATE TABLE tb_exame
(
	paciente_id integer,
	nome_exame character varying(50),
	data_exame timestamp
);

/**
 *Inclui os registros na tabela tb_exame. 
 */
INSERT INTO 
tb_exame (paciente_id, nome_exame, data_exame)
VALUES 
(1, 'Urina', '2012-11-13 07:14:24'),
(2, 'Sangue', '2012-07-06 18:11:25'),
(3, 'Ultrasson', '2013-11-05 20:11:27'),
(4, 'Urina', '2013-12-20 12:11:01'),
(5, 'Sangue', '2013-07-03 16:42:02'),
(6, 'Ultrasson', '2013-01-14 17:25:04'),
(7, 'Urina', '2013-02-17 15:30:07'),
(8, 'Sangue', '2013-03-19 19:24:09'),
(9, 'Ultrasson', '2013-04-21 20:30:15'),
(10, 'Urina', '2013-05-27 20:44:39');

/**
 *Exibe os registros da tabela tb_exame. 
 */
SELECT * FROM tb_exame;

/**
 *1ºExemplo
 */
SELECT
paciente_id,
data_exame,
/*exibe o dia do exame*/
extract( day from data_exame ) AS dia,
/*exibe o mês do exame*/
extract( month from data_exame ) AS mes,
/*exibe o ano do exame*/
extract(year from data_exame ) AS ano,
/*exibe a hora do exame*/
extract( hour from data_exame ) AS hora,
/*exibe o minuto do exame*/
extract( minute from data_exame ) AS minuto,
/*exibe o segundo do exame*/
extract( second from data_exame ) AS segundo,
/*exibe os dias da semana que são representados por números inteiros de 0 até 6
 *0 - domingo, 1 - segunda e assim sucessivamente até 6 - sábado
 */
extract( dow from data_exame ) AS int_semana
FROM tb_exame;

/**
 *2ºExemplo
 */
SELECT
extract( year from data_exame ) AS ano,
/*A função COUNT faz a contagem*/
COUNT(*) AS quantidade
FROM tb_exame
/*Agrupa por ano*/
GROUP BY ano
/*Ordena por ano em ordem crescente*/
ORDER BY ano;

/**
 *3ºExemplo
 */

/**
 *Retornar a data atual.
 */
SELECT CURRENT_DATE;

/**
 *Cria a tabela tb_funcionários.
 */
CREATE TABLE tb_funcionarios
(
	func_codigo serial,
	func_nome character varying(200),
	func_data_nascimento date	
);

/**
 *Insere os registros na tabela tb_funcionarios.
 */
INSERT INTO tb_funcionarios(func_codigo, func_nome, func_data_nascimento)
VALUES
(DEFAULT, 'Ana Sousa', '1984-05-25'),
(DEFAULT, 'Paulo Silva', '1978-03-28'),
(DEFAULT, 'Rui Costa', '1982-11-15'),
(DEFAULT, 'Marina Lima', '1982-01-14'),
(DEFAULT, 'Karina Oliveira', '1984-03-28'),
(DEFAULT, 'Carlos Pereira', '1982-06-19');

/**
 *Exibe os registros da tabela tb_funcionarios. 
 */
SELECT * FROM tb_funcionarios;


/**
 *Exibe os aniversariantes do mes. 
 */
SELECT
func_codigo,
func_nome,
func_data_nascimento
FROM tb_funcionarios
WHERE
/*Verifica se o dia do aniversário é igual ao dia atual*/
EXTRACT (DAY FROM func_data_nascimento)  =  EXTRACT (DAY FROM CURRENT_DATE) 
/*
Operador lógico AND (E) seleciona um registro, somente se, as duas condições forem 
satisfeitas, ou seja se o dia e o mês da data de nascimento forem iguais ao dia e o mês da data atual.
*/
AND
/*Verifica se o mês do aniversário é igual ao mês atual*/
EXTRACT (MONTH FROM func_data_nascimento) =  EXTRACT (MONTH FROM CURRENT_DATE);


