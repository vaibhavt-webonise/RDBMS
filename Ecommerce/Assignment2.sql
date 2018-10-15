CREATE Database Company;

CREATE table Employee(Employee_ID int primary key not null,Name char(20),Age int,Salary Double);

CREATE table Department(Department_ID int primary key not null,Name char(20),Budget Double,Manager_ID int);

CREATE table Work(Employee_ID int,Department_ID int,Pct_Time int,FOREIGN KEY (Employee_ID) references Employee(Employee_ID),FOREIGN KEY (Department_ID) references Department(Department_ID));



INSERT INTO Employee values(10,'Thomas',27,15000);
INSERT INTO Employee values(20,'Anderson',55,45000);
INSERT INTO Employee values(30,'Karl',39,30000);
INSERT INTO Employee values(40,'Andrew',71,12000);
INSERT INTO Employee values(50,'Jack',30,10000);


INSERT INTO Department values(100,'Software',150000,20);
INSERT INTO Department values(200,'Hardware',50000,10);
INSERT INTO Department values(300,'Testing',45000,20);
INSERT INTO Department values(400,'QA',100000,30);
INSERT INTO Department values(500,'Insurance',15000000,20);
INSERT INTO Department values(600,'Developer',400000000,30);


INSERT INTO Work values(10,100,5);
INSERT INTO Work values(10,200,4);
INSERT INTO Work values(30,300,13);
INSERT INTO Work values(50,100,12);
INSERT INTO Work values(20,200,11);


UPDATE Employee set salary=50000 WHERE Employee_ID=10;
UPDATE Department set Budget=15000 WHERE Department_ID=300;

SELECT * FROM Employee;
SELECT * FROM Department;
SELECT * FROM Work;


1)
SELECT e.Employee_ID,e.Name,Age,Salary 
FROM Employee e, Department d,Work w
WHERE e.Employee_ID=w.Employee_ID AND d.Department_ID=w.Department_ID
AND d.Name='Hardware'  AND e.Employee_ID  IN (SELECT w2.Employee_ID 
FROM Work w2, Department d2 
WHERE w2.Department_ID=d2.Department_ID
AND d2.Name='Software');

)
SELECT e.Name as 'Manager',e.name as 'Employee'
FROM Employee e,Department d,Work w
WHERE e.Employee_ID=w.Employee_ID AND d.Department_ID=w.Department_ID AND
d.Manager_ID=e.Employee_ID;


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
WHERE  d.budget>10000000);

6)select distinct e.Name 
from Employee e, Work w, Department d 
where e.Employee_Id=w.Employee_Id and w.Department_ID=d.Department_ID and 
      e.salary >all (select max(d2.Budget) from Department d2 where d2.Department_ID=d.Department_ID) Or 
	  e.salary > (select max(d3.Budget) from Department d3 where d3.Department_ID=d.Department_ID);
