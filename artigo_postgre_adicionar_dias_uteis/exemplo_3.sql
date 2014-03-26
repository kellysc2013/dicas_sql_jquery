/**
*Atenção!!! Descomente o comando abaixo somente se deseja excluir a tabela tab_exame_paciente.
*/
DROP TABLE IF EXISTS tab_exame_paciente;

/**
*Atenção!!! Descomente o comando abaixo somente se deseja excluir a tabela tab_laboratorio.
*/
DROP TABLE IF EXISTS tab_laboratorio;

/**
*Cria a tabela tab_laboratorio. Armazena a localização dos laboratórios.
*/
CREATE TABLE tab_laboratorio
(
	laboratorio_codigo serial,
	laboratorio_endereco character varying(80),
	cidade_id integer,
	CONSTRAINT pk_lab_codigo PRIMARY KEY(laboratorio_codigo),
	CONSTRAINT fk_lab_cidades FOREIGN KEY(cidade_id) REFERENCES tab_cidades(cidade_id)
);

/**
*Inclui registros na tabela tab_laboratorio.
*/
INSERT INTO tab_laboratorio(laboratorio_codigo, laboratorio_endereco, cidade_id)
VALUES
(DEFAULT, 'Av. Santo Amaro, 514', 1),
(DEFAULT, 'Av. Ibirapuera,  217', 1),
(DEFAULT, 'Rua Vasco Alves,  128', 2);

/**
*Exibe registros na tabela tab_laboratorio.
*/
SELECT * FROM tab_laboratorio; 

/**
*Cria a tabela tab_exame_paciente. Armazena os exames dos pacientes.
*/
CREATE TABLE tab_exame_paciente
(
  exame_codigo integer,
  exame_data date,
  laboratorio_codigo integer,
  paciente_codigo integer,
  CONSTRAINT pk_exame_codigo PRIMARY KEY(exame_codigo),
  CONSTRAINT fk_exa_paciente_labor FOREIGN KEY(laboratorio_codigo) REFERENCES tab_laboratorio(laboratorio_codigo)
);

/**
*Insere registros na tabela tab_exame_paciente.
*/
INSERT INTO tab_exame_paciente 
(exame_codigo, exame_data, laboratorio_codigo, paciente_codigo)
VALUES
('1541', '2014-04-28', 1, 5146),
('1542', '2014-05-25', 2, 5147),
('1543', '2014-06-29', 3, 5148),
('1544', '2014-07-08', 2, 5149),
('1545', '2014-07-09', 1, 5149),
('1546', '2014-09-28', 2, 5162);


/**
*Exibe registros da tabela tab_exame_paciente.
*/
SELECT * FROM tab_exame_paciente;

/**
*Exibe as datas de entrega dos exames dos pacientes.
*/
SELECT 
exame_codigo, 
tab_exame_paciente.laboratorio_codigo, 
paciente_codigo, 
exame_data,
adiciona_dias_uteis(exame_data, 5, cidade_id) AS exame_entrega
FROM tab_exame_paciente
JOIN tab_laboratorio
ON tab_exame_paciente.laboratorio_codigo = tab_laboratorio.laboratorio_codigo;