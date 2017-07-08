/**
 *Script do exemplo: Copiar dados de uma tabela para uma nova tabela no SQL SERVER DO BLOG DICAS SQL & JQUERY
 *Data: 25/06/2017 Hora: 05:48:25
 *Link do artigo: http://jquerydicas.blogspot.com.br/2017/06/copiar-dados-de-uma-tabela-para-uma.html
 
*Este post é dividido em duas partes:

1ª parte: damos um exemplo de como criar a tabela "tb_paciente";
2ª parte: vamos fazer a cópia da tabela "tb_paciente" chamada "tb_paciente_bkp"
3ª parte: vamos aprender a fazer a cópia da tabela "tb_paciente" chamada "tb_paciente_bkp_altera_col" com nome das 
colunas diferentes das  colunas da tabela original.
 
*/
 
--1ª Parte

/**
 *Criação da tabela "tb_paciente"
*/
 
 CREATE TABLE tb_paciente
(
    prontuario int IDENTITY(1,1) PRIMARY KEY,
    nome varchar(255) NOT NULL ,
    data_nasc date NOT NULL ,
    sexo character(1) NOT NULL ,
    peso numeric(6,3),
    proc_cirurgico bit NOT NULL
);

/**
 *Inclusão dos registros na tabela "tb_paciente"
 */
 
INSERT INTO tb_paciente (nome, data_nasc, sexo, peso, proc_cirurgico)
VALUES ('Maria Santos', '1984-04-20', 'f', 52.440, 1);

INSERT INTO tb_paciente(nome, data_nasc, sexo, peso, proc_cirurgico)
VALUES ('João Silva', '1974-08-29', 'm', 80.520 , 0);

INSERT INTO tb_paciente(nome , data_nasc , sexo , peso , proc_cirurgico)
VALUES('Ana Moraes', '1982-10-30', 'f', 57.700, 1);


/**
 *Seleção dos registros na tabela "tb_paciente"
 */
 
 SELECT
    prontuario ,
    nome ,
    data_nasc ,
    sexo ,
    peso ,
    proc_cirurgico
FROM tb_paciente;

 --2ª Parte

/**
 * A sentença SQL abaixo, cria a cópia da tabela "tb_paciente". Esta tabela se chamará "tb_paciente_bkp ".
 */
SELECT * INTO tb_paciente_bkp FROM tb_paciente;


 --3ª Parte
/**
 * A sentença SQL abaixo, cria a cópia da tabela "tb_paciente". Esta tabela se chamará 
 *"tb_paciente_bkp_altera_col".
 * Perceba que as colunas foram criadas com nomes diferentes da original, para isso utilizamos "AS" ao lado do
 * do novo nome de cada coluna. 
 */
SELECT
    prontuario  AS  pac_prontuario ,
    nome  AS  pac_nome,
    data_nasc   AS  pac_data_nasc ,
    sexo  AS  pac_sexo,
    peso  AS  pac_peso,
    proc_cirurgico  AS  pac_proc_cirurgico
INTO  tb_paciente_bkp_altera_col 
FROM  tb_paciente;


 --4ª Parte
/*
*Existe a possibilidade de criar uma nova tabela, apena com alguns registros da tabela original, 
*para isso utilizaremos um filtro, representado pelo comando "WHERE".
*Vamos criar a tabela "tb_paciente_bkp_filt", a partir da tabela "tb_paciente", 
*e vamos filtrar os pacientes, somente do sexo feminino,  ou seja,  sexo = 'f'.
*/

SELECT
    prontuario, 
    nome, 
    data_nasc, 
    sexo, 
    peso, 
    proc_cirurgico 
INTO  tb_paciente_bkp_filt   
FROM  tb_paciente 
WHERE  sexo = 'f';
