/*
 *Estes exemplos pertencem ao artigo: Criar uma coluna em uma tabela existente no PostgreSql
 *Veja em: https://jquerydicas.blogspot.com/2013/10/criar-uma-coluna-em-uma-tabela.html
 */

/*Criar a tabela esporte*/
CREATE TABLE esporte 
(
    id serial,
    esport_desc varchar(20)
);

/*Inserir os dados na tabela esporte*/
INSERT INTO esporte (esport_desc) VALUES('atletismo');
INSERT INTO esporte (esport_desc) VALUES('futebol');
INSERT INTO esporte (esport_desc) VALUES('natacão');

/*Selecionar os registros da tabela esporte*/
SELECT * FROM esporte;

/*
 *1º) Exemplo
 *Criar a coluna "disponibilidade" para indicar a modalidade esportiva
 */
ALTER TABLE esporte ADD COLUMN  disponibilidade boolean;

/*Visualizar a coluna que acabamos de criar*/
SELECT * FROM esporte;

/*Para atualizarmos a disponibilidade das modalidades esportivas utilizaremos os comandos abaixo:*/

/*atletismo não está disponivel*/
UPDATE esporte SET disponibilidade = false WHERE id = 1;

/*futebol e natação estão disponíveis*/
UPDATE esporte SET disponibilidade = true WHERE id IN (2,3); 

/*Visualize a tabela atualizada:*/
SELECT * FROM esporte;

/*
 *2º) Exemplo
 *Há possibilidade de criar uma ou mais colunas em um único comando:
 */

ALTER TABLE esporte 
ADD COLUMN dt_ev_inicio date, 
ADD COLUMN dt_ev_fim date; 

/*Para atualizarmos as datas utilizaremos os comandos abaixo:*/
UPDATE esporte SET dt_ev_inicio = TO_DATE('02/09/2017', 'dd/mm/yyyy'), dt_ev_fim = TO_DATE('25/10/2017', 'dd/mm/yyyy')  WHERE id = 1;
UPDATE esporte SET dt_ev_inicio = TO_DATE('02/08/2017', 'dd/mm/yyyy'), dt_ev_fim = TO_DATE('28/08/2017', 'dd/mm/yyyy')  WHERE id = 2;
UPDATE esporte SET dt_ev_inicio = TO_DATE('10/08/2017', 'dd/mm/yyyy'), dt_ev_fim = TO_DATE('26/08/2017', 'dd/mm/yyyy')  WHERE id = 3;

/*Visualize a tabela atualizada:*/
SELECT * FROM esporte;

/*
3º) Exemplo
 
Criar na tabela "esporte", uma coluna obrigatória chamada "categoria", ou seja, que exige que o dado seja obrigatório (não nulo).

Antes de criar a coluna devemos verificar se há dados na tabela, para isso vamos utilizar a função "COUNT", esta função conta o número de linhas de uma tabela.
*/

SELECT COUNT(*) FROM esporte;

/*
a) Caso não haja dados na tabela
*/
--Descomente o comando para executar. Deixei comentado, pois neste exemplo a tabela "esporte" tem dados
--ALTER TABLE esporte ADD COLUMN  categoria  varchar(80)  NOT NULL;

/*
b) Caso haja dados na tabela. Primeiramente crie a coluna como não obrigatória
*/

ALTER TABLE esporte ADD COLUMN  categoria  varchar(80);

/* 
Atualize os dados da coluna antes de torná-la obrigatória (não nula).
Segue a atualização de dados através do comando UPDATE.
*/
  
/*foi atribuído a futebol categoria "coletivo"*/
UPDATE esporte SET categoria = 'coletivo' WHERE id = 2;

/*foi atribuído a atletismo e natação a categoria "individual"*/
 UPDATE esporte SET categoria = 'individual' WHERE id IN (1,3);

/* 
Agora que não há dados nulos, vamos tornar a coluna obrigatória.
SINTAXE

ALTER TABLE nome_da_tabela ALTER COLUMN nome_da_coluna SET NOT NULL;
*/
ALTER TABLE esporte ALTER COLUMN categoria SET NOT NULL;

/*
4º) Exemplo
Tornar a coluna "categoria" NÃO obrigatória (opcional). Execute o comando abaixo: 

SINTAXE

ALTER TABLE nome_da_tabela ALTER COLUMN nome_da_coluna DROP NOT NULL;
*/

/* 
Exemplo:
*/ 
ALTER TABLE esporte ALTER COLUMN categoria DROP NOT NULL;

/*
5º) Exemplo

Criar uma coluna chamada "modalidade_ativa" do tipo "boolean" com valor "DEFAULT" (padrão) igual a "true".
 
SINTAXE
 
ALTER TABLE nome_da_tabela ADD COLUMN nome_da_coluna  tipo_de_dado  DEFAULT valor_padrao;
 
Exemplo:
*/ 

ALTER TABLE esporte ADD COLUMN modalidade_ativa boolean DEFAULT true;
 
/* 
6º) Exemplo
 
Criar uma coluna chamada "data_hora_criacao" do tipo "timestamp without time zone"  com valor "DEFAULT" igual a "data e hora atual".
 
SINTAXE
 
ALTER TABLE nome_da_tabela ADD COLUMN nome_da_coluna tipo_de_dado DEFAULT valor_padrao;
*/ 

ALTER TABLE esporte ADD COLUMN data_hora_criacao timestamp without time zone DEFAULT current_timestamp;

/* 

7º) Exemplo
 
Remover o valor DEFAULT de uma coluna:
 
SINTAXE
 
ALTER TABLE nome_da_tabela ALTER COLUMN nome_da_coluna DROP DEFAULT;
 
Exemplos:
*/ 

--a) Remover o valor "DEFAULT" da coluna "modalidade_ativa".
 
ALTER TABLE esporte ALTER COLUMN modalidade_ativa DROP DEFAULT;
 
--b) Remover o valor "DEFAULT" da coluna "data_hora_criacao".
 
ALTER TABLE esporte ALTER COLUMN data_hora_criacao DROP DEFAULT;
