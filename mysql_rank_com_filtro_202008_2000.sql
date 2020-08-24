/*Rank com filtro no mysql 8*/
SELECT * FROM
(
	SELECT
	DENSE_RANK() OVER(ORDER BY tb_classificacao.total_pontos DESC) AS classificacao,
	tb_classificacao.time_codigo,
	tb_classificacao.time_nome,
	tb_classificacao.total_pontos
	FROM
	(
		SELECT
		time_codigo,
		time_nome,
		SUM(pontos_jogo) AS total_pontos
		FROM tb_classificacao
		GROUP BY
		time_codigo, time_nome
	) tb_classificacao
)  filtro
WHERE filtro.classificacao = 5



/*Rank com filtro no mysql 5*/
SELECT * FROM (
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
  time_nome DESC
 )rn WHERE rn.classificacao = 5;

