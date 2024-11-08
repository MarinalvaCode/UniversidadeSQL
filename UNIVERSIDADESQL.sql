
CREATE DATABASE Universidade;
GO
USE Universidade;
GO


CREATE TABLE Curso (
    NumCurso INT PRIMARY KEY,
    Nome NVARCHAR(100),
    TotalCreditos INT
);

CREATE TABLE Aluno (
    NumAluno INT PRIMARY KEY,
    Nome NVARCHAR(100),
    Endereco NVARCHAR(100),
    Cidade NVARCHAR(50),
    Telefone NVARCHAR(20),
    NumCurso INT,
    FOREIGN KEY (NumCurso) REFERENCES Curso(NumCurso)
);

CREATE TABLE Disciplina (
    NumDisp INT PRIMARY KEY,
    Nome NVARCHAR(100),
    QuantCreditos INT
);

CREATE TABLE Professor (
    NumFunc INT PRIMARY KEY,
    Nome NVARCHAR(100),
    Admissao DATE,
    AreaPesquisa NVARCHAR(50)
);

CREATE TABLE Aula (
    NumAluno INT,
    NumDisp INT,
    NumFunc INT,
    Semestre NVARCHAR(10),
    Nota DECIMAL(3, 1),
    PRIMARY KEY (NumAluno, NumDisp, Semestre),
    FOREIGN KEY (NumAluno) REFERENCES Aluno(NumAluno),
    FOREIGN KEY (NumDisp) REFERENCES Disciplina(NumDisp),
    FOREIGN KEY (NumFunc) REFERENCES Professor(NumFunc),
);

CREATE TABLE DisciplinaCurso (
    NumDisp INT,
    NumCurso INT,
    PRIMARY KEY (NumDisp, NumCurso),
    FOREIGN KEY (NumDisp) REFERENCES Disciplina(NumDisp),
    FOREIGN KEY (NumCurso) REFERENCES Curso(NumCurso)
);

INSERT INTO Professor (NumFunc, Nome, Admissao, AreaPesquisa) VALUES
(45675, 'Abgair Simon Ferreira', '1992-04-10', 'Banco de Dados'),
(45690, 'Ramon Travanti', '1993-05-20', 'Direito Romano'),
(45691, 'Gustavo Golveia Netto', '1993-05-04', 'Sociologia'),
(45692, 'Marcos Salvador', '1993-03-31', 'Matemática Financeira'),
(45693, 'Cintia Falcão', '1993-05-12', 'Engenharia Software');

INSERT INTO Curso (NumCurso, Nome, TotalCreditos) VALUES
(2142, 'Engenharia Civil', 1500),
(2143, 'Ciência da Computação', 2000),
(2144, 'Direito', 1750),
(2145, 'Pedagogia', 1500),
(2146, 'Odontologia', 1600);

INSERT INTO Disciplina (NumDisp, Nome, QuantCreditos) VALUES
(1, 'Banco de Dados', 30),
(2, 'Estrutura de Dados', 35),
(3, 'Direito Penal', 40),
(4, 'Economia', 30),
(5, 'Psicologia Infantil', 25),
(6, 'Engenharia Software', 45),
(7, 'Calculo Numerico', 40);

INSERT INTO DisciplinaCurso (NumDisp, NumCurso) VALUES
(1, 2143),
(2, 2143),
(3, 2144),
(4, 2142),
(5, 2145),
(6, 2143),
(7, 2142);

INSERT INTO Aluno (NumAluno, Nome, Endereco, Cidade, Telefone, NumCurso) VALUES
(111, 'Edvaldo Carlos Silva', 'Av. São Carlos 186', 'São Carlos - SP', '(017) 276-9999', 2143),
(112, 'João Benedito Scapin', 'R. José Bonifácio 70', 'São Carlos - SP', '(017) 273-8974', 2142),
(113, 'Carol Antonia Silveira', 'R. Luiz Camões 120', 'Ibaté - SP', '(017) 273-8974', 2145),
(114, 'Marcos joão Casanova', 'Av São carlos, 176', 'São Carlos - SP', '(017) 278-8568', 2142),
(115, 'Simone Cristina Lima', 'R Raul  Junior, 180', 'São Carlos - SP', '(017) 273-9865', 2144),
(117, 'José Paulo Figueira', 'R XV Novembro. 871','São Carlos - SP', '(017) 274-9874', 2145)
INSERT INTO Aula (NumAluno, NumDisp, NumFunc, Semestre, Nota) VALUES
(111, 1, 45675, '01/1998', 8.5),
(111, 2, 45675, '01/1998', 6.0),
(111, 2, 45674, '02/1998', 7.0),
(115, 3, 45690, '01/1998', 4.5),
(115, 2, 45690, '01/1998', 7.5),
(111, 4, 45692, '01/1998', 8.0),
(112, 4, 45692, '01/1998', 7.0),
(113, 5, 45691, '01/1998', 7.5),
(115, 6, 45691, '01/1998', 9.0),
(111, 7, 45693, '01/1998', 10.0);
(114, 2, 45675, '01/1998', 5.5);
(114, 7, 456693, '02/1998', 10.0);


SELECT Nome
FROM Curso;

SELECT Nome, Telefone
FROM Aluno
WHERE Cidade = 'São Carlos - SP'
ORDER BY Nome DESC;

SELECT Nome
FROM Professor
WHERE Admissao < '1993-01-01';

SELECT Nome
FROM Aluno
WHERE Nome LIKE 'J%';

SELECT D.Nome
FROM Disciplina D
JOIN DisciplinaCurso DC ON D.NumDisp = DC.NumDisp
JOIN Curso C ON DC.NumCurso = C.NumCurso
WHERE C.Nome = 'Ciência da Computação';

SELECT C.Nome
FROM Curso C
JOIN DisciplinaCurso DC ON C.NumCurso = DC.NumCurso
JOIN Disciplina D ON DC.NumDisp = D.NumDisp
WHERE D.Nome = 'Calculo Numerico';

SELECT D.Nome
FROM Aula A
JOIN Disciplina D ON A.NumDisp = D.NumDisp
JOIN Aluno Al ON A.NumAluno = Al.NumAluno
WHERE Al.Nome = 'Marcos João Casanova' AND A.Semestre = '01/1998';

SELECT D.Nome
FROM Aula A
JOIN Disciplina D ON A.NumDisp = D.NumDisp
JOIN Aluno Al ON A.NumAluno = Al.NumAluno
WHERE Al.Nome = 'Ailton Castro' AND A.Nota < 5.0;

SELECT Al.Nome
FROM Aula A
JOIN Aluno Al ON A.NumAluno = Al.NumAluno
JOIN Disciplina D ON A.NumDisp = D.NumDisp
WHERE D.Nome = 'Calculo Numerico' AND A.Semestre = '01/1998' AND A.Nota < 5.0;

SELECT D.Nome
FROM Aula A
JOIN Disciplina D ON A.NumDisp = D.NumDisp
JOIN Professor P ON A.NumFunc = P.NumFunc
WHERE P.Nome = 'Ramon Travanti';

SELECT DISTINCT P.Nome
FROM Aula A
JOIN Professor P ON A.NumFunc = P.NumFunc
JOIN Disciplina D ON A.NumDisp = D.NumDisp
WHERE D.Nome = 'Banco de Dados';

SELECT MAX(Nota) AS MaiorNota, MIN(Nota) AS MenorNota
FROM Aula A
JOIN Disciplina D ON A.NumDisp = D.NumDisp
WHERE D.Nome = 'Calculo Numerico' AND A.Semestre = '01/1998';

SELECT Al.Nome, A.Nota
FROM Aula A
JOIN Aluno Al ON A.NumAluno = Al.NumAluno
JOIN Disciplina D ON A.NumDisp = D.NumDisp
WHERE D.Nome = 'Engenharia Software' AND A.Semestre = '01/1998'
ORDER BY A.Nota DESC
LIMIT 1;

SELECT Al.Nome AS Aluno, D.Nome AS Disciplina, P.Nome AS Professor
FROM Aula A
JOIN Aluno Al ON A.NumAluno = Al.NumAluno
JOIN Disciplina D ON A.NumDisp = D.NumDisp
JOIN Professor P ON A.NumFunc = P.NumFunc
WHERE A.Semestre = '01/1998'
ORDER BY Al.Nome;

SELECT Al.Nome AS Aluno, D.Nome AS Disciplina, A.Nota
FROM Aula A
JOIN Aluno Al ON A.NumAluno = Al.NumAluno
JOIN Disciplina D ON A.NumDisp = D.NumDisp
JOIN DisciplinaCurso DC ON D.NumDisp = DC.NumDisp
JOIN Curso C ON DC.NumCurso = C.NumCurso
WHERE A.Semestre = '01/1998' AND C.Nome = 'Ciência da Computação';

SELECT AVG(A.Nota) AS MediaNota
FROM Aula A
JOIN Professor P ON A.NumFunc = P.NumFunc
WHERE P.Nome = 'Marcos Salvador';

SELECT Al.Nome AS Aluno, D.Nome AS Disciplina, A.Nota
FROM Aula A
JOIN Aluno Al ON A.NumAluno = Al.NumAluno
JOIN Disciplina D ON A.NumDisp = D.NumDisp
WHERE A.Nota BETWEEN 5.0 AND 7.0
ORDER BY D.Nome;

SELECT AVG(A.Nota) AS MediaNota
FROM Aula A
JOIN Disciplina D ON A.NumDisp = D.NumDisp
WHERE D.Nome = 'Calculo Numerico' AND A.Semestre = '01/1998';

SELECT COUNT(DISTINCT A.NumAluno) AS TotalAlunos
FROM Aula A
JOIN Professor P ON A.NumFunc = P.NumFunc
WHERE P.Nome = 'Abgair Simon Ferreira' AND A.Semestre = '01/1998';

SELECT AVG(A.Nota) AS MediaNota
FROM Aula A
JOIN Aluno Al ON A.NumAluno = Al.NumAluno
WHERE Al.Nome = 'Edvaldo Carlos Silva';

SELECT D.Nome AS Disciplina, AVG(A.Nota) AS MediaNota
FROM Aula A
JOIN Disciplina D ON A.NumDisp = D.NumDisp
WHERE A.Semestre = '01/1998'
GROUP BY D.Nome
ORDER BY D.Nome;

SELECT P.Nome AS Professor, AVG(A.Nota) AS MediaNota
FROM Aula A
JOIN Professor P ON A.NumFunc = P.NumFunc
WHERE A.Semestre = '01/1998'
GROUP BY P.Nome;

SELECT D.Nome AS Disciplina, AVG(A.Nota) AS MediaNota
FROM Aula A
JOIN Disciplina D ON A.NumDisp = D.NumDisp
JOIN DisciplinaCurso DC ON D.NumDisp = DC.NumDisp
JOIN Curso C ON DC.NumCurso = C.NumCurso
WHERE C.Nome = 'Ciência da Computação' AND A.Semestre = '01/1998'
GROUP BY D.Nome;

SELECT SUM(D.QuantCreditos) AS CreditosConcluidos
FROM Aula A
JOIN Aluno Al ON A.NumAluno = Al.NumAluno
JOIN Disciplina D ON A.NumDisp = D.NumDisp
WHERE Al.Nome = 'Edvaldo Carlos Silva' AND A.Nota >= 5.0;

SELECT Al.Nome, SUM(D.QuantCreditos) AS TotalCreditos
FROM Aula A
JOIN Aluno Al ON A.NumAluno = Al.NumAluno
JOIN Disciplina D ON A.NumDisp = D.NumDisp
WHERE A.Nota >= 5.0
GROUP BY Al.Nome
HAVING SUM(D.QuantCreditos) >= 70;

SELECT Al.Nome AS Aluno, D.Nome AS Disciplina, P.Nome AS Professor
FROM Aula A
JOIN Aluno Al ON A.NumAluno = Al.NumAluno
JOIN Disciplina D ON A.NumDisp = D.NumDisp
JOIN Professor P ON A.NumFunc = P.NumFunc
JOIN DisciplinaCurso DC ON D.NumDisp = DC.NumDisp
JOIN Curso C ON DC.NumCurso = C.NumCurso
WHERE C.Nome = 'Ciência da Computação' AND A.Semestre = '01/1998' AND A.Nota > 8.0;

UPDATE Disciplina
SET Nome = 'Banco de Dados Aplicado'
WHERE Nome = 'Banco de Dados';

UPDATE Disciplina
SET QuantCreditos = 10;

DELETE FROM Aula;

ALTER TABLE Aula
ADD Observacao NVARCHAR(255);


