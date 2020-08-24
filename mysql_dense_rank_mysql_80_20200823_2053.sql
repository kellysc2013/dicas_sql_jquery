/*
Este exemplo mostra como exibir o rank de dados(classificação) no mysql 8.0
Utiliza a window function dense_rank
*/

/*
 *Cria a tabela "tb_classificacao"
 */
CREATE TABLE tb_classificacao
(
    time_codigo integer not null,
    time_nome varchar(255) not null,
    pontos_jogo integer  not null
);

/*
 *Inclusão dos registros na tabela "tb_classificacao"
 */
INSERT INTO tb_classificacao VALUES
(2479, 'A', 0),
(2480, 'B', 1),
(2482, 'C', 0),
(2483, 'D', 0),
(2484, 'E', 1),
(2485, 'F', 3),
(2489, 'G', 3),
(2490, 'H', 0),
(2491, 'I', 0),
(2492, 'J', 3),

(2479, 'A', 3),
(2480, 'B', 0),
(2482, 'C', 1),
(2483, 'D', 3),
(2484, 'E', 0),
(2485, 'F', 1),
(2489, 'G', 0),
(2490, 'H', 3),
(2491, 'I', 1),
(2492, 'J', 3),


(2479, 'A', 0),
(2480, 'B', 1),
(2482, 'C', 0),
(2483, 'D', 0),
(2484, 'E', 1),
(2485, 'F', 3),
(2489, 'G', 3),
(2490, 'H', 0),
(2491, 'I', 0),
(2492, 'J', 3);


/*
 *Exibe registros da tabela "tb_classificacao"
 */
SELECT * FROM tb_classificacao;



/*
 *Exibe a classificação dos times de acordo com os pontos (rank)
*/
SELECT 
DENSE_RANK()  OVER(ORDER BY tb_classificacao.total_pontos DESC) AS classificacao,
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
) tb_classificacao;
ORDER BY tb_classificacao.time_nome





