/*
 *Mysql - diferença entre datas
 *Veja o artigo em: http://jquerydicas.blogspot.com.br/2013/11/mysql-diferenca-entre-datas.html
 */
 
/*
 *CRIAR A TABELA tb_locacao 
 */
CREATE TABLE tb_locacao 
(
    imovel_id int NOT NULL AUTO_INCREMENT,
	data_oferta date not null,
	data_locacao date null,
    PRIMARY KEY (imovel_id)
);

/*
 *INCLUIR REGISTROS NA TABELA tb_locacao 
 */
INSERT INTO tb_locacao (data_oferta, data_locacao) VALUES('2013-08-01', '2013-08-17');
INSERT INTO tb_locacao (data_oferta, data_locacao) VALUES('2013-08-03', '2013-08-23');
INSERT INTO tb_locacao (data_oferta, data_locacao) VALUES('2013-08-20', '2013-09-05');
INSERT INTO tb_locacao (data_oferta, data_locacao) VALUES('2013-08-22', '2013-09-14');
INSERT INTO tb_locacao (data_oferta, data_locacao) VALUES('2013-09-10', '2013-10-05');
INSERT INTO tb_locacao (data_oferta, data_locacao) VALUES('2013-09-20', '2013-10-31');


/*
 *1º Exemplo
 */

/*
 *Para calcularmos a diferença em dias executamos a sentença abaixo:
 */
SELECT
imovel_id,
data_oferta,
data_locacao,
/*Calculo da diferença entre a data da locação e a data de oferta*/
DATEDIFF (data_locacao, data_oferta) AS quantidade_dias
FROM tb_locacao;

/*
 *Observação: caso seja necessário, incluir o primeiro dia, na contagem dos dias, utilize a sentença a seguir:
 */
SELECT
imovel_id,
data_oferta,
data_locacao,
DATEDIFF (data_locacao, data_oferta) AS quantidade_dias,
/*Calculo da diferença entre a data da locação e a data de oferta, levando em consideração o primeiro dia*/
ABS(DATEDIFF (data_locacao, data_oferta)) + 1 AS quantidade_dias_primeiro_dia
FROM tb_locacao;

/*
 *CRIAR A TABELA tb_cadastro 
 */
CREATE TABLE tb_cadastro 
(
    cliente_id int NOT NULL AUTO_INCREMENT,
	data_cadastro date not null,
    PRIMARY KEY (cliente_id)
);

/*
 *INCLUIR REGISTROS NA TABELA tb_cadastro 
 */
INSERT INTO tb_cadastro (data_cadastro) VALUES('2013-06-13');
INSERT INTO tb_cadastro (data_cadastro) VALUES('2013-07-15');
INSERT INTO tb_cadastro (data_cadastro) VALUES('2013-08-13');
INSERT INTO tb_cadastro (data_cadastro) VALUES('2013-10-20');
INSERT INTO tb_cadastro (data_cadastro) VALUES('2013-11-25');

/*
 *2º Exemplo
 */

/*
 *Verificar clientes que estejam cadatrados a mais de 90 dias, 
 *considerando a data de hoje
 */

SELECT
cliente_id,
data_cadastro,
/*calcula a diferença em dias completos*/
DATEDIFF(CURDATE(), data_cadastro) AS quantidade_dias
FROM tb_cadastro
/*filtra somente os clientes que são cadastrados há mais que 90 dias*/
WHERE DATEDIFF(CURDATE(), data_cadastro) > 90;


/*
 *CRIAR A TABELA tb_equipamento 
 */
CREATE TABLE tb_equipamento 
(
    equipamento_id int NOT NULL AUTO_INCREMENT,
	data_inicio datetime not null,
	data_encerramento datetime null,
    PRIMARY KEY (equipamento_id)
);

/*
 *INCLUIR REGISTROS NA TABELA tb_equipamento 
 */
INSERT INTO tb_equipamento (data_inicio, data_encerramento) VALUES('2009-05-13 15:30:22', '2014-01-16 15:30:20');
INSERT INTO tb_equipamento (data_inicio, data_encerramento) VALUES('2010-08-14 16:30:22', '2014-02-15 09:32:54');
INSERT INTO tb_equipamento (data_inicio, data_encerramento) VALUES('2011-07-15 17:40:22', '2014-03-02 10:54:22');
INSERT INTO tb_equipamento (data_inicio, data_encerramento) VALUES('2012-04-16 18:42:22', '2014-02-28 16:20:35');
INSERT INTO tb_equipamento (data_inicio, data_encerramento) VALUES('2013-02-05 19:47:22', '2014-03-06 10:21:35');


/*
 *3º Exemplo
 */

/*
 *Calcular o periodo de utilização de equipamentos, em anos. 
 */

SELECT
equipamento_id,
data_inicio,
data_encerramento,
/*calcula a diferença em anos completos*/
TIMESTAMPDIFF(YEAR , data_inicio, data_encerramento) AS periodo_anos
FROM tb_equipamento;

/*
 *4º Exemplo
 */

/*
 *Calcular o período dos equipamentos em anos, meses, dias, horas, minutos e segundos.
 */

SELECT 
data_inicio,
data_encerramento,
/**
 *Calcular a diferença em anos.
 */
TIMESTAMPDIFF(YEAR, data_inicio, data_encerramento) AS anos ,
/**
 *Calcular a diferença em meses.
 *Não vão ser contados os meses que já entraram na contagem dos anos completos.  
 */
TIMESTAMPDIFF
(
MONTH, 
data_inicio + INTERVAL TIMESTAMPDIFF(YEAR,  data_inicio, data_encerramento) YEAR , 
data_encerramento
) AS meses,
/**
 *Calcular a diferença em dias.
 *Não vão ser contados os dias que já entraram na contagem dos meses completos.  
 */
TIMESTAMPDIFF
(
DAY, 
data_inicio + INTERVAL TIMESTAMPDIFF(MONTH, data_inicio, data_encerramento) MONTH, 
data_encerramento
) AS dias ,
/**
 *Calcular a diferença em horas.
 *Não vão ser contadas as horas que já entraram na contagem dos dias completos.  
 */
TIMESTAMPDIFF
(
HOUR, 
data_inicio + INTERVAL TIMESTAMPDIFF(DAY,  data_inicio, data_encerramento) DAY, 
data_encerramento
) AS horas,
/**
 *Calcular a diferença em minutos.
 *Não vão ser contados os minutos que já entraram na contagem das horas completas.  
 */
TIMESTAMPDIFF
(
MINUTE, 
data_inicio + INTERVAL TIMESTAMPDIFF(HOUR,  data_inicio, data_encerramento) HOUR, 
data_encerramento
) AS minutos,
/**
 *Calcular a diferença em segundos.
 *Não vão ser contados os segundo que já entraram na contagem dos minutos completos.  
 */
TIMESTAMPDIFF
(
SECOND, 
data_inicio + INTERVAL TIMESTAMPDIFF(MINUTE,  data_inicio, data_encerramento) MINUTE, 
data_encerramento
) AS segundos
FROM tb_equipamento;
