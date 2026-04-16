CREATE SCHEMA academico;
CREATE SCHEMA seguranca;


CREATE table academico.alunos (
    ra INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    cidade VARCHAR(100),
    ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE academico.professores (
    id_professor SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE academico.disciplinas (
    cod_disciplina VARCHAR(10) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    carga_horaria INT NOT NULL,
    id_professor INT,
    ativo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_professor)
        REFERENCES academico.professores(id_professor)
);

CREATE TABLE academico.matriculas(
    id_matricula SERIAL PRIMARY KEY,
    ra INT NOT NULL,
    cod_disciplina VARCHAR(10) NOT NULL,
    nota DECIMAL(4,1),
    data_matricula DATE,
    ciclo VARCHAR(10),
    ativo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (ra)
        REFERENCES academico.alunos(ra),
    FOREIGN KEY (cod_disciplina)
        REFERENCES academico.disciplinas(cod_disciplina)
);

    CREATE ROLE professor_role;
    GRANT SELECT (id_matricula, nota)
    ON academico.matriculas
    TO professor_role;

    GRANT UPDATE (nota)
    ON academico.matriculas
    TO professor_role;
    CREATE ROLE coordenador_role;

    GRANT ALL PRIVILEGES
    ON ALL TABLES IN SCHEMA academico
    TO coordenador_role;



    SELECT 
    a.nome AS nome_aluno,
    d.nome AS nome_disciplina,
    m.ciclo
FROM academico.matriculas m
JOIN academico.alunos a 
    ON m.ra = a.ra
JOIN academico.disciplinas d 
    ON m.cod_disciplina = d.cod_disciplina
WHERE m.ciclo = '2026/1';

SELECT 
    d.nome AS disciplina,
    AVG(m.nota) AS media_geral
FROM academico.matriculas m
JOIN academico.disciplinas d 
    ON m.cod_disciplina = d.cod_disciplina
GROUP BY d.nome
HAVING AVG(m.nota) < 6.0;

SELECT 
    p.nome AS docente,
    d.nome AS disciplina
FROM academico.professores p
LEFT JOIN academico.disciplinas d 
    ON p.id_professor = d.id_professor;

    SELECT 
    a.nome AS nome_aluno,
    m.nota
FROM academico.matriculas m
JOIN academico.alunos a 
    ON m.ra = a.ra
JOIN academico.disciplinas d 
    ON m.cod_disciplina = d.cod_disciplina
WHERE d.nome = 'Banco de Dados'
AND m.nota = (
    SELECT MAX(m2.nota)
    FROM academico.matriculas m2
    JOIN academico.disciplinas d2 
        ON m2.cod_disciplina = d2.cod_disciplina
    WHERE d2.nome = 'Banco de Dados'
);