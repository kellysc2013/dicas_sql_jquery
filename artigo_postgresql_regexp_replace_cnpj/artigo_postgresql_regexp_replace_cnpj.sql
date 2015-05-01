/**
 *Cria a tabela tb_cadastro
 */
CREATE TABLE tb_cadastro
(
    cnpj varchar(14),
    razao_social varchar(255)		
);

/**
 *Inclui os registros na tabela tb_cadastro
 */
INSERT INTO tb_cadastro VALUES ('29169120000107', 'A&B Sapataria Ltda'); 
INSERT INTO tb_cadastro VALUES ('26663604000101', 'Confecções X&Y Ltda');

/**
 *Exibe os registros na tabela tb_cadastro
 */
SELECT * FROM tb_cadastro;

/**
 *Exemplo: formatação do CNPJ
 */
SELECT  
REGEXP_REPLACE (cnpj, '(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})', '\1.\2.\3/\4-\5')   AS cnpj 
FROM tb_cadastro;
