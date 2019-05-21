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
CREATE TABLE Plane (plane_ID text NOT NULL,
                    make date NOT NULL,
                    model text NOT NULL,
                    age Integer NOT NULL,
                    num_seats Integer NOT NULL,
                    PRIMARY KEY(plane_ID));

CREATE TABLE Technician (tech_ID text NOT NULL,
                        PRIMARY KEY(tech_ID));

--Uses and repair request both use plane_ID
CREATE TABLE Pilot (pilot_ID text NOT NULL,
                    name text NOT NULL,
                    nationality text NOT NULL,
                    PRIMARY KEY(pilot_ID));

CREATE TABLE Repairs (repair_date date NOT NULL,
                      repair_code text NOT NULL,
                      tech_ID text NOT NULL,
                      pilot_ID text NOT NULL,
                      plane_ID text NOT NULL,
                      repair_requestID text NOT NULL,
                      PRIMARY KEY(plane_ID, tech_ID, pilot_ID, repair_requestID),
                      FOREIGN KEY (plane_ID) REFERENCES Plane(plane_ID),
                      FOREIGN KEY (pilot_ID) REFERENCES Pilot(pilot_ID),
                      FOREIGN KEY (tech_ID) REFERENCES Technician(tech_ID));


--ASSUMING that flight_num is the primary key for flight entity
--REF plane_ID for uses relation, every Flight must use 1 plane
--Plane can be used by one or more flights

CREATE TABLE Flight (flight_num Integer NOT NULL,
                    plane_ID text NOT NULL,
                    pilot_ID text NOT NULL,
                    cost text NOT NULL,
                    num_sold Integer NOT NULL,
                    num_stops Integer NOT NULL,
                    actual_arrive_date date NOT NULL,
                    actual_arrival_time time NOT NULL,
                    actual_depart_time time NOT NULL,
                    actual_depart_date date NOT NULL,
                    source text NOT NULL,
                    destination text NOT NULL,
                    PRIMARY KEY(flight_num, source, destination),
                    FOREIGN KEY(plane_ID) REFERENCES Plane(plane_ID),
                    FOREIGN KEY(pilot_ID) REFERENCES Pilot(pilot_ID));

--Assuming that day = a date and not something like "Monday"
CREATE TABLE Schedule (flight_num Integer NOT NULL,
                      depart_time time NOT NULL,
                      arrive_time time NOT NULL,
                      source text NOT NULL,
                      destination text NOT NULL,
                      day date NOT NULL,
                      PRIMARY KEY(flight_num, source, destination),
                      FOREIGN KEY(flight_num) REFERENCES Flight(flight_num),
                      FOREIGN KEY(source) REFERENCES Flight(source),
                      FOREIGN KEY(destination) REFERENCES Flight(destination));


CREATE TABLE Customer (first_name text NOT NULL,
                      last_name text NOT NULL,
                      flight_num Integer NOT NULL,
                      gender text NOT NULL,
                      date_of_birth date NOT NULL,
                      address text NOT NULL,
                      contact_num text NOT NULL,
                      cust_ID text NOT NULL,
                      ZIP_code Integer NOT NULL,
                      PRIMARY KEY(cust_ID),
                      FOREIGN KEY(flight_num) REFERENCES Flight(flight_num));

CREATE TABLE Reservation (Rnum text NOT NULL,
                         PRIMARY KEY(Rnum));

CREATE TABLE Waitlisted (Rnum text NOT NULL,
                        PRIMARY KEY(Rnum)
                        FOREIGN KEY(Rnum) REFERENCES Reservation(Rnum));

CREATE TABLE Confirmed (Rnum text NOT NULL,
                        PRIMARY KEY(Rnum),
                        FOREIGN KEY(Rnum) REFERENCES Reservation(Rnum));

CREATE TABLE Reserved (Rnum text NOT NULL,
                      PRIMARY KEY(Rnum)
                      FOREIGN KEY(Rnum) REFERENCES Reservation(Rnum));

CREATE TABLE Has (flight_num Integer NOT NULL,
                  cust_ID text NOT NULL,
                  source text NOT NULL,
                  destination text NOT NULL,
                  Rnum text NOT NULL,
                  PRIMARY KEY(flight_num,cust_ID,source,destination, Rnum),
                  FOREIGN KEY(flight_num) REFERENCES Flight(flight_num),
                  FOREIGN KEY(cust_ID) REFERENCES Customer(cust_ID),
                  FOREIGN KEY(source) REFERENCES Flight(source),
                  FOREIGN KEY(destination) REFERENCES Flight(destination),
                  FOREIGN KEY(Rnum) REFERENCES Reservation(Rnum));
