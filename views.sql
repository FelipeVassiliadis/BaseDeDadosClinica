-- Administradores tem acesso a todos os atendimentos
create or replace VIEW atendimento_administrativo AS
SELECT 
    id_atendimento,
    id_paciente,
    data,
    hora,
    situacao
FROM 
    atendimento;

--exemplo de uso:
select * from atendimento_administrativo;

-- Medicos tem acesso apenas aos seus atendimentos
CREATE or replace VIEW atendimento_medico AS
SELECT 
    *
FROM 
    atendimento
WHERE 
    id_funcionario = current_setting('user.id')::BIGINT;
 
-- exemplo de uso:
SELECT set_config('user.id', '1', false); -- Define o id_funcionario como 1
select * from atendimento_medico;

