--1. Count how many parts in NYC have more than 70 parts on hand
SELECT COUNT(*)
FROM part_nyc
Where on_hand > 70;

--2. Count how many total parts on hand, in both NYC and SFO, are Red
SELECT SUM(
  SELECT on_hand
  FROM part_nyc
  WHERE color = 'Red'

  UNION all

  SELECT on_hand
  FROM part_sfo
  WHERE color = 'Red'
)

--3. List all the suppliers that have more total on hand parts in NYC than they do in SFO.


--4. List all suppliers that supply parts in NYC that aren’t supplied by anyone in SFO.


--5. Update all of the NYC on hand values to on hand - 10.


--6. Delete all parts from NYC which have less than 30 parts on hand.
