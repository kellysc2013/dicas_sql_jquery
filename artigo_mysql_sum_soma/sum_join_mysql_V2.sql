/**
*Criar tabela produtos.
*/
CREATE TABLE produtos
(
	id_produto int not null AUTO_INCREMENT,
	descricao varchar(200),
    CONSTRAINT produto_pk primary key(id_produto)
);

/**
*Incluir os dados na tabela produtos.
*/
INSERT INTO produtos(descricao) VALUES ('DVD');
INSERT INTO produtos(descricao) VALUES ('HD 500 GB');
INSERT INTO produtos(descricao) VALUES ('Tonner');
INSERT INTO produtos(descricao) VALUES ('Cadeira');
INSERT INTO produtos(descricao) VALUES ('Mesa');

/**
*Criar tabela vendas.
*/
CREATE TABLE vendas
(
	id_produto int,
	qtde int,
	vlr_unit numeric(15,2),
	data datetime,
	CONSTRAINT produto_fk foreign key(id_produto) REFERENCES produtos(id_produto)
);

/**
*Inclui os dados na tabela vendas
*/
INSERT INTO vendas VALUES(1, 1, 259.10, '2018-09-01 23:59:59');
INSERT INTO vendas VALUES(1, 2, 300.00, '2018-09-07 22:44:06');

INSERT INTO vendas VALUES(2, 8, 200.06, '2018-09-02 12:13:19');
INSERT INTO vendas VALUES(2, 5, 220.00, '2018-09-08 15:44:25');

INSERT INTO vendas VALUES(3,  9, 70.00, '2018-09-03 10:14:59');
INSERT INTO vendas VALUES(3, 10, 90.06, '2018-09-10 16:24:59');

INSERT INTO vendas VALUES(4, 49, 40.29, '2018-09-06 06:43');
INSERT INTO vendas VALUES(4, 80, 30.00, '2018-09-11 05:44');

INSERT INTO vendas VALUES(5, 49, 540.00, '2018-09-07 06:21');
INSERT INTO vendas VALUES(5, 43, 530.37, '2018-09-12 10:22');

/**
*Consultar produtos vendidos dentro de um período.
*/
SELECT 
vd.id_produto, 
p.descricao, 
sum(vd.qtde) as qtd_total, 
sum(vd.qtde * vd.vlr_unit) as valor_total
FROM vendas vd 
inner join produtos p on (vd.id_produto = p.id_produto) 
where 
CAST(data AS DATE) >= CAST('2018-09-01' AS DATE) AND 
CAST(data AS DATE) <= CAST('2018-09-30' AS DATE)
group by
vd.id_produto,
p.descricao  
order by vd.qtde desc;
