BEGIN;

ALTER TABLE cities
	ADD COLUMN city_time_zone VARCHAR(150)
;

COMMIT;