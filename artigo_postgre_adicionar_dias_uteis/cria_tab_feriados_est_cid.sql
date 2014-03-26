/**
*Atenção!!! Descomente o comando abaixo somente se deseja excluir a tabela tab_feriado_federal.
*/
DROP TABLE IF EXISTS tab_feriado_federal;

/**
*Atenção!!! Descomente o comando abaixo somente se deseja excluir a tabela tab_feriado_estadual.
*/
DROP TABLE IF EXISTS tab_feriado_estadual;

/**
*Atenção!!! Descomente o comando abaixo somente se deseja excluir a tabela tab_feriado_municipal.
*/
DROP TABLE IF EXISTS tab_feriado_municipal;

/**
*Atenção!!! Descomente o comando abaixo somente se deseja excluir a tabela tab_exame_paciente (3º exemplo).
*/
DROP TABLE IF EXISTS tab_exame_paciente;

/**
*Atenção!!! Descomente o comando abaixo somente se deseja excluir a tabela tab_laboratorio (3º exemplo).
*/
DROP TABLE IF EXISTS tab_laboratorio;

/**
*Atenção!!! Descomente o comando abaixo somente se deseja excluir a tabela tab_cidades.
*/
DROP TABLE IF EXISTS tab_cidades;

/**
*Atenção!!! Descomente o comando abaixo somente se deseja excluir a tabela tab_estados.
*/
DROP TABLE IF EXISTS tab_estados;

CREATE TABLE tab_feriado_federal (
    descricao character varying(50) NOT NULL,
    feriado_federal date NOT NULL,
    CONSTRAINT pk_feriado_federal PRIMARY KEY(feriado_federal),
    CONSTRAINT uk_descricao UNIQUE (descricao)
);

/**
*Inclui os registros na tabela "tab_feriado_federal".
*/
INSERT INTO tab_feriado_federal (descricao, feriado_federal)
VALUES
('Confraternização Universal', '1900-01-01'),
('Tiradentes', '1900-04-21'),
('Dia do Trabalho', '1900-05-01'),
('Independência do Brasil', '1900-09-07'),
('Nossa Senhora Aparecida', '1900-10-12'),
('Finados', '1900-11-02'),
('Proclamação da República', '1900-11-15'),
('Natal', '1900-12-25');

/**
*Exibe os registros da tabela tab_feriado_federal
*/
SELECT * FROM tab_feriado_federal; 

/**
*Cria a tabela tab_estados. 
*Armazena os estados brasileiros. 
*/
CREATE TABLE tab_estados
(
	sigla_estado character(2),
	descricao character varying(40),
	CONSTRAINT pk_estados PRIMARY KEY (sigla_estado),
	CONSTRAINT uk_desc_estado UNIQUE (descricao)
);

/**
 *Inclui os registros na tabela tab_estados
 */
INSERT INTO tab_estados (descricao, sigla_estado)
VALUES
('Acre', 'AC'),
('Alagoas', 'AL'),
('Amapá', 'AP'),
('Amazonas' , 'AM'),
('Bahia', 'BA'),
('Ceará', 'CE'),
('Distrito Federal', 'DF'),
('Espírito Santo', 'ES'),
('Goiás', 'GO'),
('Maranhão', 'MA'),
('Mato Grosso', 'MT'),
('Mato Grosso do Sul', 'MS'),
('Minas Gerais', 'MG'),
('Pará', 'PA'),
('Paraíba', 'PB'),
('Paraná', 'PR'),
('Pernambuco', 'PE'),
('Piauí', 'PI'),
('Rio de Janeiro', 'RJ'),
('Rio Grande do Norte', 'RN'),
('Rio Grande do Sul', 'RS'),
('Rondônia', 'RO'),
('Roraima', 'RR'),
('Santa Catarina', 'SC'),
('São Paulo', 'SP'),
('Sergipe', 'SE'),
('Tocantins', 'TO');

/**
 *Exibe os registros da tabela tab_estados
 */
SELECT * FROM tab_estados;

/**
*Cria a tabela tab_feriado_estadual
*Esta tabela armazena os feriados estaduais.
*/
CREATE TABLE tab_feriado_estadual
( 
  descricao character varying(50) NOT NULL,
  feriado_estadual date NOT NULL,
  sigla_estado character(2),
  CONSTRAINT pk_feriado_estadual PRIMARY KEY(sigla_estado, feriado_estadual),
  CONSTRAINT fk_fer_estadual_estados FOREIGN KEY(sigla_estado) REFERENCES tab_estados
);

/**
*Inclui os registros na tabela "tab_feriado_estadual".
*/
/*Feriado estadual ACRE*/
--15 de Junho
INSERT INTO tab_feriado_estadual VALUES ('Aniversário do estado', '1900-06-15', 'AC');
--06 de Agosto
INSERT INTO tab_feriado_estadual VALUES ('Início da Revolução Acreana', '1900-08-06', 'AC');
--05 de Setembro
INSERT INTO tab_feriado_estadual VALUES ('Dia da Amazônia', '1900-09-05', 'AC');
--17 de Novembro
INSERT INTO tab_feriado_estadual VALUES ('Assinatura do Tratado de Petrópolis', '1900-09-17', 'AC');

/*Feriado estadual ALAGOAS*/
--16 de Setembro
INSERT INTO tab_feriado_estadual VALUES ('Emancipação Política de Alagoas', '1900-09-16', 'AL');
--20 de Novembro 
INSERT INTO tab_feriado_estadual VALUES ('Dia da Consciência Negra', '1900-11-20', 'AL'); 

/*Feriado estadual AMAPÁ*/
--19 de Março
INSERT INTO tab_feriado_estadual VALUES ('Dia de São José', '1900-03-19', 'AP');
--05 de Outubro 
INSERT INTO tab_feriado_estadual VALUES ('Criação do Estado', '1900-10-05', 'AP');

/*Feriado estadual Amazonas*/
--05 de Setembro
INSERT INTO tab_feriado_estadual VALUES ('Elevação do Amazonas à categoria de província', '1900-09-05', 'AM');
--08 de Dezembro
INSERT INTO tab_feriado_estadual VALUES ('Dia de Nossa Senhora da Conceição', '1900-12-08', 'AM');

/*Feriado estadual Bahia*/
--02 de Julho
INSERT INTO tab_feriado_estadual VALUES ('Indepêndencia da Bahia', '1900-07-02', 'BA');

/*Feriado estadual Ceará*/
--19 de Março
INSERT INTO tab_feriado_estadual VALUES ('Dia de São José', '1900-03-19', 'CE');

/*Feriado do Distrito Federal*/
--21 de Abril
INSERT INTO tab_feriado_estadual VALUES ('Fundação de Brasília', '1900-04-21', 'DF');

/*Feriado do Espírito Santo*/
--23 de Maio
INSERT INTO tab_feriado_estadual VALUES ('Colonização do solo espírito-santense', '1900-05-23', 'ES');

/*Feriado estadual do Goiás*/
--28 de Outubro
INSERT INTO tab_feriado_estadual VALUES ('Dia do Servidor Público', '1900-10-28', 'GO');

/*Feriado estadual de Maranhão*/
--28 de Julho
INSERT INTO tab_feriado_estadual VALUES ('Adesão do Maranhão à independência do Brasil', '1900-07-28', 'MA');
--08 de Dezembro
INSERT INTO tab_feriado_estadual VALUES ('Dia de Nossa Senhora da Conceição', '1900-12-08', 'MA');

/*Feriado estadual de Mato Grosso*/
--11 de novembro
INSERT INTO tab_feriado_estadual VALUES ('Dia da Consciência Negra', '1900-11-20', 'MT');

/*Feriado estadual de Mato Grosso do Sul*/
--11 de Outubro
INSERT INTO tab_feriado_estadual VALUES ('Criação do Estado', '1900-10-11', 'MS');

/*Feriado estadual de Minas Gerais*/
--21 de Abril
INSERT INTO tab_feriado_estadual VALUES ('Data magna do Estado', '1900-04-21', 'MG');

/*Feriado estadual do Pará*/
--15 de Agosto
INSERT INTO tab_feriado_estadual VALUES ('Adesão do Grão-Pará à independência do Brasil', '1900-08-15', 'PA');

/*Feriado estadual do Paraíba*/
--05 de Agosto
INSERT INTO tab_feriado_estadual VALUES ('Emancipação política do estado', '1900-08-05', 'PB');

/*Feriado estadual do Paraná*/
--19 de Dezembro
INSERT INTO tab_feriado_estadual VALUES ('Emancipação Política', '1900-12-19', 'PR');

/*Feriado estadual do Pernambuco*/
--Em Pernambuco não há feriados estaduais.

/*Feriado estadual do Piauí*/
--13 de Março
INSERT INTO tab_feriado_estadual VALUES ('Dia da Batalha do Jenipapo', '1900-03-13', 'PI');
--19 de Outubro
INSERT INTO tab_feriado_estadual VALUES ('Dia do Piauí', '1900-10-19', 'PI');

/*Feriado estadual do Rio de Janeiro*/
--15 de Outubro
INSERT INTO tab_feriado_estadual VALUES ('Dia do Comércio', '1900-10-15', 'RJ');
--20 de Novembro
INSERT INTO tab_feriado_estadual VALUES ('Dia da Consciência Negra', '1900-11-20', 'RJ');

/*Feriado estadual do Rio Grande do Norte*/
--29 de Junho
INSERT INTO tab_feriado_estadual VALUES ('Dia de São Pedro', '1900-06-29', 'RN');

--03 de Outubro
INSERT INTO tab_feriado_estadual VALUES ('Mártires de Cunhaú e Uruaçu', '1900-10-03', 'RN');

/*Feriado estadual do Rio Grande do Sul*/
INSERT INTO tab_feriado_estadual VALUES ('Revolução Farroupilha', '1900-09-20', 'RS');

/*Feriado estadual do Rondônia*/
--04 de Janeiro  
INSERT INTO tab_feriado_estadual VALUES ('Criação do Estado', '1900-01-04', 'RO');

/*Feriado estadual do Roraíma*/
--05 de Outubro
INSERT INTO tab_feriado_estadual VALUES ('Criação do Estado', '1900-10-05', 'RR');

/*Feriado estadual do Santa Catarina*/
--11 de Agosto
INSERT INTO tab_feriado_estadual VALUES ('Criação da capitania, separando-se de São Paulo', '1900-08-11', 'SC');

/*Feriado estadual do São Paulo*/
--09 de Julho
INSERT INTO tab_feriado_estadual VALUES ('Revolução Constitucionalista de 1932', '1900-07-09', 'SP');

/*Feriado estadual do Sergipe*/
--08 de Julho
INSERT INTO tab_feriado_estadual VALUES ('Autonomia política de Sergipe', '1900-07-08', 'SE');

/*Feriado estadual do Tocantins*/
--05 de Outubro
INSERT INTO tab_feriado_estadual VALUES ('Criação do Estado.', '1900-10-05', 'TO');

/**
*Exibe os registros da tabela tab_feriado_estadual
*/
SELECT * FROM tab_feriado_estadual;

/**
*Cria a tabela tab_cidades.
*Armazena as cidades brasileiras. 
*Como há muitas cidades cadastrei apenas São Paulo e Rio Grande do Sul como exemplo.
*Cadastre as cidades conforme a sua necessidade.
*/
CREATE TABLE tab_cidades
(
	cidade_id serial,
	cidade_nome character varying (80),
	sigla_estado character(2),
	PRIMARY KEY(cidade_id),
	UNIQUE (sigla_estado, cidade_nome),
	CONSTRAINT fk_cidade_estado FOREIGN KEY(sigla_estado) REFERENCES tab_estados(sigla_estado)
);

/**
*Inclui os registros na tabela tab_cidades
*/
INSERT INTO tab_cidades
(cidade_id, cidade_nome, sigla_estado)
VALUES
(DEFAULT, 'São Paulo', 'SP'),
(DEFAULT, 'Porto Alegre', 'RS');

/**
*Exibe os registros da tabela tab_cidades
*/
SELECT * FROM tab_cidades;

/**
*Cria a tabela tab_feriado_municipal. Esta tabela armazena os feriados municipais
*Como há muitos feriados municipais cadastrei apenas os feriados municipais
*de São Paulo e Rio Grande do Sul.
*Cadastre os feriados municipais conforme sua necessidade.
*/
CREATE TABLE tab_feriado_municipal
(
  descricao character varying(50) NOT NULL,
  feriado_municipal date NOT NULL,
  cidade_id integer,
  CONSTRAINT fk_fer_mun_cidade FOREIGN KEY (cidade_id) REFERENCES tab_cidades(cidade_id),
  CONSTRAINT uk_fer_municipal UNIQUE(descricao, feriado_municipal, cidade_id)
);

/**
*Inclui os registros na tabela tab_feriado_municipal
*/
INSERT INTO tab_feriado_municipal(descricao, feriado_municipal, cidade_id)
VALUES
--25 de janeiro
('Aniversário de São Paulo', '1900-01-25', 1),
--2 de fevereiro 
('Aniversário de Porto Alegre', '1900-02-02', 2),
--26 de março
('Nossa Senhora dos Navegantes', '1900-03-26', 2);

/**
*Exibe os registros da tabela tab_cidades
*/
SELECT * FROM tab_feriado_municipal;