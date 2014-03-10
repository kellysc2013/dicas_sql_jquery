/**
*Caso queira excluir a tabela descomente os comando
*/
--DROP TABLE IF EXISTS tb_empregados;
--DROP TABLE IF EXISTS tb_funcionarios;

/**
*Criação da tabela "tb_empregados".
*/
CREATE TABLE tb_empregados
(
registro_id serial,
nome character varying(255)
);

/**
*Inclui os registros na "tb_empregados".
*/
INSERT INTO tb_empregados(registro_id, nome)
VALUES
(DEFAULT, 'Aline Santos'),
(DEFAULT, 'Carlos Silva'),
(DEFAULT, 'Rodrigo Paiva');

/**
*Exibe os registros na "tb_empregados".
*/
SELECT * FROM tb_empregados;

/**
*Renomear a tabela "tb_empregados" para "tb_funcionarios"
*/
ALTER TABLE tb_empregados RENAME TO tb_funcionarios;

/**
*Exibe os registros na "tb_funcionários".
*/
SELECT * FROM tb_funcionarios;