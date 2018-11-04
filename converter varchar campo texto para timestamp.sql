--SEM TIME ZONE (sem fuso horário)
SELECT to_timestamp('2018-11-02 14:35:43', 'YYYY-MM-DD hh24:mi:ss') ::timestamp without time zone

--COM TIME ZONE (fuso horário)
SELECT to_timestamp('2018-11-02 14:35:43', 'YYYY-MM-DD hh24:mi:ss')
