/*
Average Population
Query the average population for all cities in CITY, rounded down to the nearest integer.
*/
SELECT CONVERT(INT, AVG(POPULATION))
FROM CITY