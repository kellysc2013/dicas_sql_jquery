/*
Objetivo deste script: exemplo de criação de uma trigger no postgresql.

A cada inclusão, alteração ou exclusão de um registro na tabela "tb_clientes"
será gerado um registro de log na tabela "tb_hist_operacao"
*/

/*
Exclui a tabela tb_clientes, caso existir.
Importante!!! Descomente este comando somente se quiser excluir a tabela "tb_clientes".  
*/
--DROP TABLE IF EXISTS tb_clientes;


/*
Cria a tabela de clientes, chamada "tb_clientes".
*/
CREATE TABLE tb_clientes 
(
	id integer, 
	name varchar(255),
	CONSTRAINT pk_id PRIMARY KEY(id)
);

/*
Exclui a tabela "tb_hist_operacao", caso existir.
Importante!!! Descomente este comando somente se quiser excluir a tabela "tb_hist_operacao".
*/
--DROP TABLE IF EXISTS tb_hist_operacao;


/*Cria a tabela de historico de operacao, chamada tb_hist_operacao*/
CREATE TABLE tb_hist_operacao 
(  
	operacao varchar(100),
	data_hora_criacao timestamp without time zone,
	id_cliente int,
	nome_antigo varchar(255),
	nome_novo varchar(255)	
);


/*
Exclui a função fn_historico()
Importante!!! Descomente este comando somente se quiser excluir a função fn_historico()
*/
--DROP FUNCTION IF EXISTS fn_historico();


/*
Cria a função "fn_historico".
Está função será utilizada pela TRIGGER. No POSTGRESQL devemos criar primeiro uma função antes de criar a TRIGGER.
Repare que o retorno da função "fn_historico()" é uma trigger.
A trigger executará esta função.
Esta função inclui registros de log na tabela "tb_hist_operacao".
*/

--Criação da função fn_historico()
CREATE OR REPLACE FUNCTION fn_historico()
--Retorna uma trigger
RETURNS trigger AS
$BODY$
	BEGIN
		/*A variável "TG_OP" é uma variável especial que armazena o valor 
		"INSERT" para inclusão
		"UPDATE" para alteração
		"DELETE" para deleção
		*/
		IF (TG_OP ='INSERT') THEN		
			INSERT INTO tb_hist_operacao(operacao, data_hora_criacao, id_cliente, nome_novo) VALUES(TG_OP, NOW(), NEW.id, NEW.NAME);
			RETURN NEW;			
		ELSIF (TG_OP ='UPDATE') THEN		
			INSERT INTO tb_hist_operacao(operacao, data_hora_criacao, id_cliente, nome_antigo, nome_novo) 
			VALUES(TG_OP, NOW(), OLD.id, OLD.NAME, NEW.name);					
			RETURN NEW;
		ELSIF (TG_OP ='DELETE') THEN
			INSERT INTO tb_hist_operacao(operacao, data_hora_criacao, id_cliente, nome_antigo) VALUES(TG_OP, NOW(), OLD.id, OLD.name);			
			RETURN OLD;
		END IF;
	END;
$BODY$
LANGUAGE 'plpgsql';

/*
Exclui a trigger "tr_historico".
Importante!!! Descomente este comando somente se quiser excluir a trigger "tr_historico".
*/
--DROP TRIGGER IF EXISTS tr_historico ON tb_clientes;

/*
Cria a trigger "tr_historico" que executa a função fn_historico() depois da inclusão, alteração ou exclusão. 
um registro na tabela "tb_clientes".
*/

--Cria a trigger "tr_historico".
CREATE TRIGGER tr_historico
--Será executada uma função depois de cada insert, update ou delete na tabela "tb_clientes"
AFTER INSERT OR UPDATE OR DELETE ON tb_clientes
--Para cada registro
FOR EACH ROW                 
	--Executará a função fn_historico()
	EXECUTE PROCEDURE fn_historico(); 

/*
Deleta registros da tabela "tb_clientes".
Importante!!! Descomente este comando somente se quiser excluir os registros da tabela "tb_clientes". 
*/
--DELETE FROM tb_clientes;

/*
Deleta os registros da tabela de historico, chamada "tb_hist_operacao".
Importante!!! Descomente este comando somente se quiser excluir os registros da tabela "tb_hist_operacao".
*/
--DELETE FROM tb_hist_operacao;


/*
Insere os registros na tabela tb_clientes.
*/
INSERT INTO tb_clientes(id, name) VALUES
(1,'Paulo Silva'),
(2,'Ana Oliveira'),
(3,'Kelly Costa');

/*
Após a inclusão, a tabela "tb_clientes" possui três registros.
 id |     name
----+--------------
  1 | Paulo Silva
  2 | Ana Oliveira
  3 | Kelly Costa  
(3 registros)


A tabela "tb_hist_operacao" possui três registros - indicando que três registros foram inseridos.
através do comando insert

 operacao
----------
 INSERT
 INSERT
 INSERT 
(3 registros)
*/

/*Atualiza o registro na tabela "tb_clientes" com id = 2.*/
UPDATE tb_clientes SET name = 'Ana Oliveira Santos' WHERE id = 2;

/*
Após a atualização do registro da tabela "tb_clientes" o nome que possui id igual a 2 foi atualizado de 
"Ana Oliveira" para "Ana Oliveira Santos".

 id |        name
----+---------------------
  2 | Ana Oliveira Santos


A tabela "tb_hist_operacao" possui um novo registro - indicando que um registro foi atualizado através do comando update.

 operacao
----------
 INSERT
 INSERT
 INSERT
 UPDATE
(4 registros)
*/



/*
Deleta um registro na tabela tb_clientes que possui id igual a 3
*/

/*
Importante!!! Descomente este comando apenas se quiser excluir o registro 
com id igual a 3 da tabela "tb_clientes"
*/
--DELETE FROM tb_clientes WHERE id = 3;

/*
Após a exclusão do registro a tabela "tb_clientes" possui 2 registros.

 id |     name
----+--------------
  1 | Paulo Silva
  2 | Ana Oliveira
(2 registros)

A tabela "tb_hist_operacao" possui um novo registro - indicando que um registro foi excluído através do comando "delete".

 operacao
----------
 INSERT
 INSERT
 INSERT
 UPDATE
 DELETE
(5 registros)
*/

/*Seleciona os registros da tabela "tb_clientes"*/
SELECT * FROM tb_clientes;

/*Seleciona os registros com as operações da tabela "tb_hist_operacao"*/
SELECT operacao, data_hora_criacao, id_cliente, nome_antigo , nome_novo FROM tb_hist_operacao;
