/**
* IMPORTANTE!!!
* DESCOMENTE A SENTENÇA ABAIXO SOMENTE SE DESEJAR EXCLUIR A TABELA tb_fornecedor
*/
/*DROP TABLE IF EXISTS tb_fornecedor;*/

/**
*Cria a tabela tb_fornecedor.
*/
CREATE TABLE tb_fornecedor
(
    segmento character varying(70),
    produto character varying(70),
    valor numeric(11,2)
);


/**
*Inclui os dados na tabela tb_fornecedor.
*/
INSERT INTO tb_fornecedor VALUES('Papelaria e informática','HD 500 GB', 300.00);
INSERT INTO tb_fornecedor VALUES('Papelaria e informática', 'Tonner', 250.00);

INSERT INTO tb_fornecedor VALUES('Marcenaria', 'Cadeira', 50.00);
INSERT INTO tb_fornecedor VALUES('Marcenaria', 'Mesa', 600.00);
INSERT INTO tb_fornecedor VALUES('Marcenaria', 'Armário', 900.00);

INSERT INTO tb_fornecedor VALUES('Serralheria', 'Corrimão',  400.00);
INSERT INTO tb_fornecedor VALUES('Serralheria', 'Portão', 1500.00);
INSERT INTO tb_fornecedor VALUES('Serralheria', 'Grade de proteção para janela',  800.00);

INSERT INTO tb_fornecedor VALUES('Limpeza e higiêne', 'Detergente',  5.00);
INSERT INTO tb_fornecedor VALUES('Limpeza e higiêne','Desinfetante',  40.00);
INSERT INTO tb_fornecedor VALUES('Limpeza e higiêne', 'Papel toalha', 60.00);

/**
*Exibe os dados da tabela tb_fornecedor.
*/
SELECT * FROM tb_fornecedor;

/**
 *1º Exemplo - Calcular os subtotais e total para cada segmento.
 */
 
--RESOLVENDO COM SUBQUERY
SELECT 
segmento,  
produto, 
valor
FROM
(
	SELECT segmento, produto, SUM(valor) valor
	FROM tb_fornecedor
	GROUP BY segmento, produto
	UNION ALL
	SELECT segmento, NULL AS  produto, SUM(valor) valor
	FROM tb_fornecedor
	GROUP BY segmento
	UNION ALL
	SELECT NULL AS segmento, NULL AS produto, SUM(valor) AS valor
	FROM tb_fornecedor
) CALCULO
ORDER BY segmento, produto;


--RESOLVENDO COM WITH

WITH CALCULO AS
(
	SELECT segmento, produto, SUM(valor) valor
	FROM tb_fornecedor
	GROUP BY segmento, produto
	UNION
	SELECT segmento, NULL AS  produto, SUM(valor) valor
	FROM tb_fornecedor
	GROUP BY segmento
	UNION
	SELECT NULL AS segmento, NULL AS produto, SUM(valor) AS valor
	FROM tb_fornecedor
)
SELECT 
segmento,  
produto, 
valor
FROM calculo
ORDER BY segmento, produto; 

/**
 *2º EXEMPLO - Para facilitarmos a interpretação do resultado da consulta, 
 *vamos indicar os subtotais e o total geral 
 */

--RESOLVENDO COM SUBQUERY
SELECT
COALESCE(segmento, 'TOTAL GERAL')  AS segmento,  
CASE 
WHEN(segmento IS NOT NULL AND produto IS NOT NULL) THEN produto 
WHEN(segmento IS NOT NULL AND produto IS NULL) THEN 'SUBTOTAL' || ' - '|| segmento
END AS produto,
valor
FROM
(
 SELECT segmento, produto, SUM(valor) valor
 FROM tb_fornecedor
 GROUP BY segmento, produto
 UNION
 SELECT segmento, NULL AS  produto, SUM(valor) valor
 FROM tb_fornecedor
 GROUP BY segmento
 UNION
 SELECT NULL AS segmento, NULL AS produto, SUM(valor) AS valor
 FROM tb_fornecedor
) CALCULO
ORDER BY
CASE
  WHEN(segmento IS NOT NULL) THEN CAST(0 AS INTEGER)
  ELSE CAST(1 AS INTEGER)
END, segmento,
CASE
  WHEN(produto IS NOT NULL) THEN CAST(0 AS INTEGER)
  ELSE CAST(1 AS INTEGER)
END,
produto;

--RESOLVENDO COM WITH

WITH CALCULO AS
(
 SELECT segmento, produto, SUM(valor) valor
 FROM tb_fornecedor
 GROUP BY segmento, produto
 UNION
 SELECT segmento, NULL AS  produto, SUM(valor) valor
 FROM tb_fornecedor
 GROUP BY segmento
 UNION
 SELECT NULL AS segmento, NULL AS produto, SUM(valor) AS valor
 FROM tb_fornecedor
)
SELECT
COALESCE(segmento, 'TOTAL GERAL') AS segmento,  
CASE 
WHEN(segmento IS NOT NULL AND produto IS NOT NULL) THEN produto 
WHEN(segmento IS NOT NULL AND produto IS NULL) THEN 'SUBTOTAL' || ' - '|| segmento
END AS produto,
valor
FROM calculo
ORDER BY
CASE
  WHEN(segmento IS NOT NULL) THEN CAST(0 AS INTEGER)
  ELSE CAST(1 AS INTEGER)
END,
segmento,
CASE
  WHEN(produto IS NOT NULL) THEN CAST(0 AS INTEGER)
  ELSE CAST(1 AS INTEGER)
END,
produto;
