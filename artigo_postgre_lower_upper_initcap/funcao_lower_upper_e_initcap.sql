/**
*Atenção!!! Descomente a sentença abaixo, somente se desejar excluir a tabela locacao_filiais ou alunos
*/
--DROP TABLE IF EXISTS  locacao_filiais;
--DROP TABLE IF EXISTS  alunos;

/**
*Criação da tabela locacao_filiais
*/
CREATE TABLE locacao_filiais 
(
	tipo_logradouro varchar(15),
	logradouro varchar(100),
	numero integer,
	complemento character varying(40),
	bairro character varying(35) 	

);

/**
*Inclusão dos registros na tabela locacao_filiais
*/
INSERT INTO 
locacao_filiais(tipo_logradouro, logradouro, numero, complemento, bairro) 
VALUES
('Avenida', 'Domingos de Moraes', 10574, '2º ANDAR', 'Vila Mariana'),
('Rua', 'Enxovia', 1124, NULL, 'Paraíso'),
('Rua', 'Paes da Silva', 540, NULL, 'Lapa');

/**
*Exibe os registros da tabela criada
*/
SELECT * FROM locacao_filiais;

/**
*A função lower converte todos os caracteres de uma string string para minúsculo.
*Neste caso utilizamos esta função na coluna logradouro.
*/
SELECT
tipo_logradouro,
LOWER(logradouro),
numero,
complemento,
bairro
FROM locacao_filiais;

/**
*Quando utilizamos a função lower, o nome da coluna passa a ter o mesmo nome da função.
*Se quisermos que o nome da coluna continue se chamando "logradouro" ou quisermos que tenha um outro nome
*devemos criar um alias (apelido) depois do AS. 
*Neste exemplo eu preferi que ela continue se chamando "logradouro",
*então coloquei logradouro depois do AS 
*/

SELECT
tipo_logradouro,
LOWER(logradouro) AS logradouro,
numero,
complemento,
bairro
FROM locacao_filiais;

/**
*A função upper converte todos os caracteres de uma string string para minúsculo.
*Neste caso utilizamos esta função na coluna logradouro.
*/

SELECT
tipo_logradouro,
UPPER(logradouro),
numero,
complemento,
bairro
FROM locacao_filiais;

/**
*Quando utilizamos a função upper, o nome da coluna passa a ter o mesmo nome da função.
*Se quisermos que o nome da coluna continue se chamando "logradouro" ou quisermos que tenha um outro nome
*devemos criar um alias (apelido) depois do AS. 
*Neste exemplo eu preferi que ela continue se chamando "logradouro",
*então coloquei logradouro depois do AS 
*/
SELECT
tipo_logradouro,
UPPER(logradouro) AS logradouro,
numero,
complemento,
bairro
FROM locacao_filiais;


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
*A função initcap converte o primeiro carácter de cada palavra para maiúsculo. 
*O restante das letras ficam em minúsculo.
*/
SELECT
cod_matricula,
INITCAP(nome)
FROM alunos;

/**
*Quando utilizamos a função initcap, o nome da coluna passa a ter o mesmo nome da função.
*Se quisermos que o nome da coluna continue se chamando "nome" ou quisermos que tenha um outro nome 
*devemos criar um alias (apelido) depois do "AS". 
Neste exemplo eu preferi que ela continue se chamando "nome", então coloquei "nome" depois do "AS".
*/
SELECT
cod_matricula,
INITCAP(nome) AS nome
FROM alunos;



