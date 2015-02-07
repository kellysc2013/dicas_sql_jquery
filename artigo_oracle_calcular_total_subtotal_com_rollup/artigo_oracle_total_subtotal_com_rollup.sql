/**
*Cria a tabela tb_fornecedor.
*/
CREATE TABLE tb_fornecedor
(
    segmento character varying(70),
    produto character varying(70),
    valor numeric
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
*1º Exemplo.
*/

/**
*Calcula o subtotal para cada segmento e total geral.
*/


SELECT
    segmento,
    produto,
    SUM(valor)
FROM tb_fornecedor
GROUP BY ROLLUP(segmento, produto);

/**
*2º Exemplo.
*/

/**
*Para facilitarmos a interpretação do resultado da consulta
*vamos alterar a primeira coluna indicando os subtotais e o total geral.
*/

SELECT
CASE
WHEN (segmento IS NULL AND produto IS NULL) 
  THEN 'Total Geral'
WHEN (segmento IS NOT NULL AND produto IS NULL) 
  THEN  'Subtotal' || ' - ' || segmento  
ELSE segmento
END AS segmento,
produto,
SUM(valor) AS valor
FROM tb_fornecedor
GROUP BY ROLLUP (
segmento, produto
);

/**
*Também podemos indicar o total geral na primeira coluna e os subtotais na segunda coluna.
*/


SELECT
CASE
WHEN (segmento IS NULL AND produto IS NULL) 
  THEN 'Total Geral'
ELSE segmento
END AS segmento,
CASE
WHEN (segmento IS NOT NULL AND produto IS NULL) 
  THEN 'Subtotal' || ' - ' || segmento
ELSE produto 
END AS produto,
SUM(valor) AS valor
FROM tb_fornecedor
GROUP BY ROLLUP (
segmento, produto
);

/**
*3º Exemplo.
*/

/**
*Ordenar as colunas produto e segmento utilizando order by
*/

SELECT
COALESCE(segmento, 'TOTAL GERAL')  AS segmento,   
CASE
 WHEN ((segmento IS NOT NULL) AND (produto IS NULL))
  THEN CONCAT('Subtotal - ', segmento)
  WHEN (segmento IS NOT NULL AND produto IS NOT NULL) 
  THEN produto
END AS produto,
valor FROM
(
 SELECT
 segmento, 
 CASE
  WHEN(segmento IS NOT NULL) THEN 0
  ELSE 1
 END AS segmento_ordem, 
 produto, 
 CASE
  WHEN(produto IS NOT NULL) THEN 0
 ELSE 1
 END  AS produto_ordem,
 SUM(valor) AS valor
 FROM tb_fornecedor
 GROUP BY ROLLUP(segmento, produto)
) TOTAL
ORDER BY
segmento,
segmento_ordem,
produto_ordem,
produto;
