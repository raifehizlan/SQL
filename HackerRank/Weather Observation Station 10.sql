/*
Weather Observation Station 10
Query the list of CITY names from STATION that do not end with vowels. 
Your result cannot contain duplicates.
*/
SELECT DISTINCT CITY
FROM STATION
WHERE RIGHT(CITY,1) NOT IN ('a','e','i','o','u')