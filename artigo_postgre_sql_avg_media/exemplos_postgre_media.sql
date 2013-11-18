/**
*Início do 1º exemplo
*/

/*Calcula a média da coluna valor*/

SELECT AVG(valor) FROM tb_fornecedor;

/*Calcula a média da coluna valor, e exibe o nome da coluna como média (alias).*/

SELECT AVG(valor) AS media FROM tb_fornecedor;

/**
*Fim do 1º exemplo
*/


/**
*Início do 2º exemplo
*/

/*Cálculo da média por segmento*/

SELECT segmento, AVG(valor) AS media
FROM tb_fornecedor 
GROUP BY segmento;

/*Cálcula da média por segmento, e ordenar a média em ordem crescente, ou seja, do valor menor para o maior*/

SELECT 
segmento, 
AVG(valor) AS media
FROM tb_fornecedor 
GROUP BY segmento
ORDER BY media;

/*Cálcula da média por segmento, e ordenar a média em ordem decrescente, ou seja, do valor maior para o menor*/

SELECT 
segmento, 
AVG(valor) AS media
FROM tb_fornecedor 
GROUP BY segmento
ORDER BY media DESC;

/**
*Fim do 2º exemplo
*/


/**
*Início do 3º exemplo
*/

/*Para executarmos o 3º exemplo vamos acrescentar a coluna quantidade a tabela tb_fornecedor*/

/*Adicionamos a coluna quantidade.*/

ALTER TABLE tb_fornecedor ADD COLUMN quantidade integer;

/*Atualizamos os dados da coluna quantidade.*/

UPDATE tb_fornecedor SET quantidade = 10 WHERE produto = 'DVD';
UPDATE tb_fornecedor SET quantidade =  2 WHERE produto = 'HD 500 GB';
UPDATE tb_fornecedor SET quantidade =  2 WHERE produto = 'Tonner';
UPDATE tb_fornecedor SET quantidade =  3 WHERE produto = 'Cadeira';
UPDATE tb_fornecedor SET quantidade =  1 WHERE produto = 'Mesa';
UPDATE tb_fornecedor SET quantidade =  1 WHERE produto = 'Armário';
UPDATE tb_fornecedor SET quantidade =  1 WHERE produto = 'Corrimão';
UPDATE tb_fornecedor SET quantidade =  1 WHERE produto = 'Portão';
UPDATE tb_fornecedor SET quantidade =  2 WHERE produto = 'Grade de proteção para janela';
UPDATE tb_fornecedor SET quantidade =  3 WHERE produto = 'Detergente';
UPDATE tb_fornecedor SET quantidade =  5 WHERE produto = 'Desinfetante';
UPDATE tb_fornecedor SET quantidade =  2 WHERE produto = 'Papel toalha';


/*Após a atualização, podemos verificar as alterações na tabela.*/

SELECT * FROM tb_fornecedor;

/*Calculo das médias por segmento levando em consideração a quantidade*/

SELECT 
segmento, 
AVG(quantidade * valor) AS media 
FROM tb_fornecedor 
GROUP BY segmento
ORDER BY media;

/**
*Fim do 3º exemplo
*/



/**
*Início do 4º exemplo
*/

/*
Para extrair o mês e o ano de uma data podemos utilizar as funções "extract" ou "date_part". 
As duas funções são equivalentes no postgresql.
*/

SELECT
data, 
date_part('month', data) AS mes,
date_part('year', data) AS ano  
FROM tb_fornecedor;

SELECT
data, 
date_part('month', data) AS mes,
date_part('year', data) AS ano  
FROM tb_fornecedor;

/*Calculo da média das despesas para os os meses 9, 10, 11 de 2013, utilizando extract*/

SELECT 
extract(month from data) AS mes,
AVG(quantidade * valor) AS media
FROM tb_fornecedor
WHERE extract(year from data) = 2013 
GROUP BY mes
ORDER BY mes;

/*Calculo da média das despesas para os os meses 9, 10, 11 de 2013, utilizando date_part*/
SELECT 
date_part('month', data) AS mes,
AVG(quantidade * valor) AS media
FROM tb_fornecedor
WHERE date_part('year', data) = 2013 
GROUP BY mes
ORDER BY mes;


/*Calculo da média das despesas por mês. 
Exibição dos meses por extenso: "setembro / 2013", "outubro / 2013" e "novembro / 2013".
Utilizando extract. 
*/

SELECT
extract(month FROM data) AS mes_num,
/*Formata a data em português devido ao prefixo TM. Em caso de dúvida veja o artigo de formatação de data*/ 
to_char(data, 'TMMonth "/" YYYY') AS mes, 
AVG(quantidade * valor) AS media
FROM tb_fornecedor
WHERE extract(year FROM data) = 2013 
GROUP BY mes_num, mes
ORDER BY mes_num;

/*Calculo da média das despesas por mês. 
Exibição dos meses por extenso: "setembro / 2013", "outubro / 2013" e "novembro / 2013".
Utilizando date_part. 
*/

SELECT
date_part('month', data) AS mes_num,
/*Formata a data em português devido ao prefixo TM. Em caso de dúvida veja o artigo de formatação de data*/ 
to_char(data, 'TMMonth "/" YYYY') AS mes, 
AVG (quantidade * valor) AS media
FROM tb_fornecedor
WHERE date_part('year', data) = 2013 
GROUP BY mes_num, mes
ORDER BY mes_num;

/**
*Fim do 4º exemplo
*/

/**
*Início do 5º exemplo
*/

/*Calculo da média das despesas por mês e segmento, utilizando extract*/

SELECT
extract(month FROM data)  AS mes,
segmento, 
AVG(quantidade * valor) AS media
FROM tb_fornecedor
WHERE extract(year FROM data) = 2013 
GROUP BY mes, segmento
ORDER BY mes, segmento;

/*Calculo da média das despesas por mês e segmento, utilizando date_part*/

SELECT
date_part('month', data) AS mes,
segmento, 
AVG(quantidade * valor) AS media
FROM tb_fornecedor
WHERE date_part('year', data) = 2013 
GROUP BY mes,  segmento
ORDER BY mes, segmento;


/*Calculo da média das despesas por mês(extenso) e segmento, utilizando extract*/

SELECT
extract(month FROM data) AS mes_num,
/*Formata a data em português devido ao prefixo TM. Em caso de dúvida veja o artigo de formatação de data*/ 
to_char(data, 'TMMonth "/" YYYY') AS mes,
segmento, 
AVG(quantidade * valor) AS media
FROM tb_fornecedor
WHERE extract(year FROM data) = 2013 
GROUP BY mes_num, mes,  segmento
ORDER BY mes_num, segmento;

/*Calculo da média das despesas por mês(extenso) e segmento, utilizando date_part*/

SELECT
date_part('month', data) AS mes_num,
/*Formata a data em português devido ao prefixo TM. Em caso de dúvida veja o artigo de formatação de data*/ 
to_char(data, 'TMMonth "/" YYYY') AS mes,
segmento, 
AVG(quantidade * valor) AS media
FROM tb_fornecedor
WHERE date_part('year', data) = 2013 
GROUP BY mes_num, mes,  segmento
ORDER BY mes_num, segmento;

/**
*Fim do 5º exemplo
*/


/**
*Início do 6º exemplo
*/

/*meses em que as despesas ultrapassaram R$ 600,00, utilizando extract*/

SELECT
extract(month FROM data) AS mes_num,
/*Formata a data em português devido ao prefixo TM. Em caso de dúvida veja o artigo de formatação de data*/ 
to_char(data, 'TMMonth "/" YYYY') AS mes, 
AVG(quantidade * valor) AS media
FROM tb_fornecedor
WHERE extract(year FROM data) = 2013 
GROUP BY mes_num, mes
HAVING AVG(quantidade * valor) > 600
ORDER BY mes_num;


/*meses em que as despesas ultrapassaram R$ 600,00, utilizando date_part*/

SELECT
date_part('month', data) AS mes_num,
/*Formata a data em português devido ao prefixo TM. Em caso de dúvida veja o artigo de formatação de data*/ 
to_char(data, 'TMMonth "/" YYYY') AS mes, 
AVG(quantidade * valor) AS media
FROM tb_fornecedor
WHERE date_part('year', data) = 2013 
GROUP BY mes_num, mes
HAVING AVG(quantidade * valor) > 600
ORDER BY mes_num;


/**
*Fim do 6º exemplo
*/