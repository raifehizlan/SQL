/*
Weather Observation Station 11
Query the list of CITY names from STATION that either do not start with vowels
or do not end with vowels. 
Your result cannot contain duplicates.
*/

SELECT DISTINCT CITY
FROM STATION
WHERE LEFT(CITY,1) NOT IN ('A','E','I','O','U') 
OR RIGHT(CITY,1) NOT IN ('a','e','i','o','u')
