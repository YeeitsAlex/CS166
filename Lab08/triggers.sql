--CREATE SEQUENCE part_number_seq START WITH 50000;

--CREATE LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION foo()
	RETURNS "trigger" AS 
	$BODYS$
	BEGIN
		new.part_number := nextval('part_number_seq');
		Return NEW;
	END;
	$BODYS$
	
	LANGUAGE plpgsql VOLATILE;

CREATE TRIGGER myTrig
	BEFORE INSERT
	ON part_nyc
	
	FOR EACH ROW
	EXECUTE PROCEDURE foo();


