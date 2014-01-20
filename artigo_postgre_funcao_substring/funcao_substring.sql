/**
*Atenção!!! Descomente a sentença abaixo, somente se desejar excluir a tabela alunos ou contatos
*/
--DROP TABLE IF EXISTS alunos;
--DROP TABLE IF EXISTS contatos;

/**
*1º Exemplo
*/

/**
*Extrair os 3 primeiros caracteres da string "Rio Grande do Sul" a partir da primeira posição.
*/
SELECT SUBSTRING('Rio Grande do Sul' from 1 for 3); 

/**
*2º Exemplo
*/

/**
*Extrair os 10 primeiros caracteres da string "Rio Grande do Sul" a partir da primeira posição.
*/
SELECT SUBSTRING('Rio Grande do Sul' from 1 for 10); 

/**
*3º Exemplo
*/

/**
*Extrair os 9 primeiros caracteres da string "Rio Grande do Sul" a partir da quinta posição.
*/
SELECT SUBSTRING('Rio Grande do Sul' from 5 for 9);


/**
*4º Exemplo
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
*A função substring retorna o 6 primeiros caracteres.
*/
SELECT
cod_matricula,
nome,
SUBSTRING(nome FROM 1 FOR 6)
FROM alunos;

/**
*Quando utilizamos a função substring, o nome da coluna passa a ter o mesmo nome da função.
*Se quisermos que a coluna tenha um outro nome devemos criar um alias (apelido) depois do "AS". 
*Neste exemplo, eu preferi ela se chame "caracteres_iniciais", então coloquei "caracteres_iniciais" depois do "AS".
*/

SELECT
cod_matricula,
nome,
SUBSTRING(nome FROM 1 FOR 6) AS caracteres_iniciais
FROM alunos;

/**
*5º Exemplo
*/

/**
*Criação da tabela contatos
*/
CREATE TABLE contatos
(
	cliente_id integer,
	telefone character varying
);

/**
*Inclui os registros na tabela contatos
*/
INSERT INTO contatos(cliente_id, telefone)
VALUES 
(1, '5181-8342'),
(2, '5934-2241'),
(3, '5933-2242'),
(4, '5931-2242');

/**
*Exibe a tabela contatos
*/
SELECT * FROM contatos;

/**
*Extrair o prefixo do telefone(quatro primeiros digítos)
*/
SELECT
cliente_id, 
telefone,
substring(telefone from '^[0-9]{4}')
FROM contatos;

/**
*6º Exemplo
*/
/**
*Extrair os quatros ultimos digitos do telefone
*/
SELECT
cliente_id, 
telefone,
substring(telefone from '[0-9]{4}$')
FROM contatos;