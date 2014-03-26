/*
Calcula os feriados móveis: páscoa e os feriados derivados derivados desta data

Importante!!! Esta função será utilizada pela função "adiciona_dias_uteis".

Os feriados derivados desta data são:
    -Terça feira de Carnaval: páscoa -47 dias 
    -Sexta feira da Paixão:   páscoa -2 dias 
    -Corpus Christi:          páscoa +60 dias

Utiliza o algorítmo de Meeus/Jones/Butcher

Esta função é encontrada em:
http://pt.wikipedia.org/wiki/C%C3%A1lculo_da_P%C3%A1scoa#Algoritmo_de_Meeus.2FJones.2FButcher

Exemplo de utilização

No parâmetro ano devemos passar um valor numérico.

SELECT descricao, data FROM feriados_moveis(ano)

Exemplo:

SELECT descricao, data FROM feriados_moveis(2014)  
*/

CREATE OR REPLACE FUNCTION feriados_moveis(IN ano integer, OUT descricao character varying, OUT data date)
  RETURNS SETOF record AS
$BODY$ 

DECLARE 
    a integer; 
    b integer; 
    c integer; 
    d integer; 
    e integer; 
    f integer; 
    g integer; 
    h integer; 
    i integer; 
    k integer; 
    l integer; 
    m integer; 
    dia integer; 
    mes integer;
    pascoa date; 

BEGIN 

        a = ano % 19; 
        b = ano / 100; 
        c = ano % 100; 
        d = b / 4; 
        e = b % 4; 
        f = (b + 8) / 25; 
        g = (b - f + 1) / 3; 
        h = (19 * a + b - d - g + 15) % 30; 
        i = c / 4; 
        k = c % 4; 
        l = (32 + 2 * e + 2 * i - h - k) % 7; 
        m = (a + 11 * h + 22 * l) / 451; 
        mes = (h + l - 7 * m + 114) / 31; 
        dia = ((h + l - 7 * m + 114) % 31) + 1; 

	pascoa := to_date(ano || '-' || mes || '-' || dia, 'yyyy-mm-dd'); 
        RETURN QUERY SELECT 'Pascoa':: character varying, pascoa ;     
        RETURN QUERY SELECT 'Carnaval':: character varying, pascoa -47 ;
        RETURN QUERY SELECT 'Paixao':: character varying, pascoa -2 ;                 
        RETURN QUERY SELECT 'Corpus Christi':: character varying, pascoa + 60 ;
END; 
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION feriados_moveis(integer)
  OWNER TO postgres;
