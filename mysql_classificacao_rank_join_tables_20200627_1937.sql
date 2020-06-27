/**
 *Exemplo de classificação (rank) no mysql - utilizando outras tabelas com JOIN*/
 *http://sqlfiddle.com/#!9/11dcd5/1
 */


/**
 *V4
 *Cria a tabela "tb_atleta"
 */
CREATE TABLE tb_atleta
(
    inscricao integer,
    nome_atleta varchar(255),
    CONSTRAINT pk_inscricao PRIMARY KEY(inscricao)
);

/**
 *Cria a tabela "tb_patrocinador"
 */
CREATE TABLE tb_patrocinador
(
    patrocinador_id integer,
    patrocinador_nome varchar(255),
    CONSTRAINT pk_patrocinador PRIMARY KEY(patrocinador_id)  
);

/**
 *Cria a tabela "tb_patrocinador_atleta"
 */
CREATE TABLE tb_patrocinador_atleta
(
    id_pat_atleta integer NOT NULL AUTO_INCREMENT, 
    patrocinador_id integer,
    inscricao integer,
    CONSTRAINT pk_patr_atleta PRIMARY KEY(id_pat_atleta),  
    CONSTRAINT fk_patr_atl_patrocina FOREIGN KEY(patrocinador_id) REFERENCES tb_patrocinador(patrocinador_id),
    CONSTRAINT fk_patr_atl_atleta FOREIGN KEY(inscricao) REFERENCES tb_atleta(inscricao)
);

/**
 *Cria a tabela "tb_corrida"
 */
CREATE TABLE tb_corrida
(
    id_corrida integer NOT NULL AUTO_INCREMENT,
    grupo char(1),
    inscricao integer,
    tempo_gasto time,
    CONSTRAINT pk_corrida PRIMARY KEY(id_corrida),
    CONSTRAINT fk_corrida_atleta FOREIGN KEY(inscricao) REFERENCES tb_atleta(inscricao)    
);

/**
 *Inclusão dos registros na tabela "tb_atleta"
 */
INSERT INTO tb_atleta VALUES
(2480, 'Mariana Rodrigues'),
(2481, 'Claudia Santos'),
(2482, 'Carlos Rodrigues'),
(2483, 'Rafael Oliveira'),
(2484, 'Juliana Silva'),
(2485, 'Patricia Pereira'),
(2489, 'Ronaldo Gonçalves'),
(2490, 'Cristiano Ferreira'),
(2495, 'Roberto Abravanel'),
(2496, 'Cristina Dias');

/**
 *Inclusão dos registros na tabela "tb_corrida"
 */
INSERT INTO tb_corrida(grupo, inscricao, tempo_gasto) VALUES
('B', 2480, '03:57:42'),
('B', 2481, '00:58:42'),
('A', 2482, '00:55:32'),
('A', 2483, '02:58:42'),
('B', 2484, '01:10:42'),
('A', 2485, '00:59:42'),
('C', 2489, '01:42:47'),
('C', 2490, '02:55:32'),
('C', 2495, '00:51:32'),
('C', 2496, '01:42:47');

/**
 *Inclusão dos registros na tabela "tb_patrocinador"
 */
INSERT INTO tb_patrocinador VALUES
(1, 'Adidas'),
(2, 'Nike'),
(3, 'Mizuno');

/**
 *Inclusão dos registros na tabela "tb_patrocinador_atleta"
 */
INSERT INTO tb_patrocinador_atleta(patrocinador_id, inscricao) VALUES
(1, 2480),
(2,  2480),
(3, 2480),
(2, 2481),
(1, 2482),
(1, 2483),
(3, 2484),
(2, 2485),
(1, 2489),
(2, 2490),
(3, 2495),
(3, 2496);

/*Exibe a classificação dos corredores (rank) na corrida*/

SELECT
classificacao.grupo,
classificacao.inscricao,
tb_atleta.nome_atleta,
classificacao.posicao,
classificacao.tempo_gasto,
pat_atleta.patrocinador_nome
FROM
(
SELECT
@posicao:=
CASE
WHEN @grupo<>grupo THEN 1
WHEN CAST(@tempo_gasto AS TIME) = tempo_gasto THEN @posicao
ELSE @posicao + 1
END
AS posicao,
tb_corrida.inscricao,
@grupo := grupo AS grupo,
@tempo_gasto:= CAST(tempo_gasto AS TIME) as tempo_gasto
FROM
(SELECT @posicao := 0, @tempo_gasto := CAST(NULL AS time), @grupo:='') x
CROSS JOIN tb_corrida
ORDER BY grupo, tempo_gasto  
)  classificacao
LEFT JOIN tb_atleta ON tb_atleta.inscricao = classificacao.inscricao
LEFT JOIN
(
  select
  tb_patrocinador_atleta.inscricao,
  GROUP_CONCAT(patrocinador_nome ORDER BY patrocinador_nome) AS patrocinador_nome 
  FROM tb_patrocinador_atleta
  JOIN tb_patrocinador 
  ON tb_patrocinador.patrocinador_id = tb_patrocinador_atleta.patrocinador_id
  GROUP BY tb_patrocinador_atleta.inscricao
) pat_atleta
ON classificacao.inscricao = pat_atleta.inscricao
ORDER BY classificacao.grupo, tempo_gasto;
