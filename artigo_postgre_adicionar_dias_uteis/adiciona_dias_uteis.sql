/**
 *Esta função acrescenta dias úteis a uma data
 *
 *Ela faz cinco verificações:
 *	-Verifica se o dia é sabado ou domingo.
 *
 *	-Verifica se o dia é feriado federal: os feriados federais foram cadastrados 
 *	 na tabela "tab_feriado_federal".
 *
 *	-Verifica se o dia é feriado estadual: os feriados estaduais foram cadastrados
 *	 na tabela "tab_feriado_estadual".
 *
 *	-Verifica se o dia é feriado municipal.
 *	 A data dos feriado municipais devem ser cadastradas na tabela "tab_feriado_municipal". 
 *	 Como são muitos feriados munícipais eu cadastrei somente os feriados munícipais para 
 *	 as cidades de "São Paulo" e "Porto Alegre".
 *	 Cadestre novos feriados munícipais conforme a sua necessidade.
 * 
 *	-Verifica se o dia é feriado de pascoa, carnaval, pascoa, corpos Corpus Christi. 
 *	 Estes feriados não tem dia fixo. 
 *	 Esta função utiliza uma outra função chamada feriados_moveis(integer) para fazer a verificacão
 *       destes feriados.
 */
/*
    Como utilizar:

    SELECT adiciona_dias_uteis('data', quantidade_de_dias_uteis, codigo_da_cidade);

    O parâmetro data deve ser passado no formato aaaa-mm-dd.

    Veja os exemplos a seguir

    -Verifica a adição de dias úteis para a cidade de São Paulo.
    -O resultado da adição de 6 dias úteis, a partir de 04/07/2014 é 15/07/2014.
     pois não foram contados sábados, domingos e o feriado estadual "Revolução Constitucionalista",

     SELECT adiciona_dias_uteis('2014-07-04', 6, 1);
   
    -Verifica a adição de dias úteis para a cidade de Porto Alegre
    -O resultado da adição de 6 dias úteis, a partir 04/07/2014 é 14/07/2014,
     pois não foram contados sábados, domingos.
     
     SELECT adiciona_dias_uteis('2014-07-04', 6, 2);

    -Verifica a adição de dias úteis para a cidade de São Paulo.
    -O resultado da adição de 10 dias úteis, a partir de 17/03/2014 é 31/03/2014,
     pois não foram contados sábados, domingos.

     SELECT adiciona_dias_uteis('2014-03-17', 10, 1);

   -Verifica a adição de dias úteis para a cidade de Porto Alegre
   -O resultado da adição de 10 dias úteis, a partir de 17/03/2014 é 01/04/2014,
    pois não foram contados sábados, domingos e o feriado municipal de "Nossa Senhora dos Navegantes".

    SELECT adiciona_dias_uteis('2014-03-17', 10, 2);

   -Caso o código da cidade seja nulo, ocorrerá um erro.
   -Será exibida a seguinte mensagem de erro:
    O código da cidade deve ser preenchido.

    SELECT adiciona_dias_uteis('2014-12-20', 10, NULL);

   -Caso o código da cidade, não esteja cadatrado na tabela tab_cidades, ocorrerá um erro.
   -Será exibida a seguinte mensagem de erro:
    Não existe código para esta cidade. 
    Verifique o código correto na tabela tab_cidades.
    Caso não exista, você deve incluí-lo.

    SELECT adiciona_dias_uteis('2014-12-20', 10, 56);
*/

CREATE OR REPLACE FUNCTION adiciona_dias_uteis
(
	var_data date, 
	dias integer,
	var_cidade_id integer
)
  RETURNS date AS
$BODY$

DECLARE
        intervalo interval := '1 day';
        contador integer = 0;
	verifica_cidade boolean;
BEGIN

	SELECT INTO verifica_cidade 
	EXISTS
	(
		SELECT cidade_nome FROM tab_cidades WHERE cidade_id = var_cidade_id
	);
	/**
	*Verifica se foi passado o parâmetro com a identificação da cidade.
	*/
	IF(var_cidade_id IS NULL ) THEN
		RAISE EXCEPTION 'Preencha o código da cidade.';
	/**
	*Verifica se a cidade esta cadastrada na tabela tab_cidades.
	*/	
	ELSIF(verifica_cidade = FALSE) THEN
		RAISE EXCEPTION 
		'
		Não existe código para esta cidade. 
		Verifique o código correto na tabela tab_cidades.
		Caso não exista, você deve incluí-lo.
		';
	END IF;
		
	WHILE (contador < dias) dias LOOP

		/**
		 *Acrescenta o intervalo de um dia a data
		 */
		var_data :=  var_data + intervalo;

		/**
		 *Verifica se a data é sábado ou domingo. 
		 *Caso seja reinicia o loop através do comando "CONTINUE".
		 *Caso contrário executará a próxima verificação, ou seja verificará se o dia é feriado federal 
		 */
		IF ((EXTRACT(DOW FROM var_data) = 0) OR (EXTRACT(DOW FROM var_data) = 6)) THEN
			CONTINUE;
		END IF;

		/**
		 *Verifica se a data é feriado federal.
		 *Caso seja reinicia o loop através do comando "CONTINUE".
		 *Caso contrário executará a próxima verificação, ou seja verificará se o dia é feriado religioso  
		 */
		IF 
		(
			EXISTS 
			(
				SELECT feriado_federal FROM tab_feriado_federal 
				WHERE to_char(feriado_federal, 'mm-dd') = to_char(var_data, 'mm-dd')
			) = TRUE
		) THEN
			CONTINUE;
		END IF;


		/**
		 *Verifica se o feriado é pascoa, carnaval, sexta-feira santa e corpos Corpus Christi.
		 *Caso seja reinicia o loop através do comando "CONTINUE".
		 *Caso contrário executará a próxima instrução.  
		 */
		IF 
		(
			EXISTS 
			(
				SELECT data FROM feriados_moveis(EXTRACT(YEAR FROM var_data) :: integer)  
				WHERE data=  var_data
			) = TRUE
		) THEN
			CONTINUE;
		END IF;


		/**
		 *Verifica feriado estadual.
		 */ 
		IF(
			EXISTS 
			(
				SELECT feriado_estadual 
				FROM tab_feriado_estadual
				JOIN tab_cidades
				ON tab_feriado_estadual.sigla_estado = tab_cidades.sigla_estado
				WHERE cidade_id =  var_cidade_id AND
				to_char(feriado_estadual, 'mm-dd') = to_char(var_data, 'mm-dd')
			) = TRUE			 
		) THEN
			CONTINUE;
		END IF;

		/**
		 *Verifica feriado municipal
		 */ 
		IF(
			EXISTS 
			(
				SELECT feriado_municipal
				FROM tab_feriado_municipal
				WHERE cidade_id =  var_cidade_id AND
				to_char(feriado_municipal, 'mm-dd') = to_char(var_data, 'mm-dd')
			) = TRUE			 
		) THEN
			CONTINUE;
		END IF;

		/**
		 *Acrescenta um dia útil ao contador.
		 */
		contador := contador + 1;
		
		/**
		 *Exibe os valores das variaveis, durante o loop.
		 *Caso queira verificar os valores descomente os comandos "RAISE NOTICE" 
		 */

		 
		--RAISE NOTICE 'var_data:%', var_data;
		--RAISE NOTICE 'contador: %', contador;
		--RAISE NOTICE 'DOW dia da semana valor numerico:%', EXTRACT(DOW FROM var_data);
		--RAISE NOTICE '';
						

	END LOOP;
	RETURN var_data;
END
$BODY$
  LANGUAGE plpgsql STABLE
  COST 100;
ALTER FUNCTION data(character varying, integer)
  OWNER TO postgres;
