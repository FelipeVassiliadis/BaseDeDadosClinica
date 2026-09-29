-- Retorna todas as consultas e tratamentos de um paciente pelo ID.
-- Parâmetro: p_id_paciente (BIGINT) - ID do paciente.
-- Retorno: consulta_id, data_consulta, hora_consulta, funcionario_nome, tratamento_id, tratamento_historico.
-- Exemplo: SELECT * FROM get_consultas_tratamentos(1);


CREATE OR REPLACE FUNCTION get_consultas_tratamentos(p_id_paciente BIGINT)
RETURNS TABLE (
    consulta_id BIGINT,
    data_consulta DATE,
    hora_consulta TIME,
    funcionario_nome VARCHAR,
    tratamento_id BIGINT,
    tratamento_historico TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        c.id_consulta,
        a.data AS data_consulta,
        a.hora AS hora_consulta,
        f.nome AS funcionario_nome,
        t.id_tratamento,
        t.historico AS tratamento_historico
    FROM
        atendimento a
    JOIN
        consulta c ON c.id_atendimento = a.id_atendimento
    LEFT JOIN
        consulta_tratamento ct ON c.id_consulta = ct.id_consulta
    LEFT JOIN
        tratamento t ON ct.id_tratamento = t.id_tratamento
    JOIN
        funcionario f ON a.id_funcionario = f.id_funcionario
    WHERE
        a.id_paciente = p_id_paciente;
END;
$$ LANGUAGE plpgsql;


-- exemplo de uso
SELECT * FROM get_consultas_tratamentos(1);


-- Garantir que o tratamento e a sessão vinculados estão relacionados ao mesmo paciente

-- Verifica se a consulta e o tratamento pertencem ao mesmo paciente
CREATE OR REPLACE FUNCTION validar_consulta_tratamento_paciente()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se a consulta e o tratamento pertencem ao mesmo paciente
    IF NOT EXISTS (
        SELECT 1
        FROM consulta c
        JOIN atendimento a ON c.id_atendimento = a.id_atendimento
        WHERE c.id_consulta = NEW.id_consulta
          AND a.id_paciente = (
              SELECT a2.id_paciente
              FROM atendimento a2
              JOIN sessao s ON a2.id_atendimento = s.id_atendimento
              JOIN tratamento_sessao ts ON s.id_sessao = ts.id_sessao
              WHERE ts.id_tratamento = NEW.id_tratamento
          )
    ) THEN
        RAISE EXCEPTION 'A consulta e o tratamento não estão relacionados ao mesmo paciente.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validar_consulta_tratamento_paciente
BEFORE INSERT OR UPDATE ON consulta_tratamento
FOR EACH ROW
EXECUTE FUNCTION validar_consulta_tratamento_paciente();




-- Verifica se o tratamento e a sessão pertencem ao mesmo paciente
CREATE OR REPLACE FUNCTION validar_tratamento_sessao_paciente()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se o tratamento e a sessão pertencem ao mesmo paciente
    IF NOT EXISTS (
        SELECT 1
        FROM sessao s
        JOIN atendimento a ON s.id_atendimento = a.id_atendimento
        WHERE s.id_sessao = NEW.id_sessao
          AND a.id_paciente = (
              SELECT a2.id_paciente
              FROM consulta c
              JOIN atendimento a2 ON c.id_atendimento = a2.id_atendimento
              JOIN consulta_tratamento ct ON c.id_consulta = ct.id_consulta
              WHERE ct.id_tratamento = NEW.id_tratamento
          )
    ) THEN
        RAISE EXCEPTION 'O tratamento e a sessão não estão relacionados ao mesmo paciente.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validar_tratamento_sessao_paciente
BEFORE INSERT OR UPDATE ON tratamento_sessao
FOR EACH ROW
EXECUTE FUNCTION validar_tratamento_sessao_paciente();


-- Exemplo de erro ao tentar criar um tratamento_sessao para consultas invalidas
INSERT INTO consulta_tratamento (id_consulta, id_tratamento) VALUES (1, 2);


--função que retorna os paciente dos funcionarios em 2024
CREATE OR REPLACE FUNCTION get_pacientes_funcionarios_2024()
RETURNS TABLE (
    paciente_nome VARCHAR,
    funcionario_nome VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.nome AS paciente_nome,
        f.nome AS funcionario_nome
    FROM 
        atendimento a
    JOIN 
        paciente p ON a.id_paciente = p.id_paciente
    JOIN 
        funcionario f ON a.id_funcionario = f.id_funcionario
    WHERE 
        a.data BETWEEN '2024-01-01' AND '2024-12-31';
END;
$$ LANGUAGE plpgsql;
--exemplo de uso:
select * from get_pacientes_funcionarios_2024();
