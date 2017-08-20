/*Criar tabela esporte*/
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

/*Criar a coluna "disponibilidade" para indicar a modalidade esportiva*/
ALTER TABLE esporte ADD COLUMN  disponibilidade boolean;

/*Visualizar a coluna que acabamos de criar*/
SELECT * FROM esporte;

/*Para atualizarmos a disponibilidade das modalidades esportivas utilizaremos os comandos abaixo:*/

/*atletismo não está disponivel*/
UPDATE esporte SET disponibilidade = false WHERE id = 1;

/*futebol está disponivel*/
UPDATE esporte SET disponibilidade = true WHERE id = 2;

/*natação está disponivel*/
UPDATE esporte SET disponibilidade = true WHERE id = 3;

/*Visualize a tabela atualizada:*/
SELECT * FROM esporte;

/*Há possibilidade de criar um ou mais campos em um único comando:*/
ALTER TABLE esporte 
ADD COLUMN dt_ev_inicio date, 
ADD COLUMN dt_ev_fim date; 

/*Para atualizarmos as datas utilizaremos os comandos abaixo:*/
UPDATE esporte SET dt_ev_inicio = '2017-09-02', dt_ev_fim = '2017-10-25'  WHERE id = 1;
UPDATE esporte SET dt_ev_inicio = '2017-08-02', dt_ev_fim = '2017-08-28'  WHERE id = 2;
UPDATE esporte SET dt_ev_inicio = '2017-08-10', dt_ev_fim = '2017-08-26'  WHERE id = 3;

/*Visualize a tabela atualizada:*/
SELECT * FROM esporte;
