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