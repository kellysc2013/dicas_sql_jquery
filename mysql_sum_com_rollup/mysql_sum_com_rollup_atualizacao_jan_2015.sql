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
*Calcula o subtotal para cada segmento e total para cada segmento.
*/
SELECT
    segmento,
    produto,
    SUM(valor)
FROM tb_fornecedor
GROUP BY  segmento, produto WITH ROLLUP;


/**
*2º Exemplo.
*/

/**
*Para facilitarmos a interpretação do resultado da consulta
*vamos alterar a primeira coluna.
*/

SELECT
    IF
    (
      segmento IS NULL,
      'Total Geral',
      IF (produto IS NULL, CONCAT('Subtotal - ', segmento), segmento)
    ) AS segmento,
    produto,
    SUM(valor) as valor
FROM tb_fornecedor
GROUP BY  segmento, produto WITH ROLLUP;


/**
*3º Exemplo.
*/

/**
*
*Não é possível utilizar "WITH ROLLUP" com "ORDER BY" na mesma consulta,
*caso seja necessário ordenar colunas,teremos que criar uma subconsulta.
*Neste exemplo, vamos colocar em ordem as colunas "segmento" e "produto".
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
 produto, 
 SUM(valor) AS valor
 FROM tb_fornecedor
 GROUP BY segmento, produto WITH ROLLUP
) TOTAL
ORDER BY
CASE
 WHEN(segmento IS NOT NULL) THEN 0
 ELSE 1
END,
segmento DESC,
CASE
 WHEN(produto IS NOT NULL) THEN 0
 ELSE 1
END,
produto DESC;
