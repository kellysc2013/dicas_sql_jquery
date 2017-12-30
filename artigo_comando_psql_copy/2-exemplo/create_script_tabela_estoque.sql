/*
Crie esta tabela, caso NÃO tenha criado no 1º exemplo.
*/

CREATE TABLE estoque
(
    codigo integer,
    produto character varying(100) COLLATE pg_catalog."default",
    categoria character varying(100) COLLATE pg_catalog."default",
    marca character varying(100) COLLATE pg_catalog."default",
    preco numeric(10, 2),
    quantidade integer
);
