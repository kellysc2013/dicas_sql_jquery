/**
*Cria a tabela tb_fornecedor.
*/
CREATE TEMP TABLE tb_fornecedor
(
    produto character varying(70), 
    segmento character varying(70),
    data date,
    valor numeric    
);


/**
*Inclui os dados na tabela tb_fornecedor.
*/
INSERT INTO tb_fornecedor VALUES('DVD', 'Papelaria e informática', '2013-09-12', 2.00);
INSERT INTO tb_fornecedor VALUES('HD 500 GB', 'Papelaria e informática', '2013-10-20', 300.00);
INSERT INTO tb_fornecedor VALUES('Tonner', 'Papelaria e informática', '2013-11-01', 250.00);
INSERT INTO tb_fornecedor VALUES('Cadeira', 'Marcenaria', '2013-09-19', 50.00);
INSERT INTO tb_fornecedor VALUES('Mesa', 'Marcenaria', '2013-10-21', 600.00);
INSERT INTO tb_fornecedor VALUES('Armário', 'Marcenaria', '2013-11-02', 900.00);
INSERT INTO tb_fornecedor VALUES('Corrimão', 'Serralheria', '2013-09-12', 400.00);
INSERT INTO tb_fornecedor VALUES('Portão', 'Serralheria', '2013-10-22', 1500.00);
INSERT INTO tb_fornecedor VALUES('Grade de proteção para janela', 'Serralheria', '2013-11-03', 800.00);
INSERT INTO tb_fornecedor VALUES('Detergente', 'Limpeza e higiêne', '2013-09-20', 5.00);
INSERT INTO tb_fornecedor VALUES('Desinfetante', 'Limpeza e higiêne', '2013-11-23', 40.00);
INSERT INTO tb_fornecedor VALUES('Papel toalha', 'Limpeza e higiêne', '2013-11-04', 60.00);

/**
*Exibe os dados da tabela tb_fornecedor.
*/
SELECT * FROM tb_fornecedor;
