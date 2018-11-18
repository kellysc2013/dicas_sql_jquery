--ANTES DE UTILIZAR A FUNÇÃO "TO_CHAR" VERIFIQUE A CONFIGURAÇÃO DOS VALORES NUMÉRICOS NO POSTGRESQL COM O COMANDO ABAIXO:

SHOW LC_NUMERIC;

--Exemplo de retorno da consulta acima 
--"Portuguese_Brazil.1252"

--Observações:
--Para inserir números decimais em uma tabela utilize o tipo de dado numeric.
--Deve-se utilizar o "." como separador decimal no momento da inclusão dos dados.
--Para visualizar o decimal com virgula "," ao executar o comando "SELECT", formate o valor com a função to_char

--1º) Criação da tabela para teste
CREATE TABLE teste_numerico
(
	num_dec numeric(20,2) null, -- 18 casas reservadas para inteiro e 2 casas reservadas para decimal
	num_s_int smallint null,
	num_i_int integer null,
	num_b_int bigint null
);

--2º) Inclusão dos registros
INSERT INTO teste_numerico VALUES
(12323.39, 764, 2474836, 92372036854775800),
(13.24, 2765, -21473622,-92233036854775801),
(123456789.3, -32766, 214743623,92233725802),
(-443456789123456789.8, 32767, 2147483624, -123456789123456789);

--3º) Consulta com dados formatados
SELECT 
num_dec, 
to_char(num_dec, 'FM999G999G999G999G999G999D00') AS num_dec_formatado,
num_s_int,
to_char(num_s_int, 'FM99G999') AS num_s_int_formatado,
num_i_int,
to_char(num_i_int, 'FM9G999G999G999') AS num_i_int_formatado,
num_b_int,
to_char(num_b_int, 'FM9G999G999G999G999G999G999') AS num_b_int_formatado 
FROM teste_numerico;