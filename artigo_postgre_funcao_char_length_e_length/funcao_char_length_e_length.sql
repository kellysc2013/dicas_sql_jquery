/**
*Atenção!!! Descomente a sentença abaixo, somente se desejar excluir as tabela alunos ou chave
*/
--DROP TABLE IF EXISTS alunos;
--DROP TABLE IF EXISTS chave;

/**
*1º Exemplo
*/

/**
*Criação da tabela alunos
*/
CREATE TABLE alunos
(
	cod_matricula integer,
	nome varchar(255)
);

/**
*Inclusão dos registros na tabela alunos
*/
INSERT INTO 
alunos(cod_matricula, nome) 
VALUES
(14245, 'bruno da silva araújo'),
(14246, 'paulo santos oliveira'),
(14247, 'cristina costa');

/**
*Exibe os registros da tabela criada
*/
SELECT * FROM alunos;

/**
*A função char_length retorna a quantidade de caracteres.
*/
SELECT
cod_matricula,
nome,
CHAR_LENGTH(nome)
FROM alunos;

/**
*Quando utilizamos a função char_length, o nome da coluna passa a ter o mesmo nome da função.
*Se quisermos que a coluna tenha um outro nome devemos criar um alias (apelido) depois do "AS". 
*Neste exemplo eu preferi ela se chame "qtd_caracteres", então coloquei "qtd_caracteres" depois do "AS".
*/

SELECT
cod_matricula,
nome,
CHAR_LENGTH(nome) AS qtd_caracteres
FROM alunos;

/**
*2º Exemplo
*/

/**
*A função length também retorna a quantidade de caracteres.
*/
SELECT
cod_matricula,
nome,
LENGTH(nome)
FROM alunos;

/**
*Quando utilizamos a função length, o nome da coluna passa a ter o mesmo nome da função.
*Se quisermos que a coluna tenha um outro nome devemos criar um alias (apelido) depois do "AS". 
*Neste exemplo eu preferi ela se chame "qtd_caracteres", então coloquei "qtd_caracteres" depois do "AS".
*/

SELECT
cod_matricula,
nome,
LENGTH(nome) AS qtd_caracteres
FROM alunos;

/**
*3º Exemplo
*/

/**
*Criação da tabela chave
*/
CREATE TABLE chave 
(
	seq_caracteres bytea
);

/**
*Inclusão dos registros na tabela chave
*/
INSERT INTO chave(seq_caracteres)
VALUES
('dkfjdfjdkfjire'),
('jkljkljfkmmjjfdkfjdk'),
('jfijdfidosf');

/**
*Exibe os registros da tabela chave
*/
SELECT * FROM chave;

/**
*A função length retorna o número de caracteres de uma string de acordo com a codificação.
*/
SELECT
seq_caracteres,
LENGTH(seq_caracteres, 'UTF8')
FROM chave;
