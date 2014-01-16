/**
*Atenção!!! Descomente a sentença abaixo, somente se desejar excluir a tabela locacao_filiais
*/
--DROP TABLE IF EXISTS  locacao_filiais;

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
*Faz a concatenação das colunas, porém somente o primeiro registro é exibido, pois o complemento dos outros
*registros são nulos.
*Ao fazer uma concatenação com um dado nulo, o resultado é nulo.
*/
SELECT 
'Endereço: ' ||
tipo_logradouro || ' ' || 
logradouro || ' ' ||
numero || ' ' ||
complemento || ' ' ||
bairro
FROM locacao_filiais;

/**
*Antes de fazer a concatenação da coluna complemento faremos uma verificação.
*Se houver dados no campo faremos a concatenação com os dados deste campo.
*Caso contrário substituiremos o dado nulo por uma string vazia  ('').
*Para isso utilizaremos a função coalesce.
*/
SELECT 
'Endereço: ' ||
tipo_logradouro || ' ' || 
logradouro || ' ' ||
numero || ' ' ||
COALESCE(complemento, '') || ' ' ||
bairro
FROM locacao_filiais;

/**
*Similar ao exemplo anterior, mas trocamos o nome da coluna "?column?" para filiais,
*ou seja, criamos um alias(apelido) para esta coluna.
*/
SELECT 
'Endereço: ' ||
tipo_logradouro || ' ' || 
logradouro || ' ' ||
numero || ' ' ||
COALESCE(complemento, '') || ' ' ||
bairro AS filiais
FROM locacao_filiais;


/**
*Exemplo da funcão concat.
*A função concat surgiu a partir da versão 9.1, logo ela funcionará nesta versão ou em versões posteriores. 
*Ela tem função similar ao operador de concatenação "||", que seria unir string ou valores, 
*mas além disso ela possui uma vantagem, pois ignora dados nulos, 
*se você concatenar uma string ou valor com nulo o resultado não será nulo.
*/
SELECT
CONCAT
(
    'Endereço: ', tipo_logradouro, ' ', logradouro, ' ', numero, ' ', complemento, ' ', bairro
)
FROM locacao_filiais;

/**
*Similar ao exemplo anterior, mas trocamos o nome da coluna "concat" para filiais,
*ou seja, criamos um alias(apelido) para esta coluna.
*/
SELECT
CONCAT
(
    'Endereço: ', tipo_logradouro, ' ', logradouro, ' ', numero, ' ', complemento, ' ', bairro
) AS filiais
FROM locacao_filiais;
