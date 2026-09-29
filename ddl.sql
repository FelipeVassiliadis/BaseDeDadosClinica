CREATE DATABASE fisioterapia
WITH 
    OWNER fisio
    ENCODING 'UTF8' 
    LC_COLLATE='pt_PT.UTF-8'
    LC_CTYPE='pt_PT.UTF-8'
    TEMPLATE template0;


CREATE TYPE area_foco AS ENUM (
	'Cirurgia',
	'Dermatologia',
	'Cardiologia',
	'Oncologia',
	'Radiologia',
	'Ortopedia',
	'Neurologia',
	'Reabilitação',
	'Idosos',
	'Esportes',
    'Geral');

CREATE TYPE paciente_condicao AS ENUM (
	'Saudável',
	'Doente',
	'Em recuperação',
	'Idoso');

CREATE TYPE situacao_atendimento AS ENUM (
	'Agendado',
	'Cancelado',
	'Executado');

CREATE TABLE atendimento
(
  id_atendimento bigint NOT NULL,
  id_funcionario bigint NOT NULL,
  id_paciente bigint NOT NULL,
  data date NOT NULL,
  hora time NOT NULL,
  observacao text,
  situacao situacao_atendimento
)
;

ALTER TABLE atendimento ADD CONSTRAINT pk_atendimento
  PRIMARY KEY (id_atendimento)
;

CREATE TABLE consulta
(
  id_consulta bigint NOT NULL,
  id_atendimento bigint NOT NULL
)
;

ALTER TABLE consulta ADD CONSTRAINT pk_consulta
  PRIMARY KEY (id_consulta)
;

CREATE TABLE consulta_tratamento
(
  id_consulta bigint NOT NULL,
  id_tratamento bigint NOT NULL
)
;

ALTER TABLE consulta_tratamento ADD CONSTRAINT pk_consulta_tratamento
  PRIMARY KEY (id_consulta, id_tratamento)
;

CREATE TABLE dono_paciente
(
  id_dono bigint NOT NULL,
  telefone varchar(50),
  email varchar(100),
    CONSTRAINT email_valido CHECK (
        email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'
    )
)
;

ALTER TABLE dono_paciente ADD CONSTRAINT pk_dono_paciente
  PRIMARY KEY (id_dono)
;

CREATE TABLE funcionario
(
  id_funcionario bigint NOT NULL,
  nome varchar(255) NOT NULL,
  cartao_cidadao varchar(50) NOT NULL,
  salario numeric(10,2) NOT NULL,
  area area_foco NOT NULL DEFAULT 'Geral'
)
;

ALTER TABLE funcionario ADD CONSTRAINT pk_funcionario
  PRIMARY KEY (id_funcionario)
;

CREATE TABLE paciente
(
  id_paciente bigint NOT NULL,
  id_dono bigint,
  nome varchar(255) NOT NULL,
  animal varchar(100),
  raca varchar(100),
  data_nascimento date,
  condicao paciente_condicao,
  historico text
)
;

ALTER TABLE paciente ADD CONSTRAINT pk_paciente
  PRIMARY KEY (id_paciente)
;

CREATE TABLE sessao
(
  id_sessao bigint NOT NULL,
  id_atendimento bigint NOT NULL
)
;

ALTER TABLE sessao ADD CONSTRAINT pk_sessao
  PRIMARY KEY (id_sessao)
;

CREATE TABLE tratamento
(
  id_tratamento bigint NOT NULL,
  historico text
)
;

ALTER TABLE tratamento ADD CONSTRAINT pk_tratamento
  PRIMARY KEY (id_tratamento)
;

CREATE TABLE tratamento_sessao
(
  id_tratamento bigint NOT NULL,
  id_sessao bigint NOT NULL
)
;

ALTER TABLE tratamento_sessao ADD CONSTRAINT pk_tratamento_sessao
  PRIMARY KEY (id_tratamento, id_sessao)
;

ALTER TABLE atendimento ADD CONSTRAINT fk_atendimento_funcionario
  FOREIGN KEY (id_funcionario) REFERENCES funcionario (id_funcionario)
;

ALTER TABLE atendimento ADD CONSTRAINT fk_atendimento_paciente
  FOREIGN KEY (id_paciente) REFERENCES paciente (id_paciente)
;

ALTER TABLE consulta ADD CONSTRAINT fk_consulta_atendimento
  FOREIGN KEY (id_atendimento) REFERENCES atendimento (id_atendimento)
;

ALTER TABLE consulta_tratamento ADD CONSTRAINT fk_consulta_tratamento_consulta
  FOREIGN KEY (id_consulta) REFERENCES consulta (id_consulta)
;

ALTER TABLE consulta_tratamento ADD CONSTRAINT fk_consulta_tratamento_tratamento
  FOREIGN KEY (id_tratamento) REFERENCES tratamento (id_tratamento)
;

ALTER TABLE paciente ADD CONSTRAINT fk_paciente_dono
  FOREIGN KEY (id_dono) REFERENCES dono_paciente (id_dono)
;

ALTER TABLE sessao ADD CONSTRAINT fk_sessao_atendimento
  FOREIGN KEY (id_atendimento) REFERENCES atendimento (id_atendimento)
;

ALTER TABLE tratamento_sessao ADD CONSTRAINT fk_tratamento_sessao_sessao
  FOREIGN KEY (id_sessao) REFERENCES sessao (id_sessao)
;

ALTER TABLE tratamento_sessao ADD CONSTRAINT fk_tratamento_sessao_tratamento
  FOREIGN KEY (id_tratamento) REFERENCES tratamento (id_tratamento)
;
