--Descomente o comando DROP apenas se quiser excluir a tabela "esporte"
--DROP TABLE IF EXISTS esporte;

--Descomente o comando DROP apenas se quiser excluir a tabela "esporte" no schema "scm_teste"
--DROP TABLE IF EXISTS scm_teste.esporte;

--Exclui o schema "scm_teste"
--DROP SCHEMA scm_teste;

--Cria a tabela "esporte"
CREATE TABLE esporte
(
	id integer,
	modalidade_desc character varying(50),
	observacao text	
);

--Visualiza a tabela "esporte"
SELECT * FROM esporte;

--Cria o schema "scm_teste"
CREATE SCHEMA scm_teste;

--Cria a tabela "esporte" no schema "scm_teste" 
CREATE TABLE scm_teste.esporte
(
	id integer,
	modalidade_desc character varying(50),
	observacao text	
);

--Visualiza a tabela "esporte" do schema "scm_teste"
SELECT * FROM scm_teste.esporte;

--Cria a função "fnc_renomear_multiplas_colunas"
CREATE OR REPLACE FUNCTION fnc_renomear_multiplas_colunas
( 
	--Parâmetro que armazena o nome da tabela
	nome_da_tabela character varying, 
	
	/*
	Parâmetro do tipo array. Este é um array multidimensional. 
	No primeiro parâmetro deve ser passado o nome atual da coluna.
	No segundo parâmetro deve ser passado o novo nome da coluna.	
	*/
	nome_colunas character varying[],
	
	/*
	Parametro que armazena o schema.
	Caso não seja usado nenhum parametro, 
	será utilizado o schema padrão do postgresql "public". 
	*/
	schm character varying DEFAULT 'public'	
)

RETURNS character varying
LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
DECLARE
	/*string que armazena o comando que renomeia a(s) coluna(s). "ALTER TABLE...RENAME...TO"*/
	str_renomeia_coluna text;
	/*armazena o retorno da execução, se as colunas foram renomeadas com sucesso ou não*/	
	msg character varying;
	/*armazena o retorno da verificação de existência da tabela*/	
	verifica_tabela boolean;
BEGIN
	
	/*Verifica se a tabela existe*/
	SELECT
	EXISTS
	(
		SELECT table_name
		FROM information_schema.tables 
		WHERE 
		table_name = quote_ident(nome_da_tabela) AND table_schema = quote_ident(schm)
	) INTO  verifica_tabela;
	
	--Comentario para debug
	--RAISE NOTICE 'verifica_tabela %', verifica_tabela;	
	
	/*
	Se a tabela não existir, 
	interrompe a execução e retorna uma mensagem de erro.
	*/
	IF(verifica_tabela = false) THEN
		msg := FORMAT('Tabela %s não existe. ', nome_da_tabela);
		RETURN msg;
	END IF;	
	
	/*
	Loop, que gera o comando de alteração de colunas
	e atribui a variavel "str_renomeia_coluna"
	*/	
	FOR i IN array_lower(nome_colunas, 1) .. array_upper(nome_colunas, 1) LOOP
		str_renomeia_coluna := 
		CONCAT
		(
			str_renomeia_coluna , 
			FORMAT
			(
				'ALTER TABLE %s.%s RENAME  %s TO %s; ', 
				schm, 
				nome_da_tabela, 
				quote_ident(nome_colunas[i][1]), 
				quote_ident(nome_colunas[i][2])
			)
		);					
	END LOOP;
	
	--Comentario para debug	
	--RAISE NOTICE '%', str_renomeia_coluna;	
	
	BEGIN
	
		--Executa o comando que faz a alteração de coluna(s).
		EXECUTE str_renomeia_coluna;
		
		/*
		Caso haja algum erro na execução do comando 
		que renomeia a(s) coluna(s) retorna uma 
		mensagem com erro. 
		*/
		EXCEPTION
		WHEN OTHERS THEN
			msg := FORMAT('Não foi possível renomear as colunas.Erro: %s. Código do erro: %s. ', SQLERRM, SQLSTATE);                    
			RETURN msg;
	END;
	
	/*
	Caso não haja nenhum erro retorna uma mensagem
	que o comando foi executado com sucesso	
	*/
	msg := FORMAT('COLUNA(S) ALTERADA COM SUCESSO');
	RETURN msg;
END
$BODY$;



/*
1º Exemplo
Executa a função: fnc_renomear_multiplas_colunas
Observação: 3º parâmetro não é obrigatório (neste caso 'public')
*/
SELECT fnc_renomear_multiplas_colunas
(
	'esporte',
	array
	[
	array['id','cod'],
	array['modalidade_desc', 'modalidade_descricao'],
	array['observacao', 'obs']	
	]
	::varchar[][],
	'public'	
);

--Visualiza a tabela "esporte"
SELECT * FROM esporte;

/*
2º Exemplo
Executa a função: fnc_renomear_multiplas_colunas
Observação: 3º parâmetro não foi declarado pois não é obrigatório.
Quando não declarado o schema será considerado public.
*/
SELECT fnc_renomear_multiplas_colunas
(
	'esporte',
	array
	[
	array['id','cod'],
	array['modalidade_desc', 'modalidade_descricao'],
	array['observacao', 'obs']	
	]
	::varchar[][]
);

--Visualiza a tabela "esporte"
SELECT * FROM esporte;


/*
3º Exemplo
Executa a função: fnc_renomear_multiplas_colunas
Observação: neste caso serão renomeadas colunas
do schema 'scm_teste'.  
*/
SELECT fnc_renomear_multiplas_colunas
(
	'esporte',
	array
	[
	array['id','cod'],
	array['modalidade_desc', 'modalidade_descricao'],
	array['observacao', 'obs']	
	]
	::varchar[][],
	'scm_teste'	
);

--Visualiza a tabela "esporte" do schema "scm_teste"
SELECT * FROM scm_teste.esporte;


/*
3º Exemplo
Executa a função: fnc_renomear_multiplas_colunas
Será retornado um erro pois a tabela 'esportey' não existe.   
*/
SELECT fnc_renomear_multiplas_colunas
(
	'esportey',
	array
	[
	array['id','cod'],
	array['modalidade_desc', 'modalidade_descricao'],
	array['observacao', 'obs']	
	]
	::varchar[][]
);


/*
4º Exemplo
Executa a função: fnc_renomear_multiplas_colunas
Será retornado um erro pois a coluna 'modalidade_descx' não existe.   
*/
SELECT fnc_renomear_multiplas_colunas
(
	'esporte',
	array
	[
	array['id','cod'],
	array['modalidade_descx', 'modalidade_descricao'],
	array['observacao', 'obs']	
	]
	::varchar[][]
);
