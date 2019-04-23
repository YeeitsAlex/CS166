DROP TABLE IF EXISTS Professor cascade;
DROP TABLE IF EXISTS Project cascade;
DROP TABLE IF EXISTS Works_In;
DROP TABLE IF EXISTS Dept cascade;
DROP TABLE IF EXISTS Work_Dept;
DROP TABLE IF EXISTS Graduate cascade;
DROP TABLE IF EXISTS Work_Proj;

CREATE TABLE Professor	(ssn CHAR(11) NOT NULL,
			name CHAR(30) NOT NULL,
			age Integer NOT NULL,
			p_rank Integer NOT NULL,
			specialty CHAR(100) NOT NULL,
			PRIMARY KEY(ssn));

CREATE TABLE Project	(pno Integer NOT NULL,
			ssn CHAR(30) NOT NULL,
 		 	sponsor CHAR(30) NOT NULL,
			start_date DATE NOT NULL,
			end_date DATE NOT NULL,
			budget REAL NOT NULL,
			PRIMARY KEY(pno),
			FOREIGN KEY(ssn) REFERENCES Professor(ssn));

CREATE TABLE Works_In	(ssn CHAR(11) NOT NULL,
			pno Integer,
			PRIMARY KEY(ssn,pno),
			FOREIGN KEY(ssn) REFERENCES Professor(ssn) ,
			FOREIGN KEY(pno) REFERENCES Project(pno)  );

CREATE TABLE Dept	(dno Integer NOT NULL,
			ssn CHAR(30) NOT NULL,
			dname CHAR(30) NOT NULL,
			office CHAR(30) NOT NULL,
			PRIMARY KEY(dno),
			FOREIGN KEY(ssn) REFERENCES Professor(ssn) );

CREATE TABLE Work_Dept	(ssn CHAR(11) NOT NULL,
			dno Integer,
			PRIMARY KEY(ssn, dno),
			FOREIGN KEY(ssn) REFERENCES Professor(ssn) ,
			FOREIGN KEY(dno) REFERENCES Dept(dno)  );

CREATE TABLE Graduate	(ssn CHAR(11) NOT NULL,
			advisor text NOT NULL,
			name CHAR(30) NOT NULL,
			age Integer NOT NULL,
			deg_pg CHAR(30) NOT NULL,
			dno Integer,
			PRIMARY KEY(ssn),
			FOREIGN KEY(dno) REFERENCES Dept(dno)  );

CREATE TABLE Work_Proj	(pno Integer NOT NULL,
			grad_ssn CHAR(11) NOT NULL,
			prof_ssn CHAR(11) NOT NULL,
			since DATE NOT NULL,
			PRIMARY KEY(pno,grad_ssn, prof_ssn),
			FOREIGN KEY(pno) REFERENCES Project(pno) ,
			FOREIGN KEY(grad_ssn) REFERENCES Graduate(ssn) ,
			FOREIGN KEY(prof_ssn) REFERENCES Professor(ssn)  );
