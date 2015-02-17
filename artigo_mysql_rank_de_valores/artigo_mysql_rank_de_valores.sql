/**
 *Caso queira excluir a tabela "tb_corrida", descomente o comando drop
 *DROP TABLE IF EXISTS tb_corrida;
 */
/**
 *Caso queira excluir a tabela "tb_corrida", descomente o comando drop
 *DROP TABLE IF EXISTS tb_vendas;
 */

/**
 *Cria a tabela "tb_corrida"
 */
CREATE TABLE tb_corrida
(
	grupo char(1),
	inscricao integer,
	tempo_gasto time,
	CONSTRAINT pk_inscricao PRIMARY KEY(inscricao)
);

/**
 *Inclusão dos registros na tabela "tb_corrida"
 */
INSERT INTO tb_corrida VALUES
('B', 2480, '00:57:42'),
('B', 2481, '00:58:42'),
('A', 2482, '00:55:32'),
('A', 2483, '00:58:42'),
('B', 2484, '01:10:42'),
('A', 2485, '00:59:42'),
('C', 2489, '01:42:47'),
('C', 2490, '02:55:32'),
('C', 2495, '00:51:32'),
('C', 2496, '01:42:47');


/**
 *Exibe a tabela "tb_corrida"
 */
SELECT * FROM tb_corrida;


/**
 *Cria a tabela "tb_vendas"
 */
CREATE TABLE tb_vendas
(
	vendedor_id integer,
	departamento_id char(3),
    valor decimal(10,2)
);

/**
 *Inclusão dos registros na tabela "tb_corrida"
 */
INSERT INTO tb_vendas VALUES
(248, 'B24', 500.00),
(247, 'C40', 800.00),
(232, 'M20', 200.00),
(250, 'B24', 347.00),
(248, 'B24', 238.00),
(247, 'C40', 726.00),
(232, 'M20', 980.00),
(250, 'C40', 760.00),
(248, 'B24', 224.00),
(247, 'C40', 1290.00),
(232, 'M20', 80.00),
(250, 'M20', 153.00),
(270, 'B24', 282.00),
(270, 'C40', 2000.00);
/**
 *Exibe a tabela "tb_vendas"
 */
SELECT * FROM tb_vendas;


/*1º EXEMPLO - classificação dos atletas em uma corrida de 
 *acordo com o tempo gasto para completar a prova.
 */ 

/* 
 *O 1º EXEMPLO Não leva em consideração os empates. 
 *Pode ser resolvido de duas formas
 */

/*
 *1ª FORMA
 *Declarar uma variável e utiliza-lá em um select. 
 *No nosso exemplo, vamos utilizar a variável @posicao. 
 *A variável posição é incrementada 1 unidade a cada registro.
 *Os registros foram ordenados de acordo com o tempo gasto através 
 *da clausula "ORDER BY"  
 */
SET @posicao:=0;
SELECT
    @posicao:=@posicao+1 AS posicao,
    inscricao,
    grupo,
    tempo_gasto
FROM tb_corrida
ORDER BY tempo_gasto;


/*2º FORMA
 *Também é possível, usar uma variável dentro de uma subquery sem a necessidade
 *de declara-lá no inicio através da clausula "SET".
 *No nosso caso, criamos uma subquery que recebeu o alias (apelido) 
 *de "classificacao". 
 *Fizemos um "CROSS JOIN" da subquery "classificacao" com a tabela "tb_corrida".
 *Neste exemplo, vamos utilizar a variável @posicao
 */
SELECT
    @posicao := @posicao + 1 AS posicao,
    tb_corrida.inscricao,
    tb_corrida.grupo,
    tb_corrida.tempo_gasto
FROM
(SELECT @posicao := 0) classificacao CROSS JOIN tb_corrida
ORDER BY tempo_gasto;


/*
 *A partir do 2º exemplo os empates serão levados em consideração.
 */

/*
 *2º EXEMPLO - classificação dos atletas em uma corrida de acordo com o tempo gasto
 *para completar a prova, levando em consideração o empate. 
 */

/*
 *1ª FORMA: declarar duas variáveis e utilizá-las em um select. 
 *No nosso exemplo, vamos utilizar a variável @posicao e a variável @tempo_gasto.
 *Caso o valor do tempo for igual ao tempo anterior manteremos o valor da variável
 *@posicao, caso contrário o valor da variável @posicao será 
 *incrementado em uma 1 unidade.
 */
SET @posicao:=0;
SET @tempo_gasto:=cast('00:00:00' AS time);
SELECT
@posicao:=
    CASE
        WHEN @tempo_gasto=tempo_gasto THEN @posicao
        ELSE @posicao + 1
    END
AS posicao,
inscricao,
grupo,
@tempo_gasto:= tempo_gasto as tempo_gasto
FROM tb_corrida
ORDER BY tempo_gasto;

/*
 *2ª FORMA: também é possível, usar as variáveis dentro de uma subquery, 
 *sem a necessidade declará-las através da clausulá "SET"
 *Devemos fazer um "CROSS JOIN" da subquery "classificacao" 
 *com a tabela tabela "tb_corrida".
 */
SELECT
@posicao:=
    CASE
        WHEN @tempo_gasto=tempo_gasto THEN @posicao
        ELSE @posicao + 1
    END
AS posicao,
inscricao,
grupo,
@tempo_gasto:= tempo_gasto as tempo_gasto
FROM
(SELECT @posicao:=0, @tempo_gasto:=cast('00:00:00' AS time)) classificacao 
CROSS JOIN tb_corrida
ORDER BY tempo_gasto;


/* 
 *3º EXEMPLO -Exibir a classificação dos atletas por grupo ("A", "B", "C").
 */

/*
 *1ª FORMA -Observe que os registros foram ordenados por grupo e tempo gasto.
 *Cada vez que se inicia um novo grupo é atribuído o valor 1 a variável @posicao, 
 *para que a contagem seja reiniciada.
 */
SET @posicao:=0;
SET @grupo:='';
SET @tempo_gasto:=cast('00:00:00' AS time);
SELECT
@posicao:=
    CASE
        WHEN @grupo<>grupo THEN 1
        WHEN @tempo_gasto=tempo_gasto THEN @posicao
        ELSE @posicao + 1
    END
AS posicao,
inscricao,
@grupo := grupo as grupo,
@tempo_gasto:= tempo_gasto as tempo_gasto
FROM tb_corrida
ORDER BY grupo, tempo_gasto;

/*
 *2ª FORMA - também podemos resolver o terceiro exemplo utilizando subquery.
 */
SELECT
@posicao:=
    CASE
        WHEN @grupo<>grupo THEN 1
        WHEN @tempo_gasto=tempo_gasto THEN @posicao
        ELSE @posicao + 1
    END
AS posicao,
inscricao,
@grupo := grupo,
@tempo_gasto:= tempo_gasto as tempo_gasto
FROM
(SELECT @posicao:=0, @tempo_gasto:=cast('00:00:00' AS time), @grupo:='') classificacao
CROSS JOIN tb_corrida
ORDER BY grupo, tempo_gasto;



/* 4º EXEMPLO
 * Exibir a classificação dos atletas até a 4ª posição.
 */

/*
 *Para resolver este problema os registros foram ordenados por tempo gasto.
 *Foi criada uma subquery, a qual chamamos de "tb_colocacoes".
 *A seguir, foram filtrados os registros com posição menor ou igual a 4.
 */
SET @posicao:=0;
SET @tempo_gasto:=cast('00:00:00' AS time);
SELECT * FROM
(
    SELECT
    @posicao:=
        CASE
            WHEN @tempo_gasto=tempo_gasto THEN @posicao
            ELSE @posicao + 1
        END
    AS posicao,
    inscricao,
    grupo,
    @tempo_gasto:= tempo_gasto as tempo_gasto
    FROM tb_corrida
    ORDER BY tempo_gasto
) tb_colocacoes WHERE posicao <= 4;


/* 5º EXEMPLO
 * Os atletas que alcançaram até a 2ª colocação por grupo
 */

/*Para resolver este problema foi utilizada uma subquery, a qual chamamos 
 *de "tb_colocacoes". 
 *A seguir foram filtrados os registros com posição menor ou igual a 2.
 */
SET @posicao:=0;
SET @grupo:='';
SET @tempo_gasto:=cast('00:00:00' AS time);
SELECT * FROM
(
    SELECT
    @posicao:=
        CASE
            WHEN @grupo<>grupo THEN 1
            WHEN @tempo_gasto=tempo_gasto THEN @posicao
            ELSE @posicao + 1
        END
    AS posicao,
    inscricao,
    @grupo := grupo as grupo,
    @tempo_gasto:= tempo_gasto as tempo_gasto
    FROM tb_corrida
    ORDER BY grupo, tempo_gasto
) tb_colocacoes  WHERE posicao <= 2;

/*6º EXEMPLO
 *Exibir o classificação dos vendedores, a partir do valor total das 
 *vendas. Neste exemplo, vamos utilizar uma nova tabela chamada "tb_vendas". 
 */

/*
 *Veja que antes de criar o ranking com as posições, tivemos que somar o total 
 *para cada vendedor, esta soma foi armazenada em uma subquery 
 *que recebeu o alias (apelido) de "total vendas".
 *Perceba que neste exemplo, estamos ordenando os totais por vendedor 
 *de forma decrescente (do maior para o menor)
 "ORDER BY total_vendedor DESC", pois os vendedores que venderão mais 
 *serão os primeiros. 
 */
SET @posicao:=0;
SET @total_vendedor:= 0.0;
SELECT
@posicao:=
    CASE
        WHEN @total_vendedor=total_vendedor THEN @posicao
        ELSE @posicao + 1
    END
AS posicao,
vendedor_id,
@total_vendedor:= total_vendedor as total_vendedor
FROM 
(
    SELECT vendedor_id, SUM(valor) AS total_vendedor FROM 
    tb_vendas GROUP BY vendedor_id
) total_vendas
ORDER BY total_vendedor DESC;


/*7º EXEMPLO
 *Listar os vendedores que foram classificados até 3º lugar. Neste exemplo, 
 *também vamos utilizar a tabela "tb_vendas".
 */

/*
 *Armazenamos todas as posições na subquery "vendas_gerais" e filtramos os 
 *vendedores com a posição menor ou igual a 3.
 */
SET @posicao:=0;
SET @total_vendedor:= 0.0;
SELECT * FROM
(
    SELECT
    @posicao:=
        CASE
            WHEN @total_vendedor=total_vendedor THEN @posicao
            ELSE @posicao + 1
        END
    AS posicao,
    vendedor_id,
    @total_vendedor:= total_vendedor as total_vendedor
    FROM 
    (
        SELECT vendedor_id, SUM(valor) AS total_vendedor FROM 
        tb_vendas GROUP BY vendedor_id
    ) total_vendas
    ORDER BY total_vendedor DESC
)vendas_gerais WHERE posicao <= 3;
