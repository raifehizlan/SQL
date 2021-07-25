/*
Weather Observation Station 9
Query the list of CITY names from STATION that do not start with vowels.
Your result cannot contain duplicates.
*/
SELECT DISTINCT CITY
FROM STATION
WHERE LEFT(CITY,1) NOT IN ('A','E','I','O','U')