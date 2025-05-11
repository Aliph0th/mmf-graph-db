USE [master];
GO
IF EXISTS (SELECT 1 FROM sys.sysdatabases WHERE [name] = 'CrimesGraph')
    BEGIN
        ALTER DATABASE [CrimesGraph] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
        DROP DATABASE [CrimesGraph];
    END

CREATE DATABASE [CrimesGraph];
GO
USE [CrimesGraph];
GO



CREATE TABLE Criminals (
    id INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(100) NOT NULL
) AS NODE;

CREATE TABLE Detectives (
    id INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(100) NOT NULL
) AS NODE;

CREATE TABLE Crimes (
    id INT PRIMARY KEY IDENTITY,
    Title NVARCHAR(100) NOT NULL
) AS NODE;

CREATE TABLE Evidence (
    id INT PRIMARY KEY IDENTITY,
    Title NVARCHAR(255) NOT NULL
) AS NODE;



CREATE TABLE LeavesEvidence AS EDGE;
CREATE TABLE ConfessesToCrime AS EDGE;
CREATE TABLE CommitsCrime AS EDGE;
CREATE TABLE Investigating (
	complexity INT NOT NULL
) AS EDGE;

ALTER TABLE LeavesEvidence ADD CONSTRAINT EC_LeavesEvidence CONNECTION (Criminals TO Evidence);
ALTER TABLE ConfessesToCrime ADD CONSTRAINT EC_ConfessesToCrime CONNECTION (Criminals TO Crimes);
ALTER TABLE CommitsCrime ADD CONSTRAINT EC_CommitsCrime CONNECTION (Criminals TO Crimes);
ALTER TABLE Investigating ADD CONSTRAINT EC_Investigating CONNECTION (Detectives TO Crimes);



INSERT INTO Criminals (Name) VALUES
	(N'Виктор Люстиг'),
	(N'Мориарти'),
	(N'Аль Капоне'),
	(N'Сергей Мавроди'),
	(N'Пабло Эскобар'),
	(N'Вольдеморт'),
	(N'Джордан Белфорт'),
	(N'Фрэнк Абигнейл'),
	(N'Кевин Митник'),
	(N'Елена Блиновская');

INSERT INTO Detectives (Name) VALUES
	(N'Шерлок Холмс'),
	(N'Экрюль Пуаро'),
	(N'Мухтар'),
	(N'Инспектор Сидоров'),
	(N'Оперуполномоченный Евгений'),
	(N'Капитан Воробьев'),
	(N'Следователь Петров'),
	(N'Инспектор Лестрейд'),
	(N'Хлоя Декер'),
	(N'Джейсон Стейтем');

INSERT INTO Crimes (Title) VALUES
	(N'Продажа Эйфелевой башни'),
	(N'Похищение данных телефонной компании'),
	(N'Отмывание денег'),
	(N'Убийство родителей Поттера'),
	(N'Создание финансовой пирамиды'),
	(N'Продажа Эйфелевой башни второй раз'),
	(N'Убийство'),
	(N'Кража денег у банков'),
	(N'Наркоторговля'),
	(N'Финансовые махинации'),
	(N'Мошенничество и инфоциганство');

INSERT INTO Evidence (Title) VALUES
	(N'Отпечаток пальца'),
	(N'Чеки и документы'),
	(N'Свидетели'),
	(N'Показания потерпевших'),
	(N'Образец ДНК'),
	(N'Следы выстрелов'),
	(N'Неосторожность в сети'),
	(N'Жалобы в комиссию по ценным бумагам');


INSERT INTO LeavesEvidence ($from_id, $to_id)
VALUES
	((SELECT $node_id FROM Criminals WHERE id = 1), (SELECT $node_id FROM Evidence WHERE id = 1)),
	((SELECT $node_id FROM Criminals WHERE id = 1), (SELECT $node_id FROM Evidence WHERE id = 3)),
	((SELECT $node_id FROM Criminals WHERE id = 2), (SELECT $node_id FROM Evidence WHERE id = 1)),
	((SELECT $node_id FROM Criminals WHERE id = 2), (SELECT $node_id FROM Evidence WHERE id = 5)),
	((SELECT $node_id FROM Criminals WHERE id = 2), (SELECT $node_id FROM Evidence WHERE id = 4)),
	((SELECT $node_id FROM Criminals WHERE id = 4), (SELECT $node_id FROM Evidence WHERE id = 4)),
	((SELECT $node_id FROM Criminals WHERE id = 3), (SELECT $node_id FROM Evidence WHERE id = 3)),
	((SELECT $node_id FROM Criminals WHERE id = 3), (SELECT $node_id FROM Evidence WHERE id = 6)),
	((SELECT $node_id FROM Criminals WHERE id = 5), (SELECT $node_id FROM Evidence WHERE id = 3)),
	((SELECT $node_id FROM Criminals WHERE id = 5), (SELECT $node_id FROM Evidence WHERE id = 5)),
	((SELECT $node_id FROM Criminals WHERE id = 7), (SELECT $node_id FROM Evidence WHERE id = 2)),
	((SELECT $node_id FROM Criminals WHERE id = 8), (SELECT $node_id FROM Evidence WHERE id = 2)),
	((SELECT $node_id FROM Criminals WHERE id = 8), (SELECT $node_id FROM Evidence WHERE id = 8)),
	((SELECT $node_id FROM Criminals WHERE id = 10), (SELECT $node_id FROM Evidence WHERE id = 4)),
	((SELECT $node_id FROM Criminals WHERE id = 10), (SELECT $node_id FROM Evidence WHERE id = 7)),
	((SELECT $node_id FROM Criminals WHERE id = 9), (SELECT $node_id FROM Evidence WHERE id = 5)),
	((SELECT $node_id FROM Criminals WHERE id = 9), (SELECT $node_id FROM Evidence WHERE id = 7)),
	((SELECT $node_id FROM Criminals WHERE id = 6), (SELECT $node_id FROM Evidence WHERE id = 3));

INSERT INTO CommitsCrime ($from_id, $to_id)
VALUES
	((SELECT $node_id FROM Criminals WHERE id = 1), (SELECT $node_id FROM Crimes WHERE id = 1)),
	((SELECT $node_id FROM Criminals WHERE id = 1), (SELECT $node_id FROM Crimes WHERE id = 6)),
	((SELECT $node_id FROM Criminals WHERE id = 8), (SELECT $node_id FROM Crimes WHERE id = 8)),
	((SELECT $node_id FROM Criminals WHERE id = 8), (SELECT $node_id FROM Crimes WHERE id = 3)),
	((SELECT $node_id FROM Criminals WHERE id = 5), (SELECT $node_id FROM Crimes WHERE id = 9)),
	((SELECT $node_id FROM Criminals WHERE id = 5), (SELECT $node_id FROM Crimes WHERE id = 3)),
	((SELECT $node_id FROM Criminals WHERE id = 5), (SELECT $node_id FROM Crimes WHERE id = 7)),
	((SELECT $node_id FROM Criminals WHERE id = 3), (SELECT $node_id FROM Crimes WHERE id = 3)),
	((SELECT $node_id FROM Criminals WHERE id = 3), (SELECT $node_id FROM Crimes WHERE id = 7)),
	((SELECT $node_id FROM Criminals WHERE id = 2), (SELECT $node_id FROM Crimes WHERE id = 7)),
	((SELECT $node_id FROM Criminals WHERE id = 2), (SELECT $node_id FROM Crimes WHERE id = 10)),
	((SELECT $node_id FROM Criminals WHERE id = 4), (SELECT $node_id FROM Crimes WHERE id = 5)),
	((SELECT $node_id FROM Criminals WHERE id = 9), (SELECT $node_id FROM Crimes WHERE id = 2)),
	((SELECT $node_id FROM Criminals WHERE id = 7), (SELECT $node_id FROM Crimes WHERE id = 10)),
	((SELECT $node_id FROM Criminals WHERE id = 10), (SELECT $node_id FROM Crimes WHERE id = 11)),
	((SELECT $node_id FROM Criminals WHERE id = 10), (SELECT $node_id FROM Crimes WHERE id = 10)),
	((SELECT $node_id FROM Criminals WHERE id = 10), (SELECT $node_id FROM Crimes WHERE id = 5)),
	((SELECT $node_id FROM Criminals WHERE id = 6), (SELECT $node_id FROM Crimes WHERE id = 7)),
	((SELECT $node_id FROM Criminals WHERE id = 6), (SELECT $node_id FROM Crimes WHERE id = 4));

INSERT INTO ConfessesToCrime ($from_id, $to_id)
VALUES
	((SELECT $node_id FROM Criminals WHERE id = 1), (SELECT $node_id FROM Crimes WHERE id = 1)),
	((SELECT $node_id FROM Criminals WHERE id = 8), (SELECT $node_id FROM Crimes WHERE id = 8)),
	((SELECT $node_id FROM Criminals WHERE id = 3), (SELECT $node_id FROM Crimes WHERE id = 3)),
	((SELECT $node_id FROM Criminals WHERE id = 5), (SELECT $node_id FROM Crimes WHERE id = 3)),
	((SELECT $node_id FROM Criminals WHERE id = 2), (SELECT $node_id FROM Crimes WHERE id = 7)),
	((SELECT $node_id FROM Criminals WHERE id = 9), (SELECT $node_id FROM Crimes WHERE id = 2)),
	((SELECT $node_id FROM Criminals WHERE id = 6), (SELECT $node_id FROM Crimes WHERE id = 4)),
	((SELECT $node_id FROM Criminals WHERE id = 7), (SELECT $node_id FROM Crimes WHERE id = 10));

INSERT INTO Investigating ($from_id, $to_id, complexity)
VALUES
	((SELECT $node_id FROM Detectives WHERE id = 1), (SELECT $node_id FROM Crimes WHERE id = 1), 10),
	((SELECT $node_id FROM Detectives WHERE id = 1), (SELECT $node_id FROM Crimes WHERE id = 4), 6),
	((SELECT $node_id FROM Detectives WHERE id = 1), (SELECT $node_id FROM Crimes WHERE id = 6), 11),
	((SELECT $node_id FROM Detectives WHERE id = 1), (SELECT $node_id FROM Crimes WHERE id = 7), 4),
	((SELECT $node_id FROM Detectives WHERE id = 1), (SELECT $node_id FROM Crimes WHERE id = 8), 7),
	((SELECT $node_id FROM Detectives WHERE id = 2), (SELECT $node_id FROM Crimes WHERE id = 1), 7),
	((SELECT $node_id FROM Detectives WHERE id = 2), (SELECT $node_id FROM Crimes WHERE id = 4), 3),
	((SELECT $node_id FROM Detectives WHERE id = 7), (SELECT $node_id FROM Crimes WHERE id = 8), 8),
	((SELECT $node_id FROM Detectives WHERE id = 7), (SELECT $node_id FROM Crimes WHERE id = 2), 3),
	((SELECT $node_id FROM Detectives WHERE id = 3), (SELECT $node_id FROM Crimes WHERE id = 9), 4),
	((SELECT $node_id FROM Detectives WHERE id = 6), (SELECT $node_id FROM Crimes WHERE id = 9), 5),
	((SELECT $node_id FROM Detectives WHERE id = 6), (SELECT $node_id FROM Crimes WHERE id = 5), 2),
	((SELECT $node_id FROM Detectives WHERE id = 9), (SELECT $node_id FROM Crimes WHERE id = 2), 6),
	((SELECT $node_id FROM Detectives WHERE id = 9), (SELECT $node_id FROM Crimes WHERE id = 3), 4),
	((SELECT $node_id FROM Detectives WHERE id = 9), (SELECT $node_id FROM Crimes WHERE id = 10), 4),
	((SELECT $node_id FROM Detectives WHERE id = 4), (SELECT $node_id FROM Crimes WHERE id = 3), 5),
	((SELECT $node_id FROM Detectives WHERE id = 5), (SELECT $node_id FROM Crimes WHERE id = 11), 3),
	((SELECT $node_id FROM Detectives WHERE id = 10), (SELECT $node_id FROM Crimes WHERE id = 11), 1),
	((SELECT $node_id FROM Detectives WHERE id = 10), (SELECT $node_id FROM Crimes WHERE id = 5), 5),
	((SELECT $node_id FROM Detectives WHERE id = 8), (SELECT $node_id FROM Crimes WHERE id = 5), 3);





-- преступления, совершенные определенным преступником
SELECT Name, Title
FROM Criminals AS person
   , CommitsCrime
   , Crimes AS crime
WHERE MATCH(person-(CommitsCrime)->crime)
      AND Name = N'Виктор Люстиг'

-- детективы и количество расследуемых преступлений
SELECT detective.Name AS DetectiveName, COUNT(DISTINCT crime.id) AS CrimeCount
FROM Detectives AS detective
    , Investigating
    , Crimes AS crime
WHERE MATCH(detective-(Investigating)->crime)
GROUP BY detective.Name;

-- преступники, сознавшиеся в преступлениях, и количество детективов, которые расследовали преступление
SELECT crime.Title AS CrimeTitle, person.Name AS CriminalName, COUNT(detective.id) AS DetectiveCount
FROM Crimes AS crime
    , ConfessesToCrime
    , Criminals AS person
    , Investigating
    , Detectives AS detective
WHERE MATCH(person-(ConfessesToCrime)->crime<-(Investigating)-detective)
GROUP BY crime.Title, person.Name;

-- преступники, которые сознались в преступлении, и детективов, которые расследовали это преступление
SELECT person.Name AS CriminalName, detective.Name AS DetectiveName, crime.Title AS CrimeTitle
FROM Criminals AS person
    , ConfessesToCrime
    , Crimes AS crime
    , Investigating
    , Detectives AS detective
WHERE MATCH(person-(ConfessesToCrime)->crime<-(Investigating)-detective)

-- преступники, сознавшиеся в преступлениях, и количество оставленнные улик
SELECT person.Name AS CriminalName, crime.Title AS CrimeTitle, COUNT(evidence.id) AS EvidenceCount
FROM Criminals AS person
    , ConfessesToCrime
    , Crimes AS crime
    , LeavesEvidence
    , Evidence AS evidence
WHERE MATCH(evidence<-(LeavesEvidence)-person-(ConfessesToCrime)->crime)
GROUP BY person.Name, crime.Title;


--  цепочка знакомых детективов, которые расследовали те же преступления
SELECT detective1.Name AS DetectiveName,
       STRING_AGG(detective2.Name, '->') WITHIN GROUP (GRAPH PATH) AS Detectives
FROM Detectives AS detective1,
     Investigating FOR PATH AS inv1,
     Crimes FOR PATH AS Crime,
     Investigating FOR PATH AS inv2,
	 Detectives FOR PATH AS detective2
WHERE MATCH(SHORTEST_PATH(detective1(-(inv1)->Crime<-(inv2)-detective2)+))
      AND detective1.Name = N'Шерлок Холмс';


-- цепочка преступников, связанных через улики, которые они оставили на месте преступления не более 3 уровней
SELECT criminal1.Name AS CriminalName,
       STRING_AGG(criminal2.Name, ' -> ') WITHIN GROUP (GRAPH PATH) AS Criminals
FROM Criminals AS criminal1,
     Criminals FOR PATH AS criminal2,
     LeavesEvidence FOR PATH AS le1,
     Evidence FOR PATH AS ev,
     LeavesEvidence FOR PATH AS le2
WHERE MATCH(SHORTEST_PATH(criminal1(-(le1)->ev<-(le2)-criminal2){1,3}))
  AND criminal1.Name = N'Мориарти';





-- power bi
SELECT person.id AS PersonID, person.Name AS PersonName, CONCAT('Criminal', person.id) AS PersonImage,
       crime.id AS CrimeID, crime.Title AS CrimeName, CONCAT('Crime', crime.id) AS CrimeImage
FROM Criminals AS person
   , CommitsCrime
   , Crimes AS crime
WHERE MATCH(person-(CommitsCrime)->crime)

SELECT person.id AS PersonID, person.Name AS PersonName, CONCAT('Criminal', person.id) AS PersonImage,
       evidence.id AS EvidenceID, evidence.Title AS EvidenceName, CONCAT('Evidence', evidence.id) AS EvidenceImage
FROM Criminals AS person
   , LeavesEvidence
   , Evidence AS evidence
WHERE MATCH(person-(LeavesEvidence)->evidence)


SELECT person.id AS PersonID, person.Name AS PersonName, CONCAT('Criminal', person.id) AS PersonImage,
       crime.id AS CrimeID, crime.Title AS CrimeName, CONCAT('Crime', crime.id) AS CrimeImage
FROM Criminals AS person
   , ConfessesToCrime
   , Crimes AS crime
WHERE MATCH(person-(ConfessesToCrime)->crime)

SELECT detective.id AS DetectiveID, Detective.Name AS DetectiveName, CONCAT('Detective', detective.id) AS DetectiveImage,
       crime.id AS CrimeID, crime.Title AS CrimeName, CONCAT('Crime', crime.id) AS CrimeImage,
	   complexity
FROM Detectives AS detective
   , Investigating
   , Crimes AS crime
WHERE MATCH(detective-(Investigating)->crime)