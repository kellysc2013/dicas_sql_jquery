/**
 *Exclui a tabela "tb_alunos" (descomente somente se precisar excluir a tabela "tb_alunos")
 *DROP TABLE tb_alunos;
 */

/**
 *Cria a tabela "tb_alunos"
 */
CREATE TABLE tb_alunos
(
   cpf varchar(11),
   nome varchar(255) 
);

/**
 *Insere a tabela "tb_alunos"
 */
INSERT INTO tb_alunos VALUES ('15425714587', 'Carlos Andrade');
INSERT INTO tb_alunos VALUES ('59212347812', 'Ana Oliveira');

/**
 *Exibe a tabela "tb_alunos"
 */
SELECT * FROM tb_alunos;

/**
 *1 º exemplo: como formatar CEP
 */
SELECT  
regexp_replace(cpf,'([0-9]{3})([0-9]{3})([0-9]{3})([0-9]{2})','\1.\2.\3-\4') AS CEP
FROM tb_alunos;

/**
 *2 º exemplo: como formatar CEP
 *Substituindo a expressão "0-9" que indica a utilização de caracteres numéricos de 0 até 9, 
 *pela expressão [:digit:]. O resultado será o mesmo. 
 */
SELECT  
REGEXP_REPLACE (cpf, '([[:digit:]]{3})([[:digit:]]{3})([[:digit:]]{3})([[:digit:]]{2})', '\1.\2.\3-\4') AS cpf 
FROM tb_alunos;

/**
 *3º exemplo
 *Para facilitar, podemos substituir a expressão "[[:digit:]]" que indica a utilização 
 *de caracteres numéricos de 0 até 9, 
 *pela expressão abreviada "\d". O resultado será o mesmo.
 */
SELECT  
REGEXP_REPLACE (cpf,  '(\d{3})(\d{3})(\d{3})(\d{2})',  '\1.\2.\3-\4') AS cpf 
FROM tb_alunos;
