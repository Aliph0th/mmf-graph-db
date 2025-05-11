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
CREATE TABLE Investigating AS EDGE;

ALTER TABLE LeavesEvidence ADD CONSTRAINT EC_LeavesEvidence CONNECTION (Criminals TO Evidence);
ALTER TABLE ConfessesToCrime ADD CONSTRAINT EC_ConfessesToCrime CONNECTION (Criminals TO Crimes);
ALTER TABLE CommitsCrime ADD CONSTRAINT EC_CommitsCrime CONNECTION (Criminals TO Crimes);
ALTER TABLE Investigating ADD CONSTRAINT EC_Investigating CONNECTION (Detectives TO Crimes);



INSERT INTO Criminals (Name) VALUES
	(N'������ ������'),
	(N'��������'),
	(N'��� ������'),
	(N'������ �������'),
	(N'����� �������'),
	(N'����������'),
	(N'������� �������'),
	(N'����� ��������'),
	(N'����� ������'),
	(N'����� ����������');

INSERT INTO Detectives (Name) VALUES
	(N'������ �����'),
	(N'������ �����'),
	(N'������'),
	(N'��������� �������'),
	(N'������������������ �������'),
	(N'������� ��������'),
	(N'����������� ������'),
	(N'��������� ��������'),
	(N'���� �����'),
	(N'������� �������');

INSERT INTO Crimes (Title) VALUES
	(N'������� ��������� �����'),
	(N'��������� ������ ���������� ��������'),
	(N'��������� �����'),
	(N'�������� ��������� �������'),
	(N'�������� ���������� ��������'),
	(N'������� ��������� ����� ������ ���'),
	(N'��������'),
	(N'����� ����� � ������'),
	(N'�������������'),
	(N'���������� ���������'),
	(N'������������� � �������������');

INSERT INTO Evidence (Title) VALUES
	(N'��������� ������'),
	(N'���� � ���������'),
	(N'���������'),
	(N'��������� �����������'),
	(N'������� ���'),
	(N'����� ���������'),
	(N'�������������� � ����'),
	(N'������ � �������� �� ������ �������');


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

INSERT INTO Investigating ($from_id, $to_id)
VALUES
	((SELECT $node_id FROM Detectives WHERE id = 1), (SELECT $node_id FROM Crimes WHERE id = 1)),
	((SELECT $node_id FROM Detectives WHERE id = 1), (SELECT $node_id FROM Crimes WHERE id = 4)),
	((SELECT $node_id FROM Detectives WHERE id = 1), (SELECT $node_id FROM Crimes WHERE id = 6)),
	((SELECT $node_id FROM Detectives WHERE id = 1), (SELECT $node_id FROM Crimes WHERE id = 7)),
	((SELECT $node_id FROM Detectives WHERE id = 1), (SELECT $node_id FROM Crimes WHERE id = 8)),
	((SELECT $node_id FROM Detectives WHERE id = 2), (SELECT $node_id FROM Crimes WHERE id = 1)),
	((SELECT $node_id FROM Detectives WHERE id = 2), (SELECT $node_id FROM Crimes WHERE id = 4)),
	((SELECT $node_id FROM Detectives WHERE id = 7), (SELECT $node_id FROM Crimes WHERE id = 8)),
	((SELECT $node_id FROM Detectives WHERE id = 7), (SELECT $node_id FROM Crimes WHERE id = 2)),
	((SELECT $node_id FROM Detectives WHERE id = 3), (SELECT $node_id FROM Crimes WHERE id = 9)),
	((SELECT $node_id FROM Detectives WHERE id = 6), (SELECT $node_id FROM Crimes WHERE id = 9)),
	((SELECT $node_id FROM Detectives WHERE id = 6), (SELECT $node_id FROM Crimes WHERE id = 5)),
	((SELECT $node_id FROM Detectives WHERE id = 9), (SELECT $node_id FROM Crimes WHERE id = 2)),
	((SELECT $node_id FROM Detectives WHERE id = 9), (SELECT $node_id FROM Crimes WHERE id = 3)),
	((SELECT $node_id FROM Detectives WHERE id = 9), (SELECT $node_id FROM Crimes WHERE id = 10)),
	((SELECT $node_id FROM Detectives WHERE id = 4), (SELECT $node_id FROM Crimes WHERE id = 3)),
	((SELECT $node_id FROM Detectives WHERE id = 5), (SELECT $node_id FROM Crimes WHERE id = 11)),
	((SELECT $node_id FROM Detectives WHERE id = 10), (SELECT $node_id FROM Crimes WHERE id = 11)),
	((SELECT $node_id FROM Detectives WHERE id = 10), (SELECT $node_id FROM Crimes WHERE id = 5)),
	((SELECT $node_id FROM Detectives WHERE id = 8), (SELECT $node_id FROM Crimes WHERE id = 5));





-- ������������, ����������� ������������ ������������
SELECT Name, Title
FROM Criminals AS person
   , CommitsCrime
   , Crimes AS crime
WHERE MATCH(person-(CommitsCrime)->crime)
      AND Name = N'������ ������'

-- ��������� � ���������� ������������ ������������
SELECT detective.Name AS DetectiveName, COUNT(DISTINCT crime.id) AS CrimeCount
FROM Detectives AS detective
    , Investigating
    , Crimes AS crime
WHERE MATCH(detective-(Investigating)->crime)
GROUP BY detective.Name;

-- �����������, ����������� � �������������, � ���������� ����������, ������� ������������ ������������
SELECT crime.Title AS CrimeTitle, person.Name AS CriminalName, COUNT(detective.id) AS DetectiveCount
FROM Crimes AS crime
    , ConfessesToCrime
    , Criminals AS person
    , Investigating
    , Detectives AS detective
WHERE MATCH(person-(ConfessesToCrime)->crime<-(Investigating)-detective)
GROUP BY crime.Title, person.Name;

-- �����������, ������� ��������� � ������������, � ����������, ������� ������������ ��� ������������
SELECT person.Name AS CriminalName, detective.Name AS DetectiveName, crime.Title AS CrimeTitle
FROM Criminals AS person
    , ConfessesToCrime
    , Crimes AS crime
    , Investigating
    , Detectives AS detective
WHERE MATCH(person-(ConfessesToCrime)->crime<-(Investigating)-detective)

-- �����������, ����������� � �������������, � ���������� ������������ ����
SELECT person.Name AS CriminalName, crime.Title AS CrimeTitle, COUNT(evidence.id) AS EvidenceCount
FROM Criminals AS person
    , ConfessesToCrime
    , Crimes AS crime
    , LeavesEvidence
    , Evidence AS evidence
WHERE MATCH(evidence<-(LeavesEvidence)-person-(ConfessesToCrime)->crime)
GROUP BY person.Name, crime.Title;


--  ������� �������� ����������, ������� ������������ �� �� ������������
SELECT detective1.Name AS DetectiveName,
       STRING_AGG(detective2.Name, '->') WITHIN GROUP (GRAPH PATH) AS Detectives
FROM Detectives AS detective1,
     Investigating FOR PATH AS inv1,
     Crimes FOR PATH AS Crime,
     Investigating FOR PATH AS inv2,
	 Detectives FOR PATH AS detective2
WHERE MATCH(SHORTEST_PATH(detective1(-(inv1)->Crime<-(inv2)-detective2)+))
      AND detective1.Name = N'������ �����';


-- ������� ������������, ��������� ����� �����, ������� ��� �������� �� ����� ������������ �� ����� 3 �������
SELECT criminal1.Name AS CriminalName,
       STRING_AGG(criminal2.Name, ' -> ') WITHIN GROUP (GRAPH PATH) AS Criminals
FROM Criminals AS criminal1,
     Criminals FOR PATH AS criminal2,
     LeavesEvidence FOR PATH AS le1,
     Evidence FOR PATH AS ev,
     LeavesEvidence FOR PATH AS le2
WHERE MATCH(SHORTEST_PATH(criminal1(-(le1)->ev<-(le2)-criminal2){1,3}))
  AND criminal1.Name = N'��������';