-- Q1 Retorna o nome dos pacientes e o nome do funcionário responsável pelos atendimentos realizados em 2024.
select * from get_pacientes_funcionarios_2024();


-- Q2 Retorna a quantidade de atendimentos realizados por cada funcionário.
SELECT 
    f.nome AS funcionario,
    COUNT(a.id_atendimento) AS total_atendimentos
FROM 
    atendimento a
JOIN 
    funcionario f ON a.id_funcionario = f.id_funcionario
GROUP BY 
    f.nome;


-- Q3 Retorna os funcionários que realizaram mais de 3 atendimentos em 2024.
SELECT 
    f.nome AS funcionario,
    COUNT(a.id_atendimento) AS total_atendimentos
FROM 
    atendimento a
JOIN 
    funcionario f ON a.id_funcionario = f.id_funcionario
WHERE 
    a.data BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY 
    f.nome
HAVING 
    COUNT(a.id_atendimento) > 3;

-- Q4 Retorna todas as sessões e seus atendimentos correspondentes, mesmo que não haja um atendimento vinculado.
SELECT 
    s.id_sessao,
    a.id_atendimento,
    a.data
FROM 
    sessao s
LEFT OUTER JOIN 
    atendimento a ON s.id_atendimento = a.id_atendimento;


-- Q5 Retorna os nomes dos pacientes que possuem ao menos um tratamento relacionado a uma consulta.
SELECT 
    p.nome
FROM 
    paciente p
WHERE 
    p.id_paciente IN (
        SELECT 
            a.id_paciente
        FROM 
            atendimento a
        JOIN 
            consulta c ON a.id_atendimento = c.id_atendimento
        JOIN 
            consulta_tratamento ct ON c.id_consulta = ct.id_consulta
    );


-- Q6 Retorna os tratamentos e suas sessões, com a contagem de sessões para cada tratamento.
WITH tratamento_sessao_count AS (
    SELECT 
        t.id_tratamento,
        COUNT(ts.id_sessao) AS total_sessoes
    FROM 
        tratamento t
    JOIN 
        tratamento_sessao ts ON t.id_tratamento = ts.id_tratamento
    GROUP BY 
        t.id_tratamento
)
SELECT 
    tsc.id_tratamento,
    tsc.total_sessoes
FROM 
    tratamento_sessao_count tsc;

-- Q7 Retorna os nomes dos pacientes que possuem pelo menos uma consulta.
SELECT 
    p.nome
FROM 
    paciente p
WHERE 
    EXISTS (
        SELECT 
            1
        FROM 
            atendimento a
        JOIN 
            consulta c ON a.id_atendimento = c.id_atendimento
        WHERE 
            a.id_paciente = p.id_paciente
    );


-- Q8 Retorna pares de atendimentos realizados pelo mesmo funcionário em dias diferentes.
SELECT 
    a1.id_atendimento AS atendimento_1,
    a2.id_atendimento AS atendimento_2,
    f.nome AS funcionario
FROM 
    atendimento a1
JOIN 
    atendimento a2 ON a1.id_funcionario = a2.id_funcionario AND a1.data <> a2.data
JOIN 
    funcionario f ON a1.id_funcionario = f.id_funcionario;


-- Q9 Retorna os pacientes que participaram de todas as sessões realizadas.
SELECT 
    p.nome
FROM 
    paciente p
WHERE 
    NOT EXISTS (
        SELECT 
            s.id_sessao
        FROM 
            sessao s
        WHERE 
            NOT EXISTS (
                SELECT 
                    1
                FROM 
                    atendimento a
                WHERE 
                    a.id_paciente = p.id_paciente AND a.id_atendimento = s.id_atendimento
            )
    );

-- Q10 Retorna os pacientes cujo nome começa com a letra "M".
SELECT 
    nome
FROM 
    paciente
WHERE 
    nome LIKE 'M%';

-- Q11 Retorna os funcionários que realizaram atendimentos em todas as datas disponíveis.
SELECT 
    f.nome
FROM 
    funcionario f
WHERE 
    f.id_funcionario = ALL (
        SELECT 
            a.id_funcionario
        FROM 
            atendimento a
        WHERE 
            a.data IS NOT NULL
    );


-- Q12 Retorna a contagem de atendimentos por paciente, junto com o funcionário que realizou mais atendimentos para cada paciente.
WITH atendimento_contagem AS (
    SELECT 
        a.id_paciente,
        f.nome AS funcionario,
        COUNT(a.id_atendimento) AS total_atendimentos
    FROM 
        atendimento a
    JOIN 
        funcionario f ON a.id_funcionario = f.id_funcionario
    GROUP BY 
        a.id_paciente, f.nome
)
SELECT 
    ac.id_paciente,
    p.nome AS paciente,
    ac.funcionario,
    ac.total_atendimentos
FROM 
    atendimento_contagem ac
JOIN 
    paciente p ON ac.id_paciente = p.id_paciente
ORDER BY 
    ac.total_atendimentos DESC;
