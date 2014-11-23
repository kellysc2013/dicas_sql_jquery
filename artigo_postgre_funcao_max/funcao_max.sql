/**
*DESCOMENTE O COMANDO ABAIXO SOMENTE SE DESEJAR EXCLUIR A TABELA tb_imoveis
*/
--DROP TABLE IF EXISTS tb_imoveis;

/**
*DESCOMENTE O COMANDO ABAIXO SOMENTE SE DESEJAR EXCLUIR A TABELA tb_imoveis
*/
--DROP TABLE IF EXISTS tb_treino;

/**
*Criar a tabela tb_imoveis.
*/
CREATE TABLE tb_imoveis
(
  corretor_id integer,
  imovel_id integer,
  valor numeric(9,2)
);


/**
*Incluir os dados na tabela tb_imoveis
*/
INSERT INTO tb_imoveis VALUES
(120, 5421, 180000.00),
(124, 5421, 90000.00),
(122, 5421, 130000.00),
(124, 5421, 512000.00),
(120, 5421, 70000.00),
(122, 5421, 622000.00),
(120, 5421, 127000.00);

/**
*Exibir os dados da tabela tb_imoveis
*/
SELECT * FROM tb_imoveis;

/**
*1º EXEMPLO
*/

/**
*Exibe o imóvel com valor mais alto
*/
SELECT MAX(valor) FROM tb_imoveis;

/**
*Criação do alias imovel_valor_maximo
*/
SELECT MAX(valor) AS imovel_valor_maximo FROM tb_imoveis;

/**
*2º EXEMPLO
*/

/**
*Criar a tabela tb_treino.
*/
CREATE TABLE tb_treino
(
	atleta_id integer,
	data date,
	tempo interval
);

/**
*Incluir os dados na tabela tb_treino
*/
INSERT INTO tb_treino VALUES
(42159, '2014-11-20', '01:20:13'),
(53792, '2014-11-20', '01:31:13'),
(84151, '2014-11-20', '01:17:42'),
(42159, '2014-11-21', '01:22:24'),
(53792, '2014-11-21', '01:36:48'),
(84151, '2014-11-21', '01:19:08'),
(42159, '2014-11-22', '01:18:24'),
(53792, '2014-11-22', '01:32:29'),
(84151, '2014-11-22', '01:23:54');

/**
*Exibir os dados da tabela tb_treino
*/
SELECT * FROM tb_treino;

/**
* Qual foi o pior treino para cada atleta, ou seja qual corrida levou maior tempo.
* Vamos agrupar os atletas que estão armazenados na coluna "atleta_id". 
* Para agrupar, utilizaremos o " GROUP BY".
*/

SELECT 
atleta_id, MAX(tempo) AS pior_tempo
FROM tb_treino
GROUP BY atleta_id;

/**
*Para ordenar a identificação dos atleta em ordem crescente, ou seja, do valor menor para o maior, 
*deve-se usar "ORDER BY" seguido do nome da coluna, neste caso, 
*a coluna 'atleta_id' será ordenada .
*/
SELECT atleta_id, 
MAX(tempo) AS pior_tempo
FROM tb_treino
GROUP BY atleta_id
ORDER BY atleta_id;


/**
*3º EXEMPLO
*/

/**
*Também podemos utilizar a função "MAX" para filtrar um registro, 
*desde que a função "MAX" pertença a uma subquery. 
*/
SELECT 
atleta_id,   
data, 
tempo AS pior_tempo
FROM tb_treino WHERE tempo =
(
    SELECT MAX(tempo)
    FROM tb_treino
) 
