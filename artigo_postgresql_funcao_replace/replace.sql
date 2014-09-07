/**
 *Criação da tabela tb_veiculo
 */
CREATE TABLE tb_veiculo
(
  modelo_veiculo character varying(25)
);

/**
 *Incluir registros na tabela tb_veiculo
 */
INSERT INTO tb_veiculo VALUES 
('GM/AUTO ARTE COLUMBA'),
('GM/CHEVR.D 20 CUSTOM L'),
('VW/BMB 31.230 CNC 8X4'),
('VW/BMB 31.320 CLC CM');


/**
 *Criação da tabela tb_mensagem
 */
CREATE TABLE tb_mensagem
(
  data date,
  mensagem character varying(100)
);

/**
 *Incluir registros na tabela tb_mensagem
 */
INSERT INTO tb_mensagem VALUES ('2014-09-07','Filho de gato é gatinho');


/**
 *Exibir os registros da tabela tb_veiculo
 */
SELECT modelo_veiculo FROM tb_veiculo;


/**
 *Exibir os registros da tabela tb_veiculo
 */
SELECT mensagem FROM tb_mensagem;


--1º EXEMPLO
/**
 *Substituir VW por Wolkswagen
 */
SELECT
modelo_veiculo,
REPLACE(modelo_veiculo, 'VW', 'Wolkswagen') AS substituicao  
FROM tb_veiculo;

--2º EXEMPLO
/**
 *Substituir VW por Wolkswagen e GM por General Motors
 */

SELECT
modelo_veiculo,
CASE
    WHEN (modelo_veiculo LIKE '%VW%') 

        THEN REPLACE(modelo_veiculo, 'VW', 'Wolkswagen')
    WHEN (modelo_veiculo LIKE '%GM%') 

       THEN REPLACE(modelo_veiculo, 'GM', 'General Motors')   
END  AS substituicao
FROM tb_veiculo;

--3º EXEMPLO
/**
 *Substituir o caractere "o" pelo caractere "a" de uma mensagem
 */
SELECT
data,
mensagem, 
REPLACE(mensagem, 'o', 'a') AS nova_mensagem
FROM tb_mensagem;
