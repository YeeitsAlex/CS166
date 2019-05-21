DROP TABLE IF EXISTS Customer cascade;
DROP TABLE IF EXISTS Plane cascade;
DROP TABLE IF EXISTS Technician cascade;
DROP TABLE IF EXISTS Repairs cascade;
DROP TABLE IF EXISTS Pilot cascade;
DROP TABLE IF EXISTS Flight cascade;
DROP TABLE IF EXISTS Schedule cascade;
DROP TABLE IF EXISTS Reservation cascade;
DROP TABLE IF EXISTS Waitlisted cascade;
DROP TABLE IF EXISTS Confirmed cascade;
DROP TABLE IF EXISTS Reserved cascade;
DROP TABLE IF EXISTS Has cascade;

--ASSUMPTION THAT ID is different in each entity
CREATE TABLE Plane (plane_ID text,
                    make date,
                    model text,
                    age Integer,
                    num_seats Integer,
                    PRIMARY KEY(plane_ID));

CREATE TABLE Technician (tech_ID text,
                        PRIMARY KEY(tech_ID));

--Uses and repair request both use plane_ID
CREATE TABLE Pilot (pilot_ID text,
                    name text,
                    nationality text,
                    repair_requestID text,
                    PRIMARY KEY(pilot_ID));

CREATE TABLE Repairs (repair_date date,
                      repair_code text,
                      tech_ID text,
                      pilot_ID text,
                      plane_ID text,
                      repair_requestID text,
                      PRIMARY KEY(plane_ID, tech_ID, pilot_ID, repair_requestID),
                      FOREIGN KEY (plane_ID) REFERENCES Plane(plane_ID),
                      FOREIGN KEY (repair_requestID) REFERENCES Pilot(repair_requestID),
                      FOREIGN KEY (pilot_ID) REFERENCES Pilot(pilot_ID),
                      FOREIGN KEY (tech_ID) REFERENCES Technician(tech_ID));


--ASSUMING that flight_num is the primary key for flight entity
--REF plane_ID for uses relation, every Flight must use 1 plane
--Plane can be used by one or more flights

CREATE TABLE Flight (flight_num Integer NOT NULL,
                    plane_ID text,
                    cost text,
                    num_sold Integer,
                    num_stops Integer,
                    actual_arrive_date date,
                    actual_arrival_time time,
                    actual_depart_date date,
                    source text,
                    destination text,
                    PRIMARY KEY(flight_num, source, destination),
                    FOREIGN KEY(plane_ID) REFERENCES Plane(plane_ID));

--Assuming that day = a date and not something like "Monday"
CREATE TABLE Schedule (flight_num text,
                      depart_time time,
                      arrive_time time,
                      source text,
                      destination text,
                      day date,
                      PRIMARY KEY(flight_num, source, destination),
                      FOREIGN KEY(flight_num) REFERENCES Flight(flight_num)
                      FOREIGN KEY(source) REFERENCES Flight(source),
                      FOREIGN KEY(destination) REFERENCES Flight(destination));


CREATE TABLE Customer (first_name text,
                      last_name text,
                      flight_num Integer,
                      gender text,
                      date_of_birth date,
                      address text,
                      contact_num text,
                      cust_ID text NOT NULL,
                      ZIP_code Integer,
                      PRIMARY KEY(cust_ID),
                      FOREIGN KEY(flight_num) REFERENCES Flight(flight_num));

CREATE TABLE Reservation (Rnum text,
                         PRIMARY KEY(Rnum));

CREATE TABLE Waitlisted (Rnum text,
                        PRIMARY KEY(Rnum)
                        FOREIGN KEY(Rnum) REFERENCES Reservation(Rnum));

CREATE TABLE Confirmed (Rnum text,
                        PRIMARY KEY(Rnum),
                        FOREIGN KEY(Rnum) REFERENCES Reservation(Rnum));

CREATE TABLE Reserved (Rnum text,
                      PRIMARY KEY(Rnum)
                      FOREIGN KEY(Rnum) REFERENCES Reservation(Rnum));

CREATE TABLE Has (flight_num Integer,
                  cust_ID text,
                  source text,
                  destination text,
                  Rnum text,
                  PRIMARY KEY(flight_num,cust_ID,source,destination),
                  FOREIGN KEY(cust_ID) REFERENCES Customer(cust_ID),
                  FOREIGN KEY(source) REFERENCES Flight(source),
                  FOREIGN KEY(flight_num) REFERENCES Flight(flight_num)
                  FOREIGN KEY(source) REFERENCES Flight(source),
                  FOREIGN KEY(destination) REFERENCES Flight(destination));
