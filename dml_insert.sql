INSERT INTO funcionario (id_funcionario, nome, cartao_cidadao, salario, area)
VALUES 
(1, 'Dr. João Silva', '123456789', 3000.00, 'Neurologia'),
(2, 'Dra. Ana Costa', '987654321', 3500.00, 'Ortopedia'),
(3, 'Dr. Pedro Mendes', '456789123', 3200.00, 'Radiologia'),
(4, 'Dra. Clara Santos', '789123456', 3300.00, 'Oncologia'),
(5, 'Dr. Miguel Oliveira', '321654987', 3100.00, 'Reabilitação'),
(6, 'Dra. Sofia Almeida', '654987321', 3400.00, 'Dermatologia'),
(7, 'Dr. Paulo Rocha', '159753486', 3100.00, 'Cirurgia'),
(8, 'Dra. Marina Lima', '753159486', 3000.00, 'Cardiologia'),
(9, 'Dr. Lucas Carvalho', '987321654', 2900.00, 'Idosos'),
(10, 'Dra. Juliana Ribeiro', '951753258', 3050.00, 'Esportes');


INSERT INTO dono_paciente (id_dono, telefone, email)
VALUES 
(1, '912345678', 'maria.santos@example.com'),
(2, '924567891', 'carlos.oliveira@example.com'),
(3, '935678912', 'ana.costa@example.com'),
(4, '946789123', 'joao.silva@example.com'),
(5, '957891234', 'paulo.rocha@example.com'),
(6, '968912345', 'marina.lima@example.com'),
(7, '979123456', 'lucas.carvalho@example.com'),
(8, '981234567', 'juliana.ribeiro@example.com'),
(9, '991345678', 'sofia.almeida@example.com'),
(10, '902456789', 'miguel.oliveira@example.com');



INSERT INTO paciente (id_paciente, id_dono, nome, animal, raca, data_nascimento, condicao, historico)
VALUES 
(1, 1, 'Rex', 'Cachorro', 'Labrador', '2020-05-10', 'Doente', 'Tratamento para lesão na pata.'),
(2, 2, 'Mia', 'Gato', 'Siamês', '2018-08-20', 'Saudável', 'Check-up de rotina.'),
(3, 3, 'Thor', 'Cachorro', 'Pastor Alemão', '2019-01-15', 'Em recuperação', 'Reabilitação pós-cirúrgica.'),
(4, 4, 'Luna', 'Gato', 'Persa', '2021-03-12', 'Saudável', 'Consulta dermatológica.'),
(5, 5, 'Max', 'Cachorro', 'Golden Retriever', '2017-11-25', 'Idoso', 'Controle de dor articular.'),
(6, 6, 'Bella', 'Cachorro', 'Beagle', '2022-01-05', 'Doente', 'Tratamento para infecção.'),
(7, 7, 'Simba', 'Gato', 'Maine Coon', '2020-07-22', 'Saudável', 'Avaliação cardiológica.'),
(8, 8, 'Zeus', 'Cachorro', 'Husky Siberiano', '2019-09-10', 'Em recuperação', 'Reabilitação após fratura.'),
(9, 9, 'Chloe', 'Gato', 'Bengal', '2021-05-15', 'Saudável', 'Consulta geral.'),
(10, 10, 'Toby', 'Cachorro', 'Poodle', '2016-02-11', 'Idoso', 'Tratamento de artrite.');




INSERT INTO atendimento (id_atendimento, id_funcionario, id_paciente, data, hora, observacao, situacao)
VALUES 
(1, 1, 1, '2024-01-15', '10:00:00', 'Avaliação inicial para reabilitação.', 'Agendado'),
(2, 2, 2, '2024-01-16', '11:00:00', 'Consulta de rotina.', 'Executado'),
(3, 3, 3, '2024-01-17', '09:30:00', 'Sessão de reabilitação pós-cirúrgica.', 'Executado'),
(4, 4, 4, '2024-01-18', '14:00:00', 'Consulta dermatológica.', 'Executado'),
(5, 5, 5, '2024-01-19', '13:00:00', 'Controle de dor articular.', 'Agendado'),
(6, 6, 6, '2024-01-20', '15:30:00', 'Tratamento para infecção.', 'Executado'),
(7, 7, 7, '2024-01-21', '16:00:00', 'Avaliação cardiológica.', 'Agendado'),
(8, 8, 8, '2024-01-22', '10:30:00', 'Reabilitação após fratura.', 'Executado'),
(9, 9, 9, '2024-01-23', '12:00:00', 'Consulta geral.', 'Cancelado'),
(10, 10, 10, '2024-01-24', '08:00:00', 'Tratamento de artrite.', 'Agendado');




INSERT INTO consulta (id_consulta, id_atendimento)
VALUES 
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);



INSERT INTO tratamento (id_tratamento, historico)
VALUES 
(1, 'Reabilitação para lesão na pata.'),
(2, 'Consulta de rotina.'),
(3, 'Reabilitação pós-cirúrgica.'),
(4, 'Consulta dermatológica.'),
(5, 'Controle de dor articular.'),
(6, 'Tratamento para infecção.'),
(7, 'Avaliação cardiológica.'),
(8, 'Reabilitação após fratura.'),
(9, 'Consulta geral.'),
(10, 'Tratamento de artrite.');




INSERT INTO consulta_tratamento (id_consulta, id_tratamento)
VALUES 
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);




INSERT INTO sessao (id_sessao, id_atendimento)
VALUES 
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);



INSERT INTO tratamento_sessao (id_tratamento, id_sessao)
VALUES 
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);



-- Registros adicionais para o Dr. João Silva
INSERT INTO atendimento (id_atendimento, id_funcionario, id_paciente, data, hora, observacao, situacao)
VALUES 
(11, 1, 3, '2024-02-01', '09:00:00', 'Revisão pós-reabilitação.', 'Executado'),
(12, 1, 5, '2024-02-02', '10:30:00', 'Controle de dor articular avançado.', 'Agendado'),
(13, 1, 7, '2024-02-03', '14:00:00', 'Consulta de cardiologia.', 'Executado'),
(14, 1, 9, '2024-02-04', '11:00:00', 'Consulta geral.', 'Agendado'),
(15, 1, 1, '2024-02-05', '16:00:00', 'Acompanhamento de reabilitação.', 'Executado');



INSERT INTO consulta (id_consulta, id_atendimento)
VALUES 
(11, 11), (12, 12), (13, 13), (14, 14), (15, 15);



INSERT INTO tratamento (id_tratamento, historico)
VALUES 
(11, 'Revisão de reabilitação pós-lesão.'),
(12, 'Controle de dor articular com nova abordagem.'),
(13, 'Consulta de cardiologia detalhada.'),
(14, 'Consulta geral para avaliação.'),
(15, 'Acompanhamento de reabilitação.');




INSERT INTO consulta_tratamento (id_consulta, id_tratamento)
VALUES 
(11, 11), (12, 12), (13, 13), (14, 14), (15, 15);



INSERT INTO sessao (id_sessao, id_atendimento)
VALUES 
(11, 11), (12, 12), (13, 13), (14, 14), (15, 15);



INSERT INTO tratamento_sessao (id_tratamento, id_sessao)
VALUES 
(11, 11), (12, 12), (13, 13), (14, 14), (15, 15);
