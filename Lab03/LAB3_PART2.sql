DROP TABLE IF EXISTS Place cascade;
DROP TABLE IF EXISTS Telephone cascade;
DROP TABLE IF EXISTS Musicians cascade;
DROP TABLE IF EXISTS Instrument cascade;
DROP TABLE IF EXISTS Album cascade;
DROP TABLE IF EXISTS Songs cascade;
DROP TABLE IF EXISTS Plays;
DROP TABLE IF EXISTS Perform;
DROP TABLE IF EXISTS Lives;


CREATE TABLE Place(
      address text,
      PRIMARY KEY (address));

CREATE TABLE Telephone(
      phone_no CHAR(16) NOT NULL,
      address text,
      PRIMARY KEY(phone_no),
      FOREIGN KEY(address) REFERENCES Place(address));

CREATE TABLE Musicians(
      ssn CHAR(11) NOT NULL,
      name text NOT NULL,
      PRIMARY KEY(ssn));

CREATE TABLE Instrument(
      inst_id CHAR(20) NOT NULL,
      dname text,
      key CHAR(11),
      PRIMARY KEY(inst_id));

CREATE TABLE Album(
      album_id CHAR(20) NOT NULL,
      ssn CHAR(11) NOT NULL,
      copyrightDate DATE NOT NULL,
      speed Integer,
      title text NOT NULL,
      PRIMARY KEY(album_id),
      FOREIGN KEY(ssn) REFERENCES Musicians(ssn));

CREATE TABLE Songs(
      songID CHAR(20) NOT NULL,
      album_id CHAR(20),
      title text NOT NULL,
      artist text NOT NULL,
      PRIMARY KEY(songID),
      FOREIGN KEY(album_id) REFERENCES Album(album_id));

CREATE TABLE Plays(
      ssn CHAR(11),
      inst_id char(20),
      PRIMARY KEY(ssn, inst_id),
      FOREIGN KEY(ssn) REFERENCES Musicians(ssn),
      FOREIGN KEY(inst_id) REFERENCES Instrument(inst_id));

CREATE TABLE Perform(
      ssn CHAR(11),
      songID CHAR(20),
      PRIMARY KEY(ssn,songID),
      FOREIGN KEY(ssn) REFERENCES Musicians(ssn),
      FOREIGN KEY(songID) REFERENCES Songs(songID));

CREATE TABLE Lives(
      ssn CHAR(11),
      address text,
      PRIMARY KEY(ssn,address),
      FOREIGN KEY(ssn) REFERENCES Musicians(ssn),
      FOREIGN KEY(address) REFERENCES Place(address));
