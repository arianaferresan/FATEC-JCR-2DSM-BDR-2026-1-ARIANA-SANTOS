DROP TABLE IF EXISTS carro, pessoa;

CREATE TABLE IF NOT EXISTS pessoa ( 
id_pessoa INTEGER PRIMARY KEY, 
nome VARCHAR(100) NOT NULL, 
nascimento DATE 
); 

CREATE TABLE IF NOT EXISTS carro ( 
id_carro INTEGER PRIMARY KEY, 
placa CHAR(7) NOT NULL, 
ano INTEGER, 
id_pessoa INTEGER NOT NULL, 
FOREIGN KEY (id_pessoa) 
REFERENCES pessoa(id_pessoa) 
ON DELETE CASCADE 
); 

COPY pessoa (id_pessoa, nome, nascimento)
FROM 'C:/Users/Ariana/Downloads/aula3_pessoa.csv'
DELIMITER ','
CSV HEADER;

COPY carro (id_carro, placa, ano, 
id_pessoa) 
FROM 'C:/caminho/aula3_carro.csv' 
DELIMITER ',' 
CSV HEADER; 

EXPLAIN ANALYZE 
SELECT * 
FROM pessoa 
WHERE nome = 'Ana Silva'; 

EXPLAIN ANALYZE 
SELECT * 
FROM pessoa 
WHERE nome = 'João Santos'; 

CREATE INDEX idx_pessoa_nome 
ON pessoa (nome);

EXPLAIN ANALYZE 
SELECT * 
FROM pessoa 
WHERE nome = 'Ana Silva'; 

EXPLAIN ANALYZE 
SELECT * 
FROM pessoa 
WHERE nome = 'João Santos'; 

DROP INDEX IF EXISTS idx_pessoa_nome; 

EXPLAIN ANALYZE 
SELECT * 
FROM pessoa 
WHERE nascimento >= DATE '1970-01-01';

CREATE INDEX idx_pessoa_nascimento
ON pessoa (nascimento);

EXPLAIN ANALYZE
SELECT *
FROM pessoa
WHERE nascimento >= DATE '1970-01-01';

DROP INDEX IF EXISTS idx_pessoa_nascimento; 

EXPLAIN ANALYZE
SELECT *
FROM pessoa
WHERE nascimento >= DATE '2000-01-01'
  AND nome = 'Ana Silva';

 CREATE INDEX idx_pessoa_nascimento_nome 
ON pessoa (nascimento, nome); 

EXPLAIN ANALYZE
SELECT *
FROM pessoa
WHERE nascimento >= DATE '2000-01-01'
  AND nome = 'Ana Silva';

  EXPLAIN ANALYZE 
SELECT * 
FROM pessoa 
WHERE nome = 'Ana Silva'; 

DROP INDEX IF EXISTS idx_pessoa_nascimento_nome;

CREATE INDEX idx_pessoa_nascimento 
ON pessoa (nascimento); 
CREATE INDEX idx_pessoa_nome 
ON pessoa (nome);

EXPLAIN ANALYZE 
SELECT * 
FROM pessoa 
WHERE nascimento >= DATE '2000-01-01' 
AND nome = 'Ana Silva'; 

EXPLAIN ANALYZE 
SELECT * 
FROM carro 
WHERE ano BETWEEN 2015 AND 2020; 

CREATE INDEX idx_carro_ano
ON carro (ano);

DROP INDEX IF EXISTS idx_carro_ano;

EXPLAIN ANALYZE
SELECT *
FROM carro
WHERE ano BETWEEN 2015 AND 2020;

DROP INDEX IF EXISTS idx_carro_ano;
DROP INDEX IF EXISTS idx_pessoa_nome;
DROP INDEX IF EXISTS idx_pessoa_nascimento;
DROP INDEX IF EXISTS idx_carro_id_pessoa;

EXPLAIN ANALYZE 
SELECT p.nome, c.placa 
FROM pessoa p 
JOIN carro c ON p.id_pessoa = c.id_pessoa 
WHERE p.nome = 'Ana Silva'; 

CREATE INDEX idx_pessoa_nome
ON pessoa(nome);

CREATE INDEX idx_carro_id_pessoa
ON carro(id_pessoa);

EXPLAIN ANALYZE 
SELECT p.nome, c.placa, c.ano 
FROM pessoa p 
JOIN carro c ON p.id_pessoa = c.id_pessoa 
WHERE p.nascimento >= DATE '1980-01-01' 
AND c.ano >= 2018; 

DROP INDEX IF EXISTS idx_pessoa_nome;
DROP INDEX IF EXISTS idx_carro_id_pessoa;

EXPLAIN ANALYZE
SELECT p.nome, c.placa, c.ano
FROM pessoa p
JOIN carro c ON p.id_pessoa = c.id_pessoa
WHERE p.nascimento >= DATE '1980-01-01'
  AND c.ano >= 2018;

  CREATE INDEX idx_pessoa_nascimento
ON pessoa (nascimento);

CREATE INDEX idx_carro_ano_id_pessoa
ON carro (ano, id_pessoa);

DROP INDEX IF EXISTS idx_pessoa_nascimento;
DROP INDEX IF EXISTS idx_carro_ano_id_pessoa;

EXPLAIN ANALYZE
SELECT *
FROM pessoa
WHERE nascimento BETWEEN DATE '1980-01-01'
AND DATE '1990-12-31';

CREATE EXTENSION IF NOT EXISTS btree_gist;

CREATE INDEX idx_pessoa_nascimento_gist
ON pessoa
USING GIST (nascimento);

EXPLAIN ANALYZE
SELECT *
FROM pessoa
WHERE nascimento BETWEEN DATE '1980-01-01'
AND DATE '1990-12-31';