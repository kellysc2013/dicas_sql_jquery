/*
Veja o artigo na integra em:
http://jquerydicas.blogspot.com.br
*/

/**
*Atenção!!! Descomente a sentença abaixo, somente se desejar excluir a tabela locacao_filiais
*/
--DROP TABLE locacao_filiais;

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

/*
Para exibirmos os campos da tabela "locacao_filiais" concatenados, executamos a sentença abaixo:
*/
SELECT 
'Endereço: ' +
tipo_logradouro + ' ' + 
logradouro + ' ' +
CAST(numero AS VARCHAR) + ' ' +
complemento + ' ' +
bairro
FROM locacao_filiais;

/*
Você deve estar pensando o que ocorreu? Por que somente o primeiro registro apareceu concatenado? Cadê os outros?
Se você observar os dois últimos registros, verá que eles não possuem dados na coluna complemento, ou seja, 
os dados são nulos nesta coluna. Ao fazer uma concatenação com um dado nulo, o resultado é nulo.
Como vamos resolver isto?
*/
SELECT 
'Endereço: ' +
tipo_logradouro + ' ' + 
logradouro + ' ' +
CAST(numero AS VARCHAR) + ' ' +
COALESCE(complemento, '') + ' ' +
bairro
FROM locacao_filiais;

/*
O nome da coluna será exibido como "(Nenhum nome de coluna)". Caso queira alterar este nome, crie um alias (apelido). 
Após o "AS" coloque o nome da coluna que você precisa. Neste exemplo, eu vou chamá-la de filiais.
*/

SELECT 
'Endereço: ' +
tipo_logradouro + ' ' + 
logradouro + ' ' +
CAST(numero AS VARCHAR) + ' ' +
COALESCE(complemento, '') + ' ' +
bairro
AS filiais
FROM locacao_filiais;

/*
A função concat surgiu a partir da versão 2012, logo ela funcionará nesta versão ou em versões posteriores. 
Ela tem função similar ao operador de concatenação "+". Ela possui duas  vantagens: 
além de unir valores numérico sem utilizar conversão, também ignora dados nulos.
*/

SELECT
CONCAT
(
    'Endereço: ', tipo_logradouro, ' ', logradouro, ' ', numero, ' ', complemento, ' ', bairro
)
FROM locacao_filiais;

/*
O nome da coluna será exibido como "(Nenhum nome de coluna)". 
Caso queira alterar este nome, crie um alias (apelido). Após o "AS" coloque o nome da coluna que você precisa. 
Neste exemplo, eu vou chamá-la de filiais.
*/

SELECT
CONCAT
(
    'Endereço: ', tipo_logradouro, ' ', logradouro, ' ', numero, ' ', complemento, ' ', bairro
) AS filiais
FROM locacao_filiais;
