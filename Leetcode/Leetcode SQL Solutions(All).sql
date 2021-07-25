/*
Combine Two Tables

Table: Person
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| PersonId    | int     |
| FirstName   | varchar |
| LastName    | varchar |
+-------------+---------+
PersonId is the primary key column for this table.
Table: Address
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| AddressId   | int     |
| PersonId    | int     |
| City        | varchar |
| State       | varchar |
+-------------+---------+
AddressId is the primary key column for this table.
Write a SQL query for a report that provides the 
following information for each person in the Person table, 
regardless if there is an address for each of those people:
FirstName, LastName, City, State
*/
select a.FirstName, a.LastName, b.City, b.State
from Person a
left join Address b
on a.PersonId = b.PersonId;

/*
Second Highest Salary
SQL Schema
Write a SQL query to get the second highest salary from the 
Employee table.
+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
For example, given the above Employee table, 
the query should return 200 as the second highest salary. 
If there is no second highest salary, then the query should return null.
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+
*/
select max(salary) as SecondHighestSalary
from Employee
where salary != (select max(salary)
from Employee)

/*
Duplicate Emails

Write a SQL query to find all duplicate emails in a table named Person.

+----+---------+
| Id | Email   |
+----+---------+
| 1  | a@b.com |
| 2  | c@d.com |
| 3  | a@b.com |
+----+---------+
For example, your query should return the following for the above table:

+---------+
| Email   |
+---------+
| a@b.com |
+---------+
Note: All emails are in lowercase.
*/
select Email
from Person
group by Email
having count(Email)>1

/*
Customers Who Never Order
Suppose that a website contains two tables, the Customers table and the Orders table. Write a SQL query to find all customers who never order anything.

Table: Customers.

+----+-------+
| Id | Name  |
+----+-------+
| 1  | Joe   |
| 2  | Henry |
| 3  | Sam   |
| 4  | Max   |
+----+-------+
Table: Orders.

+----+------------+
| Id | CustomerId |
+----+------------+
| 1  | 3          |
| 2  | 1          |
+----+------------+
Using the above tables as example, return the following:

+-----------+
| Customers |
+-----------+
| Henry     |
| Max       |
+-----------+
*/
select name as Customers
from customers
where id not in (select c.id
from  customers c
inner join orders o
on c.id = o.customerId)

/*
Employees Earning More Than Their Managers
The Employee table holds all employees including their managers. 
Every employee has an Id, and there is also a column for the manager Id.

+----+-------+--------+-----------+
| Id | Name  | Salary | ManagerId |
+----+-------+--------+-----------+
| 1  | Joe   | 70000  | 3         |
| 2  | Henry | 80000  | 4         |
| 3  | Sam   | 60000  | NULL      |
| 4  | Max   | 90000  | NULL      |
+----+-------+--------+-----------+
Given the Employee table, write a SQL query that finds out employees 
who earn more than their managers. For the above table, 
Joe is the only employee who earns more than his manager.

+----------+
| Employee |
+----------+
| Joe      |
+----------+
*/
--1th Way
SELECT A.Name as Employee
FROM Employee as A
LEFT JOIN Employee as B
ON A.ManagerId = B.Id
WHERE A.Salary > B.Salary ;

--2nd Way
SELECT a.Name AS Employee
FROM Employee AS a, Employee AS b
WHERE a.ManagerId = b.Id
     AND a.Salary > b.Salary

--3rd Way
SELECT E.name as Employee 
FROM Employee E
JOIN Employee as M
ON E.ManagerId = M.Id
WHERE E.Salary > M.Salary;
;