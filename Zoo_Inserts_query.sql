USE Zoo

/*
				INSERTS
*/


INSERT INTO Cleaner(name, dob, salary) VALUES
	('Clay Ferguson', '1990-10-20', 1500),
	('Anna Roper', '1991-09-13', 1600),
	('Darius Bere', '1997-09-08', 1300),
	('Andrew Nickell', '2000-05-23', 1500),
	('Walter Franson', '1985-01-12', 2000),
	('Peter Martinez', '1995-04-14', 1400),
	('Edwin Johnson', '1994-11-04', 1450),
	('Phyllis Renteria', '1996-07-17', 1500),
	('Hershel Johnes', '1994-04-04', 1500),
	('Yolanda Ramirez', '2000-12-01', 1500);


INSERT INTO Habitat(size, animal_type) VALUES
	(10, 'Lion'),
	(7, 'Gorilla'),
	(20, 'Chimpanzee'),
	(5, 'Elephant'),
	(13, 'Kangaroo');


INSERT INTO Vet(name, dob, salary) VALUES
	('Craig Human', '1985-05-21', 2500),
	('Kyle Yoon', '1983-02-14', 2600),
	('Stan Perkins', '1988-09-12', 2450),
	('Kenny Jones', '1990-10-13', 2550),
	('Alex Clark', '1991-04-15', 2650),
	('Thomas Stapleton', '1990-10-13', 2600),
	('Ronald Gillham', '1980-02-10', 2500),
	('Matt Knox', '1989-03-19', 2550),
	('Velma Cammack', '1987-08-16', 2650),
	('Jeffrey Yon', '1992-05-12', 2400);


INSERT INTO Caretaker(name, dob, salary) VALUES
	('Ed Foster', '1999-06-15', 1700),
	('Andrew Iversen', '1997-12-12', 1750),
	('Donald Cisco', '1990-01-01', 1700),
	('Mike Bolick', '1992-04-17', 1800),
	('Ted Towns', '1995-05-15', 1750),
	('Martha Travis', '2000-03-05', 1700),
	('David Voigt', '1999-01-21', 1750),
	('Carlton Sullivan', '1995-11-16', 1800),
	('Caroline Burrows', '1997-12-13', 1850),
	('Jesse Lass', '1998-07-14', 1750);


INSERT INTO Schedule(scid, hours_per_week, hours_per_day, daily_start, daily_end) VALUES
	(2, 40, 8, '08:00:00', '16:00:00'),
	(1, 30, 6, '12:00:00', '16:00:00'),
	(3, 20, 4, '10:00:00', '14:00:00'),
	(5, 50, 10, '09:00:00', '19:00:00'),
	(4, 40, 8, '13:00:00', '21:00:00'),
	(7, 20, 4, '13:00:00', '17:00:00'),
	(9, 30, 6, '15:00:00', '21:00:00'),
	(6, 20, 4, '12:00:00', '16:00:00'),
	(8, 30, 6, '08:00:00', '15:00:00'),
	(10, 30, 6, '14:00:00', '20:00:00');


INSERT INTO Animal(name, type, dob, hid, caid, vid) VALUES
	('Leo', 'Lion', '2010-06-15', 1, 4, 5),
	('King Kong', 'Gorilla', '1995-05-13', 2, 5, 2),
	('Pouch Adams', 'Kangaroo', '2011-03-01', 5, 1, 1),
	('Dumbo', 'Elephant', '1990-07-18', 4, 2, 4),
	('Cheeta', 'Chimpanzee', '2001-09-10', 3, 3, 3),
	('Simba', 'Lion', '2010-07-13', 1, 9, 9),
	('Terk', 'Gorilla', '1997-09-08', 2, 8, 6),
	('BooBoo', 'Chimpanzee', '2003-07-12', 3, 7, 7),
	('Bongy', 'Gorilla', '1999-03-01', 2, 10, 8),
	('Goober', 'Kangaroo', '2013-05-13', 5, 6, 10);


INSERT INTO Cleans(clid, hid) VALUES
	(1, 3),
	(2, 2),
	(3, 5),
	(4, 1),
	(5, 4),
	(6, 1),
	(7, 4),
	(8, 2),
	(9, 4),
	(10, 3);


/*
				UPDATES
*/

UPDATE Cleaner
SET salary = salary + 100
WHERE ((dob BETWEEN '1985-01-01' AND '1995-12-31') AND (salary < 1600));


UPDATE Schedule
SET daily_start = DATEADD(hour, 1, daily_start), daily_end = DATEADD(hour, 1, daily_end)
WHERE (daily_start LIKE '08%');


UPDATE Animal
SET dob = DATEADD(year, 1, dob)
WHERE (type IN ('Lion', 'Gorilla'));


/*
				DELETES
*/


DELETE Animal
WHERE ((type = 'Gorilla') AND (dob BETWEEN '1990-01-01' AND '1997-12-31'));


/*
				SELECTS
*/


/*DISTINCT*/

SELECT MIN(name) AS name, c2.salary FROM Caretaker c1 RIGHT JOIN
(SELECT DISTINCT salary FROM Caretaker) AS c2
ON c1.salary = c2.salary
GROUP BY c2.salary


/*UNION*/

SELECT clid, name, salary FROM Cleaner
UNION
SELECT caid, name, salary FROM Caretaker;


/*INTERSECT*/

SELECT hid
	FROM Cleaner
	LEFT JOIN Cleans
	ON Cleans.clid = Cleaner.clid
	WHERE hid < 3
INTERSECT
	SELECT hid FROM Habitat


/*EXCEPT*/

SELECT * FROM Animal
EXCEPT
SELECT * FROM Animal
WHERE (type = 'gorilla')


/*LEFT AND RIGHT JOIN*/

SELECT Cleans.clid, name, dob, salary, animal_type, size FROM 
(Cleans LEFT JOIN Cleaner
ON Cleaner.clid = Cleans.clid) RIGHT JOIN Habitat
ON Cleans.hid = Habitat.hid
ORDER BY salary;


/*INNER JOIN*/

SELECT Habitat.hid, name, type, dob, size FROM 
Animal INNER JOIN Habitat
ON Animal.type = Habitat.animal_type
ORDER BY type


/*FULL JOIN*/

SELECT * FROM
Schedule FULL JOIN Cleaner
ON scid = clid;


/*IN*/

SELECT * FROM Animal
WHERE (type IN('bird', 'lion', 'kangaroo', 'fish'));


/*EXISTS*/

SELECT name, salary FROM Caretaker
WHERE EXISTS
(SELECT salary from Caretaker
WHERE salary >= 1750);


/*SUBQUERY IN FROM*/

SELECT name, Carer.salary FROM
	(SELECT name, dob, salary FROM Caretaker
	WHERE salary BETWEEN 1700 AND 1800) AS Carer
WHERE Carer.dob BETWEEN '1995-01-01' AND '2000-01-01';


/*GROUP BY*/

SELECT name, salary FROM Vet
	GROUP BY salary, name
	HAVING salary < (SELECT AVG(salary) FROM Vet);


SELECT name, dob, type FROM Animal
	GROUP BY type, name, dob, caid
	HAVING caid = (SELECT caid FROM Caretaker
	WHERE salary = (SELECT MAX(salary) FROM Caretaker));


SELECT MAX(dob) AS max_dob, name, salary FROM Vet
	GROUP BY name, salary
	HAVING salary = (SELECT MIN(salary) FROM Vet);