/*
Weather Observation Station 6
Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. 
Your result cannot contain duplicates.
*/
SELECT CITY
FROM STATION
WHERE LEFT(CITY,1) IN ('A','E','I','O','U')