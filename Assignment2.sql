CREATE Database Company;

CREATE table Employee(Employee_ID int primary key not null,Name char(20),Age int,Salary Double);

CREATE table Department(Department_ID int primary key not null,Name char(20),Budget Double,Manager_ID int);

CREATE table Work(Employee_ID int,Department_ID int,Pct_Time int,FOREIGN KEY (Employee_ID) references Employee(Employee_ID),FOREIGN KEY (Department_ID) references Department(Department_ID));



INSERT INTO Employee values(10,'Paul',27,100000);
INSERT INTO Employee values(20,'Thomas',55,500000);
INSERT INTO Employee values(30,'Anderson',39,400000);
INSERT INTO Employee values(40,'Karl',71,120000);
INSERT INTO Employee values(50,'Jaismin',30,200000);
INSERT INTO Employee values(60,'Andrew',23,1000000);
INSERT INTO Employee values(70,'Jack',42,36000);
INSERT INTO Employee values(80,'Bruce',37,1160000);


INSERT INTO Department values(100,'Software',200000,10);
INSERT INTO Department values(200,'Hardware',300000,50);
INSERT INTO Department values(300,'Testing',45000,60);
INSERT INTO Department values(400,'QA',100000,20);


INSERT INTO Work values(20,100,3);
INSERT INTO Work values(60,200,5);
INSERT INTO Work values(20,200,8);
INSERT INTO Work values(30,100,6);
INSERT INTO Work values(70,200,10);
INSERT INTO Work values(40,100,2);
INSERT INTO Work values(80,200,7);


1)
SELECT e.Employee_ID,e.Name,Age,Salary 
FROM Employee e, Department d,Work w
WHERE e.Employee_ID=w.Employee_ID AND d.Department_ID=w.Department_ID
AND d.Name='Hardware'  AND e.Employee_ID  IN (SELECT w2.Employee_ID 
FROM Work w2, Department d2 
WHERE w2.Department_ID=d2.Department_ID
AND d2.Name='Software');

2)
SELECT (SELECT Name FROM Employee WHERE Employee_Id=d.Manager_Id) AS 'Manager',GROUP_CONCAT(e.Name) As 'Employee' 
FROM Work w,Department d,Employee e 
WHERE w.Department_Id=d.Department_Id 
AND w.Employee_Id<>d.Manager_Id 
AND  e.Employee_Id=w.Employee_Id 
GROUP BY w.Department_Id;



4)
SELECT e.Name as 'Employee Name'
FROM Employee e,Department d,Work w
WHERE e.Employee_ID=w.Employee_ID AND d.Department_ID=w.Department_ID AND
e.Salary>d.Budget;


5)
SELECT e.Employee_ID as 'Manager_ID',e.Name as 'Manager_Name'
FROM Employee e
WHERE e.Employee_ID IN (SELECT d.Manager_ID
FROM Department d
WHERE  d.budget>100000);

6)select distinct e.Name 
from Employee e, Work w, Department d 
where e.Employee_Id=w.Employee_Id and w.Department_ID=d.Department_ID and 
      e.salary >all (select max(d2.Budget) from Department d2 where d2.Department_ID=d.Department_ID) Or 
	  e.salary > (select max(d3.Budget) from Department d3 where d3.Department_ID=d.Department_ID);
