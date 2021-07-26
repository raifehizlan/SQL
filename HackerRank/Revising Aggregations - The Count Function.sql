/*
Revising Aggregations - The Count Function
Query a count of the number of cities in CITY 
having a Population larger than 100000.
*/
SELECT COUNT(id)
FROM city
WHERE population >100000;