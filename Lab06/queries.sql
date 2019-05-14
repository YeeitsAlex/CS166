---------------------------------------
-- Alexander Yee
-- CS166
-- TR 6-9PM
-- Lab 6 SQL
---------------------------------------

--Find the total number of parts supplied by each supplier.
SELECT S.sname, COUNT(*)
FROM Suppliers S NATURAL JOIN Catalog C
GROUP BY S.sname;

--Find the total number of parts supplied by each supplier who
--supplies at least 3 parts.
SELECT S.sname, COUNT(*)
FROM Suppliers S NATURAL JOIN Catalog C
GROUP BY S.sname
HAVING COUNT(*) > 2;

--For every supplier that supplies only green parts, print the name
--of the supplier and the total number of parts that he supplies.
SELECT S.sname, COUNT(*)
FROM Suppliers S NATURAL JOIN Catalog C NATURAL JOIN Parts P
WHERE S.sid NOT IN(SELECT C2.sid
			From Catalog C2 NATURAL JOIN Parts P2
			WHERE P2.color <> 'Green')
GROUP BY S.sname;

--For every supplier that supplies green part and red part, print the
--name of the supplier and the price of the most expensive part that
--he supplies
SELECT S.sname, MAX(c.cost)
FROM Suppliers S NATURAL JOIN Catalog C NATURAL JOIN Parts P
WHERE S.sid IN (SELECT S2.sid
		FROM Suppliers S2 NATURAL JOIN Catalog C2 NATURAL JOIN Parts P2
		WHERE P2.color = 'Red'
		INTERSECT
		SELECT S3.sid
		FROM Suppliers S3 NATURAL JOIN Catalog C3 NATURAL JOIN Parts P3
		WHERE P3.color = 'Green')
GROUP BY S.sname
