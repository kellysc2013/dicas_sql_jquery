/**
*2º Exemplo- Adicionar 6 dias úteis a data 04/07/2014 para a cidade de Porto Alegre.
*
*Na tabela tab_cidades somente estão cadastradas as cidades de São Paulo e Rio Grande do Sul.
*Caso queira utilizar esta função para outras cidades, cadastre a nova cidade na tabela tab_cidades.
*Caso esta nova cidade tenha feriados municipais, cadastre seus feriados na tabela tab_feriado_municipal
*/
SELECT adiciona_dias_uteis('2014-07-04', 6, 2);
