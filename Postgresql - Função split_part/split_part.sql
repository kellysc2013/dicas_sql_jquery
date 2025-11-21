/*
 Exemplo da função split_part no Postgresql
 A função split_part divide a string em duas ou mais partes (pedaços) e retorna um determinado pedaço de acordo com a posição escohida. 
 SINTAXE

 split_part(string, 'delimitador', posição)

 Onde:
 delimitador: o caractere ou o conjunto de caracteres que indica onde a string será quebrada em pedaços. Este delimitador deve ser usado entre aspas simples;
 posição: qual o pedaço da string será retornado pela função. Preencha com 1 para o 1º pedaço, 2 para o 2º pedaço, 3 para o 3º pedaço, e assim por diante
 
 Vamos usar como exemplos e-mails, separando a parte do usuário e a parte do dominio do e-mail.
 Na prática:
 -no e-mail maria@gmail.com: o usuário (é o que vem antes do "@" neste caso maria), já o domínio (é o que vem depois do "@" neste caso "gmail.com");
 -no e-mail joao123@outlook.com: o usuário (é o que vem antes do "@" neste caso joao123) já o domínio (é o que vem depois do "@" neste caso "outlook.com");
 -no e-mail carolina.alves@empresax.com.br: o usuário (é o que vem antes do "@" neste caso carolina.alves) já o domínio (é o que vem depois do "@" neste caso "empresax.com.br"); 
*/


/*
  Criar a tabela clientes
*/
CREATE table clientes
(
    id serial,
    nome varchar(255),
    e_mail varchar(256),
  	CONSTRAINT pk_id PRIMARY KEY(id)
);

/*
  Inserir dados na tabela clientes
*/
--Insert de e-mails válidos
INSERT INTO clientes (nome, e_mail) VALUES ('Maria Silva',    'maria@gmail.com');
INSERT INTO clientes (nome, e_mail) VALUES ('João Sousa',     'joao123@outlook.com');
INSERT INTO clientes (nome, e_mail) VALUES ('Carolina Alves', 'carolina.alves@empresax.com.br');

--Insert de e-mails inválidos
INSERT INTO clientes (nome, e_mail) VALUES ('Joana Pereira',  'joanaoutlook.com');
INSERT INTO clientes (nome, e_mail) VALUES ('Carlos Novaes',  'carlos@');
INSERT INTO clientes (nome, e_mail) VALUES ('Carla Santos',   'carlagmail.com@');
INSERT INTO clientes (nome, e_mail) VALUES ('Paulo Gomes',    '@paulogomesgmail.com');

/*
 Exibir os registros da tabela clientes com todas as colunas
*/
SELECT * FROM clientes;

/*
 -Exibir a coluna e-mail
 -exibir a coluna usuario - 1ª parte do split antes do @
 -exibir a coluna dominio - 2ª parte do split depois do @
*/
--Veja os registros que possuem e-mails válidos
SELECT 
e_mail,
split_part(e_mail, '@', 1),
split_part(e_mail, '@', 2)
FROM clientes
WHERE id <= 3;

/*
  Exibir os registros válidos com as colunas:  
 -e-mail
 -exibir a coluna usuario - 1ª parte do split antes do @ com alias (apelido) para o nome da coluna para facilitar a identificação da coluna.
 -exibir a coluna dominio - 2ª parte do split depois do @ com alias (apelido) para o nome da coluna para facilitar a identificação da coluna.
*/
SELECT 
e_mail,
split_part(e_mail, '@', 1) AS usuario,
split_part(e_mail, '@', 2) AS dominio
FROM clientes
WHERE id <= 3;

/*
 Antes de usar "SPLIT_PART", verifique 
  -se o delimitador existe na string: para evitar resultados inesperados. Neste exemplo foi o "@".
  -se o delimitador está bem posicionado: no caso deste exemplo, em específico, verificar se o "@" não está no início ou no fim do e-mail
 Se o delimitador NÃO for encontrado ou estiver mal posicionado, algum pedaço de string será vazia.
*/

/*
  Exibir os registro inválidos com as colunas:  
 -e-mail
 -exibir a coluna usuario: 1ª parte do split antes do @ com alias (apelido) para o nome da coluna para facilitar a identificação da coluna.
 -exibir a coluna dominio: 2ª parte do split depois do @ com alias (apelido) para o nome da coluna para facilitar a identificação da coluna.
*/
SELECT 
e_mail,
split_part(e_mail, '@', 1) AS usuario,
split_part(e_mail, '@', 2) AS dominio
FROM clientes
WHERE id > 3;
