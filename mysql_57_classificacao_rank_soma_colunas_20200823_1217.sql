/*
 *Cria a tabela "tb_classificacao"
 */
CREATE TABLE tb_classificacao
(
    time_codigo integer not null,
    time_nome varchar(255) not null,
    pontos_jogo_1 integer  not null,
    pontos_jogo_2 integer  not null,
    pontos_jogo_3  integer not null,
    CONSTRAINT pk_inscricao PRIMARY KEY(time_codigo)
);

/*
 *Inclusão dos registros na tabela "tb_classificacao"
 */
INSERT INTO tb_classificacao VALUES
(2479, 'A', 0,1,3),
(2480, 'A', 0,1,3),
(2481, 'B', 3,0,1),
(2482, 'C', 0,1,3),
(2483, 'D', 0,0,1),
(2484, 'E', 1,1,1),
(2485, 'F', 3,1,3),
(2489, 'G', 3,3,3),
(2490, 'H', 0,0,0),
(2495, 'I', 0,0,3),
(2496, 'J', 1,1,3);

/* 
 *EXEMPLO - Exibir a classificação dos times.
 *Observação: use a função "IFNULL" caso uma das colunas permita 
 *dado nulo (coluna null).
 *A função IFNULL substitui "nulo" por "0" zero.
 *Se ao somar colunas o valor de pelo menos uma delas for nulo
 *o resultado será nulo e não é esse o resultado esperado.
 */
SELECT
@posicao:=
    CASE
        WHEN (@total_pontos = IFNULL(pontos_jogo_1, 0) + IFNULL(pontos_jogo_2, 0) + IFNULL(pontos_jogo_3, 0)) 
			THEN @posicao
			ELSE @posicao + 1
    END
AS classificacao,
time_codigo,
time_nome,
@total_pontos:= IFNULL(pontos_jogo_1, 0) + IFNULL(pontos_jogo_2, 0) + IFNULL(pontos_jogo_3, 0)
AS total_pontos
FROM
(SELECT @posicao := 0, @total_pontos) classificacao 
CROSS JOIN tb_classificacao
ORDER BY
IFNULL(pontos_jogo_1, 0) + IFNULL(pontos_jogo_2, 0) + IFNULL(pontos_jogo_3, 0) DESC, 
time_nome DESC;
