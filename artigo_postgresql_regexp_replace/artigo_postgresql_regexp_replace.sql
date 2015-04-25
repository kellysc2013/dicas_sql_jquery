/**
 *Atenção!!! Descomente o comando "DROP" (próxima linha), somente se precisar apagar a tabela tb_endereço
 *DROP TABLE tb_endereco
 */

/**
 *Cria a tabela tb_endereco
 */
CREATE TABLE tb_endereco
(	endereco varchar(255),
	cep varchar(8)
);

/**
 *Insere os registros na tabela tb_endereco
 */
INSERT INTO tb_endereco VALUES ('RUA DA PAZ', '04954123');
INSERT INTO tb_endereco VALUES('AVENIDA PAULISTA', '04312222');

/**
 *Exibe os registros da tabela tb_endereco
 */
SELECT * FROM tb_endereco;

/**
*1º exemplo - Formatar a coluna CEP da tabela tb_endereco
*/
SELECT
endereco,  
REGEXP_REPLACE (cep, '([0-9]{5})([0-9]{3})', '\1-\2') as cep 
FROM 
tb_endereco;

/**
*2º exemplo - Também formata a coluna CEP, mas utiliza a expressão [:digit:] ao invés de [0-9]
*/
SELECT
endereco,  
regexp_replace(cep,'([[:digit:]]{5})([[:digit:]]{3})','\1-\2') as cep
FROM 
tb_endereco;

/**
 *3º exemplo
 *Para facilitar, podemos substituir a expressão "[[:digit:]]" que indica a utilização 
 *de caracteres numéricos de 0 até 9, 
 *pela expressão abreviada "\d". O resultado será o mesmo.
 */
SELECT  REGEXP_REPLACE (cep, '(\d{5})(\d{3})', '\1-\2') AS cep
FROM tb_endereco;

