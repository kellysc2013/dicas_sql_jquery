--Criar a tabela "pais"
CREATE TABLE pais 
(
	pais_id serial,
	pais_nome varchar(50) NOT NULL,
	pais_status varchar(1) NOT NULL, 
	CONSTRAINT pais_pk PRIMARY KEY (pais_id)
);

--Criar a tabela "estado"
CREATE TABLE estado 
(
	estado_id serial,
	estado_nome varchar(50) NOT NULL,
	estado_status varchar(1),
	pais_id int NOT NULL,
	CONSTRAINT estado_pk PRIMARY KEY (estado_id),
	CONSTRAINT fk_estado_pais FOREIGN KEY (pais_id) REFERENCES pais(pais_id) 
 
);

--Criar a tabela "cidade"
CREATE TABLE cidade (
	cidade_id serial,
	cidade_nome varchar(50) NOT NULL,
	cidade_status varchar(1) NOT NULL,
	estado_id int NOT NULL,
	CONSTRAINT cidade_pk PRIMARY KEY (cidade_id),
	CONSTRAINT fk_cidade_estado FOREIGN KEY (estado_id) REFERENCES estado(estado_id) 
);

--Insere os registros da tabela "pais"
INSERT INTO pais(pais_nome, pais_status) VALUES ('Brasil', 'A');
INSERT INTO pais(pais_nome, pais_status) VALUES ('Estados Unidos', 'A');

--Insere os registros da tabela "estado"
INSERT INTO estado(estado_nome, estado_status, pais_id) VALUES ('São Paulo', 'A', 1);
INSERT INTO estado(estado_nome, estado_status, pais_id) VALUES ('Santa Catarina', 'A', 1);
INSERT INTO estado(estado_nome, estado_status, pais_id) VALUES ('Flórida', 'A', 2);
INSERT INTO estado(estado_nome, estado_status, pais_id) VALUES ('Califórnia', 'A', 2);

--Insere os registros da tabela "cidade"

INSERT INTO cidade(cidade_nome, cidade_status, estado_id) VALUES ('Campinas', 'A', 1);
INSERT INTO cidade(cidade_nome, cidade_status, estado_id) VALUES ('Osasco', 'A', 1);

INSERT INTO cidade(cidade_nome, cidade_status, estado_id) VALUES ('Florianópolis', 'A', 2);
INSERT INTO cidade(cidade_nome, cidade_status, estado_id) VALUES ('Blumenau', 'A', 2);

INSERT INTO cidade(cidade_nome, cidade_status, estado_id) VALUES ('Miami', 'A', 3);
INSERT INTO cidade(cidade_nome, cidade_status, estado_id) VALUES ('Orlando', 'A', 3);

INSERT INTO cidade(cidade_nome, cidade_status, estado_id) VALUES ('Los Angeles', 'A', 4);
INSERT INTO cidade(cidade_nome, cidade_status, estado_id) VALUES ('Malibu', 'A', 4);

--Consulta a tabela "pais"
SELECT * FROM pais;

 pais_id |   pais_nome    | pais_status 
---------+----------------+-------------
       1 | Brasil         | A
       2 | Estados Unidos | A



--Consulta a tabela "estado"
SELECT * FROM estado;

 estado_id |  estado_nome   | estado_status | pais_id 
-----------+----------------+---------------+---------
         1 | São Paulo      | A             |       1
         2 | Santa Catarina | A             |       1
         3 | Flórida        | A             |       2
         4 | Califórnia     | A             |       2
		 
		 

--Consulta a tabela "cidade"
SELECT * FROM cidade;

 cidade_id |  cidade_nome  | cidade_status | estado_id 
-----------+---------------+---------------+-----------
         1 | Campinas      | A             |         1
         2 | Osasco        | A             |         1
         3 | Florianópolis | A             |         2
         4 | Blumenau      | A             |         2
         5 | Miami         | A             |         3
         6 | Orlando       | A             |         3
         7 | Los Angeles   | A             |         4
         8 | Malibu        | A             |         4


--Consulta tabelas "pais", "estado" e "cidade"
SELECT
pais.pais_nome,
estado.estado_nome,
cidade.cidade_nome
FROM pais
INNER JOIN estado ON estado.pais_id = pais.pais_id
INNER JOIN cidade ON cidade.estado_id = estado.estado_id
WHERE CIDADE_STATUS = 'A';

   pais_nome    |  estado_nome   |  cidade_nome  
----------------+----------------+---------------
 Brasil         | São Paulo      | Campinas
 Brasil         | São Paulo      | Osasco
 Brasil         | Santa Catarina | Florianópolis
 Brasil         | Santa Catarina | Blumenau
 Estados Unidos | Flórida        | Miami
 Estados Unidos | Flórida        | Orlando
 Estados Unidos | Califórnia     | Los Angeles
 Estados Unidos | Califórnia     | Malibu 

