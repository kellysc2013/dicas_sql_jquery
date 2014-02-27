/**
*DESCOMENTE O COMANDO DROP TABLE SOMENTE SE DESEJAR EXCLUIR A TABELA "tb_paciente".
*/
--DROP TABLE tb_paciente;


/**
*Para criar tabela uma tabela utilize o comando CREATE TABLE.
*/

CREATE TABLE tb_paciente
(
    prontuario serial ,
    nome character varying(255) NOT NULL ,
    data_nasc date NOT NULL ,
    sexo character(1) NOT NULL ,
    peso numeric(6,3),
    proc_cirurgico boolean NOT NULL
);


/**
*Para incluir um registro utilize o comando INSERT.
*/

INSERT INTO tb_paciente (prontuario, nome, data_nasc, sexo, peso, proc_cirurgico)
VALUES (DEFAULT , 'Maria Santos', '1984-04-20', 'f', 52.440, TRUE);

INSERT INTO tb_paciente(prontuario, nome, data_nasc, sexo, peso, proc_cirurgico)
VALUES (DEFAULT, 'João Silva', '1974-08-29', 'm', 80.520 , FALSE);

INSERT INTO tb_paciente(prontuario , nome , data_nasc , sexo , peso , proc_cirurgico)
VALUES(DEFAULT , 'Ana Moraes', '1982-10-30', 'f', 57.700, TRUE);


/**
*
*Mesmo se não for incluída uma coluna do tipo serial e o seu respectivo valor no comando INSERT, a sequéncia será preenchida 
*automaticamente da mesma forma.
*Neste caso, não vamos incluir a coluna "prontuario" e seu respectivo valor e a sequéncia continuará sendo preenchida
*automaticamente.
*/

INSERT INTO tb_paciente (nome, data_nasc, sexo, peso, proc_cirurgico) VALUES
('Patricia Duarte', '1990-11-05', 'f', 72.440, TRUE);

/**
*Executar o comando INSERT fornecendo somente os valores sem fornecer as colunas.
O primeiro valor será inserido na primeira coluna, o segundo valor será inserido na segunda coluna e assim por diante.
*/

INSERT INTO tb_paciente VALUES (DEFAULT, 'Bruno Pereira', '1980-06-23', 'f', 110.440, TRUE);


/**
*Se não incluirmos um dado em um campo opcional não haverá problema. Exemplo: campo peso.
*/

INSERT INTO tb_paciente (prontuario, nome, data_nasc, sexo, proc_cirurgico) 
VALUES (DEFAULT, 'Rosana Alves', '1979-04-13', 'f', TRUE);

INSERT INTO tb_paciente (prontuario, nome, data_nasc, sexo, peso, proc_cirurgico) 
VALUES (DEFAULT, 'Rafael Brito', '1979-05-14', 'f', NULL, TRUE);


/**
*Inserir mais de um registro com o comando insert
*/

INSERT INTO tb_paciente (prontuario, nome, data_nasc, sexo, peso, proc_cirurgico)
VALUES
(DEFAULT, 'Daniel Alves', '1992-12-06', 'm', 100.520, FALSE),
(DEFAULT, 'Priscila Monteiro', '1982-10-30', 'f', 64.280, TRUE),
(DEFAULT, 'Otaviano Costa', '1976-03-18', 'm', 144.520, FALSE);


/**
*Para exibir os registros de uma tabela utilize o comando SELECT 
*/

SELECT
    prontuario ,
    nome ,
    data_nasc ,
    sexo ,
    peso ,
    proc_cirurgico
FROM tb_paciente;

/**
*Em vez de declarar todas as colunas da tabela, utilize o símbolo de "*" para facilitar.
*/

SELECT * FROM tb_paciente;

/**
*Não precisamos selecionar todas as colunas, podemos escolher quais precisamos.
*/

SELECT nome ,data_nasc FROM tb_paciente;