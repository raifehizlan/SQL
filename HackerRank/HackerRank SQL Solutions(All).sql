/*
Revising the Select Query I
Query all columns for all American cities in the CITY table with populations larger than 100000. 
The CountryCode for America is USA.
*/
SELECT *
FROM CITY
WHERE POPULATION >100000
AND COUNTRYCODE ='USA'

/*
Revising the Select Query II
Query the NAME field for all American cities in the CITY table with populations larger than 120000. 
The CountryCode for America is USA.
*/
SELECT NAME
FROM CITY
WHERE POPULATION > 120000
AND COUNTRYCODE = 'USA';

/*
Select All
Query all columns (attributes) for every row in the CITY table.
*/
SELECT *
FROM CITY;

/*
Select By ID
Query all columns for a city in CITY with the ID 1661.
*/
SELECT *
FROM CITY
WHERE ID = 1661

/*
Japanese Cities' Attributes
Query all attributes of every Japanese city in the CITY table. 
The COUNTRYCODE for Japan is JPN.
*/
SELECT *
FROM CITY
WHERE COUNTRYCODE = 'JPN'

/*
Japanese Cities' Names
Query the names of all the Japanese cities in the CITY table. 
The COUNTRYCODE for Japan is JPN.
*/
SELECT NAME
FROM CITY
WHERE COUNTRYCODE = 'JPN'

/*
Weather Observation Station 1
Query a list of CITY and STATE from the STATION table.
*/
SELECT CITY, STATE
FROM STATION

/*
Weather Observation Station 3
Query a list of CITY names from STATION for cities that have an even ID number. 
Print the results in any order, but exclude duplicates from the answer.
*/
SELECT DISTINCT CITY
FROM STATION
WHERE ID%2=0

/*
Weather Observation Station 4
Find the difference between the total number of CITY entries in the table 
and the number of distinct CITY entries in the table.
*/
SELECT COUNT(CITY) - COUNT(DISTINCT(CITY))
FROM STATION

/*
Weather Observation Station 5
Query the two cities in STATION with the shortest and longest CITY names, 
as well as their respective lengths (i.e.: number of characters in the name). 
If there is more than one smallest or largest city, 
choose the one that comes first when ordered alphabetically.
*/
SELECT TOP 1 CITY, LEN(CITY)
FROM STATION
ORDER BY LEN(CITY) ASC, CITY; 

SELECT TOP 1 CITY, LEN(CITY)
FROM STATION
ORDER BY LEN(CITY) DESC, CITY;

/*
Weather Observation Station 6
Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. 
Your result cannot contain duplicates.
*/
SELECT DISTINCT CITY
FROM STATION
WHERE LEFT(CITY,1) IN ('A','E','I','O','U')

/*
Weather Observation Station 7
Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. 
Your result cannot contain duplicates.
*/
SELECT DISTINCT CITY
FROM STATION
WHERE RIGHT(CITY,1) IN ('a','e','i','o','u')

/*
Weather Observation Station 8
Query the list of CITY names from STATION which have vowels 
(i.e., a, e, i, o, and u) as both their first and last characters. 
Your result cannot contain duplicates.
*/

SELECT DISTINCT CITY
FROM STATION
WHERE LEFT(CITY,1) IN ('A','E','I','O','U') 
AND RIGHT(CITY,1) IN ('a','e','i','o','u')

/*
Weather Observation Station 9
Query the list of CITY names from STATION that do not start with vowels.
Your result cannot contain duplicates.
*/
SELECT DISTINCT CITY
FROM STATION
WHERE LEFT(CITY,1) NOT IN ('A','E','I','O','U')

/*
Weather Observation Station 10
Query the list of CITY names from STATION that do not end with vowels. 
Your result cannot contain duplicates.
*/
SELECT DISTINCT CITY
FROM STATION
WHERE RIGHT(CITY,1) NOT IN ('a','e','i','o','u')

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

/*
Weather Observation Station 12
Query the list of CITY names from STATION that do not start with vowels 
and do not end with vowels. 
Your result cannot contain duplicates.
*/
SELECT DISTINCT CITY
FROM STATION
WHERE LEFT(CITY,1) NOT IN ('A','E','I','O','U') 
AND RIGHT(CITY,1) NOT IN ('a','e','i','o','u')

/*
Higher Than 75 Marks
Query the Name of any student in STUDENTS who scored higher than 75 Marks. 
Order your output by the last three characters of each name. 
If two or more students both have names ending in the same last three characters 
(i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID.
*/
SELECT NAME
FROM STUDENTS
WHERE MARKS >75
ORDER BY RIGHT(NAME,3), ID

/*
Employee Names
Write a query that prints a list of employee names (i.e.: the name attribute)
from the Employee table in alphabetical order.
*/
SELECT NAME
FROM EMPLOYEE
ORDER BY NAME;

/*
Employee Salaries
Write a query that prints a list of employee names 
(i.e.: the name attribute) for employees in Employee 
having a salary greater than $2000 per month 
who have been employees for less than  months. 
Sort your result by ascending employee_id.
*/
SELECT NAME
FROM EMPLOYEE
WHERE SALARY >2000
AND MONTHS < 10
ORDER BY EMPLOYEE_ID;

/*
Type of Triangle
Write a query identifying the type of each record in the TRIANGLES
table using its three side lengths. 
Output one of the following statements for each record in the table:

Equilateral: It's a triangle with 3 sides of equal length.
Isosceles: It's a triangle with 2 sides of equal length.
Scalene: It's a triangle with 3 sides of differing lengths.
Not A Triangle: The given values of A, B, and C don't form a triangle.
*/
SELECT
    CASE WHEN A + B <= C OR A + C <= B OR B + C <= A THEN 'Not A Triangle'
        WHEN A = B AND B = C THEN 'Equilateral'
        WHEN A = B OR A = C OR B = C THEN 'Isosceles'
        ELSE 'Scalene'
    END
FROM TRIANGLES;

/*
The PADS
Generate the following two result sets:
Query an alphabetically ordered list of all names in OCCUPATIONS, 
immediately followed by the first letter of each profession as a parenthetical 
(i.e.: enclosed in parentheses). 
For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
Query the number of ocurrences of each occupation in OCCUPATIONS. 
Sort the occurrences in ascending order, and output them in the following format:
There are a total of [occupation_count] [occupation]s.
where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS 
and [occupation] is the lowercase occupation name. 
If more than one Occupation has the same [occupation_count], 
they should be ordered alphabetically.
Note: There will be at least two entries in the table for each type of occupation.
*/
SELECT Name + '(' + LEFT(OCCUPATION,1) + ')'
FROM OCCUPATIONS 
ORDER BY Name;

SELECT 'There are a total of ',  COUNT(OCCUPATION), LOWER(OCCUPATION)+'s.'
FROM OCCUPATIONS 
GROUP BY OCCUPATION 
ORDER BY COUNT(OCCUPATION),LOWER(OCCUPATION);

/*
Revising Aggregations - The Count Function
Query a count of the number of cities in CITY 
having a Population larger than 100000.
*/
SELECT COUNT(id)
FROM city
WHERE population >100000;

/*
Revising Aggregations - The Sum Function
Query the total population of all cities in CITY where District is California.
*/
SELECT SUM(POPULATION)
FROM CITY
WHERE DISTRICT = 'California'

/*
Revising Aggregations - Averages
Query the average population of all cities in CITY where District is California.
*/
SELECT AVG(POPULATION)
FROM CITY
WHERE DISTRICT = 'California'

/*
Average Population
Query the average population for all cities in CITY, rounded down to the nearest integer.
*/
SELECT CONVERT(INT, AVG(POPULATION))
FROM CITY

/*
Japan Population
Query the sum of the populations for all Japanese cities in CITY. 
The COUNTRYCODE for Japan is JPN.
*/
SELECT SUM(POPULATION)
FROM CITY
WHERE COUNTRYCODE = 'JPN'

/*
Population Density Difference
Query the difference between the maximum and minimum populations in CITY.
*/
SELECT MAX(POPULATION) - MIN(POPULATION)
FROM CITY

/*
The Blunder
Samantha was tasked with calculating the average monthly salaries for all employees in the EMPLOYEES table, 
but did not realize her keyboard's  key was broken until after completing the calculation. 
She wants your help finding the difference between her miscalculation (using salaries with any zeros removed), 
and the actual average salary.
Write a query calculating the amount of error(i.e.:average monthly salaries), and round it up to the next integer.
*/
--My SQL
SELECT
    ROUND(AVG(SALARY)) - 
    ROUND(AVG(REPLACE(SALARY, '0','')))
FROM EMPLOYEES;


/*Draw the Triangle 1
P(R) represents a pattern drawn by Julia in R rows. 
The following pattern represents P(5):

* * * * * 
* * * * 
* * * 
* * 
*
Write a query to print the pattern P(20). */

declare @row int
set @row = 21
while @row > 1
begin
    set @row = @row -1
    print(replicate('* ', @row))    
end;


/*Draw the Triangle 2 
P(R) represents a pattern drawn by Julia in R rows. The following pattern represents P(5):

* 
* * 
* * * 
* * * * 
* * * * *
Write a query to print the pattern P(20).*/

declare @row int
set @row = 0;
while @row <20
begin
    set @row = @row + 1
    print(replicate('* ',@row))
end;

/*
The Report

You are given two tables: Students and Grades. Students contains three columns ID, Name and Marks.

Ketty gives Eve a task to generate a report containing three columns: Name, Grade and Mark. 
Ketty doesn't want the NAMES of those students who received a grade lower than 8. The report must be in descending order by grade -- 
i.e. higher grades are entered first. 
If there is more than one student with the same grade (8-10) assigned to them, order those particular students by their name alphabetically. 
Finally, if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order. 
If there is more than one student with the same grade (1-7) assigned to them, order those particular students by their marks in ascending order.

Write a query to help Eve.

Sample Output

Maria 10 99
Jane 9 81
Julia 9 88 
Scarlet 8 78
NULL 7 63
NULL 7 68

Note

Print "NULL"  as the name if the grade is less than 8.

Explanation

Consider the following table with the grades assigned to the students:
So, the following students got 8, 9 or 10 grades:

Maria (grade 10)
Jane (grade 9)
Julia (grade 9)
Scarlet (grade 8)*/

select
  case
    when g.grade < 8 then null
    else s.name
  end,
  g.grade,
  s.marks
from students as s
join grades as g
on s.marks >= g.min_mark and s.marks <= g.max_mark
order by g.grade desc, s.name asc;