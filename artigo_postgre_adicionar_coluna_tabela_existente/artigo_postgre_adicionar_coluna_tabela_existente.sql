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

/*futebol e natação estão disponíveis*/
UPDATE esporte SET disponibilidade = true WHERE id IN (2,3); 

/*Visualize a tabela atualizada:*/
SELECT * FROM esporte;

/*Há possibilidade de criar um ou mais campos em um único comando:*/
ALTER TABLE esporte 
ADD COLUMN dt_ev_inicio date, 
ADD COLUMN dt_ev_fim date; 

/*Para atualizarmos as datas utilizaremos os comandos abaixo:*/
UPDATE esporte SET dt_ev_inicio = TO_DATE('02/09/2017', 'dd/mm/yyyy'), dt_ev_fim = TO_DATE('25/10/2017', 'dd/mm/yyyy')  WHERE id = 1;
UPDATE esporte SET dt_ev_inicio = TO_DATE('02/08/2017', 'dd/mm/yyyy'), dt_ev_fim = TO_DATE('28/08/2017', 'dd/mm/yyyy')  WHERE id = 2;
UPDATE esporte SET dt_ev_inicio = TO_DATE('10/08/2017', 'dd/mm/yyyy'), dt_ev_fim = TO_DATE('26/08/2017', 'dd/mm/yyyy')  WHERE id = 3;

/*Visualize a tabela atualizada:*/
SELECT * FROM esporte;
