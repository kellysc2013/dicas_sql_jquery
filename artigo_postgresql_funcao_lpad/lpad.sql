/*
 *Veja os nossos artigos em: http://jquerydicas.blogspot.com.br
 *Artigo: Postgresql - função LPAD
 *Autora: Kelly Silva Costa
 */


/*
 *Criação da tabela tb_produto
 */
CREATE TABLE tb_produto 

(
	codigo_produto integer,
	nome_produto character varying(255)
);

/*
 *Inserir registros na tabela tb_produto
 */
INSERT INTO tb_produto VALUES
(438, 'lápis'),
(8426, 'caderno'),
(22, 'borracha'),
(16547, 'cartolina');

/*
 *Visualizar a tabela tb_produto
 */
SELECT codigo_produto, nome_produto FROM tb_produto;

--1º Exemplo

/*
 *Completar com o hifen ('-') a esquerda dos nomes dos produtos até a 10ª posição. 
 */
SELECT 
nome_produto, 
LPAD(nome_produto,10, '-') AS nome_produto_com_hifen
FROM tb_produto;


--2º Exemplo
/*
 *Preencher com zeros "0" a esquerda, até a 5ª posição, os códigos dos produtos.
 */
SELECT
LPAD(CAST(codigo_produto AS CHARACTER VARYING), 5, '0') AS codigo_produto,  
nome_produto
FROM tb_produto;
