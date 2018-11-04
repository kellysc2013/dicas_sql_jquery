--Alterar timezone no postgresql

--1ª Etapa) Selecionar timezone atual e o diretório do arquivo de configuração "postgresql.conf".

SELECT name, reset_val, sourcefile FROM pg_settings WHERE name = 'TimeZone';

   name   |     reset_val     |             sourcefile
----------+-------------------+-------------------------------------
 TimeZone | America/Araguaina | D:/postgre_dados_96/postgresql.conf


--2ª Etapa) Verificar todos os nomes de timezone disponiveis no postgresql

SELECT * FROM pg_timezone_names

--3ª Etapa) Escolher o nome do novo timezone, neste caso foi escolhido "America/Sao_Paulo"

       name
-------------------
 America/Sao_Paulo


--3ª Etapa) Abrir o arquivo postgresql.conf que foi retornado na 1ª consulta

--Neste exemplo é:
--D:/postgre_dados_96/postgresql.conf

--4ª Etapa) Alterar os parametro do arquivo "timezone" e "log_timezone", em seguida, salve o arquivo.

timezone = 'America/Sao_Paulo'
log_timezone = 'America/Sao_Paulo'

--5ª Etapa) Reiniciar o servico do postgresql

/*

--No windows

Executar o prompt de comando do Windows como administrador.

Exemplo para reiniciar o servico do postgresql 9.6

Executar o seguinte comando

net stop postgresql-x64-9.6 && net start postgresql-x64-9.6

Caso não saiba o nome do servico execute o comando abaixo para retornar o nome do servico

sc queryex type= service state= all | find /i "Postgresql"



--No linux
Executar o comando no terminal do Linux (debian)

sudo service postgresql restart
          OU
/etc/init.d/postgresql restart

Caso não saiba o nome do servico execute o comando abaixo para retornar o nome do servico

ls /etc/init.d/


*/

