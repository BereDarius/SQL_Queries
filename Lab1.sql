USE Zoo

CREATE TABLE Vet(
	vid INT PRIMARY KEY IDENTITY,
	name VARCHAR(100),
	dob DATE,
	salary DECIMAL(10,2))

CREATE TABLE Caretaker(
	caid INT PRIMARY KEY IDENTITY,
	name VARCHAR(100),
	dob DATE,
	salary DECIMAL(10,2))

CREATE TABLE Habitat(
	hid INT PRIMARY KEY IDENTITY,
	size INT,
	animal_type VARCHAR(50))

CREATE TABLE Animal(
	aid INT PRIMARY KEY IDENTITY,
	name VARCHAR(50),
	type VARCHAR(50),
	dob DATE,
	hid INT FOREIGN KEY REFERENCES Habitat(hid),
	caid INT FOREIGN KEY REFERENCES Caretaker(caid),
	vid INT FOREIGN KEY REFERENCES Vet(vid))

CREATE TABLE Cleaner(
	clid INT PRIMARY KEY IDENTITY,
	name VARCHAR(100),
	dob DATE,
	salary DECIMAL(10,2))

CREATE TABLE Cleans(
	clid INT FOREIGN KEY REFERENCES Cleaner(clid),
	hid INT FOREIGN KEY REFERENCES Habitat(hid)
	CONSTRAINT pk_Cleans PRIMARY KEY(clid,hid))

CREATE TABLE Schedule(
	scid INT FOREIGN KEY REFERENCES Cleaner(clid),
	hours_per_week INT,
	hours_per_day INT,
	daily_start DATETIME,
	CONSTRAINT pk_Cleaner PRIMARY KEY(scid))


CREATE DATABASE Zoo

ALTER TABLE Schedule
	ALTER COLUMN daily_start TIME(0)
	ADD daily_end TIME(0);

DROP TABLE Cleans