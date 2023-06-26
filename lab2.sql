CREATE DATABASE db;
CREATE TABLE
    tbl_Employee (
        employee_name VARCHAR(255) NOT NULL,
        street VARCHAR(255) NOT NULL,
        city VARCHAR(255) NOT NULL,
        PRIMARY KEY(employee_name)
    );


CREATE TABLE
    tbl_Works (
        employee_name VARCHAR(255) NOT NULL,
        FOREIGN KEY (employee_name) REFERENCES tbl_Employee(employee_name),
        company_name VARCHAR(255),
        salary DECIMAL(10, 2)
    );

CREATE TABLE
    tbl_Company (
        company_name VARCHAR(255) NOT NULL,
        city VARCHAR(255),
        PRIMARY KEY(company_name)
    );

CREATE TABLE
    tbl_Manages (
        employee_name VARCHAR(255) NOT NULL,
        FOREIGN KEY (employee_name) REFERENCES tbl_Employee(employee_name),
        manager_name VARCHAR(255)
    );

INSERT INTO tbl_Employee(employee_name, street, city) VALUES ('John Smith', '902 Street', 'Houston');

INSERT INTO
    tbl_Employee (employee_name, street, city)
VALUES (
        'Alice Williams',
        '321 Maple St',
        'Houston'
    ), (
        'Sara Davis',
        '159 Broadway',
        'New York'
    ), (
        'Mark Thompson',
        '235 Fifth Ave',
        'New York'
    ), (
        'Ashley Johnson',
        '876 Market St',
        'Chicago'
    ), (
        'Emily Williams',
        '741 First St',
        'Los Angeles'
    ), (
        'Michael Brown',
        '902 Main St',
        'Houston'
    ), (
        'Samantha Smith',
        '111 Second St',
        'Chicago'
    );
SELECT * FROM tbl_Works;

INSERT INTO
    tbl_Employee (employee_name, street, city)
VALUES (
        'Patrick',
        '123 Main St',
        'New Mexico'
    );

INSERT INTO
    tbl_Works (
        employee_name,
        company_name,
        salary
    )
VALUES (
        'Patrick',
        'Pongyang Corporation',
        500000
    );

INSERT INTO
    tbl_Works (
        employee_name,
        company_name,
        salary
    )
VALUES (
        'Sara Davis',
        'First Bank Corporation',
        82500.00
    ), (
        'Mark Thompson',
        'Small Bank Corporation',
        78000.00
    ), (
        'Ashley Johnson',
        'Small Bank Corporation',
        92000.00
    ), (
        'Emily Williams',
        'Small Bank Corporation',
        86500.00
    ), (
        'Michael Brown',
        'Small Bank Corporation',
        81000.00
    ), (
        'Samantha Smith',
        'Small Bank Corporation',
        77000.00
    );

INSERT INTO
    tbl_Company (company_name, city)
VALUES (
        'Small Bank Corporation', 'Chicago'), 
        ('ABC Inc', 'Los Angeles'), 
        ('Def Co', 'Houston'), 
        ('First Bank Corporation','New York'), 
        ('456 Corp', 'Chicago'), 
        ('789 Inc', 'Los Angeles'), 
        ('321 Co', 'Houston'),
        ('Pongyang Corporation','Chicago'
    );



INSERT INTO
    tbl_Manages(employee_name, manager_name)
VALUES 
    ('Mark Thompson', 'Emily Williams'),
    ('John Smith', 'Jane Doe'),
    ('Alice Williams', 'Emily Williams'),
    ('Samantha Smith', 'Sara Davis'),
    ('Patrick', 'Jane Doe');

SELECT * FROM tbl_Employee;
SELECT * FROM tbl_Works;
SELECT * FROM tbl_Manages;
SELECT * FROM tbl_Company;


-- Update the value of salary to 1000 where employee name= John Smith and company_name = First Bank Corporation
UPDATE tbl_Works
SET salary = '1000'
WHERE
    employee_name = 'John Smith'
AND company_name = 'First Bank Corporation';


--QUueries:
--1.) Find the name of all employees who works for first bank
SELECT employee_name FROM tbl_Works WHERE company_name = 'First Bank Corporation';


--2.) Find name and cities of employee who works for first bank
SELECT tbl_Employee.employee_name,city FROM tbl_Employee,tbl_Works WHERE tbl_Works.company_name = 'First Bank Corporation'AND tbl_Employee.employee_name=tbl_Works.employee_name; 


--3.) Find name,street address, city,of employee who works for first bank and earns more than $10,000 
SELECT tbl_Employee.employee_name,city FROM tbl_Employee,tbl_Works WHERE tbl_Works.company_name = 'First Bank Corporation'AND tbl_Employee.employee_name=tbl_Works.employee_name AND tbl_Works.salary>10000; 



--4.) Find all employees in the database who live in the same cities as the companies for which they work

SELECT tbl_Employee.employee_name, tbl_Company.city FROM tbl_Company,tbl_Works, tbl_Employee 
WHERE tbl_Employee.employee_name = tbl_Works.employee_name
AND tbl_Company.city = tbl_Employee.city
AND tbl_company.company_name = tbl_Works.company_name;																																																		
		

--5.) Find all employees in the database who live in the same cities and on the same streets as do their managers.


--6.) Find all employees in the database who do not work for First Bank Corporation.SELECT * FROM tbl_Works WHERE company_name <> 'First Bank Corporation';

--7.) Find all employees in the database who earn more than each employee of Small Bank Corporation.
SELECT * FROM tbl_Works WHERE salary > (SELECT MAX(salary) FROM tbl_Works WHERE company_name = 'Small Bank Corporation');

--8.) Assume that the companies may be located in several cities. Find all companies located in every city in which Small Bank Corporation is located.
SELECT * FROM tbl_Company WHERE city IN (SELECT city FROM tbl_Company WHERE company_name = 'Small Bank Corporation');

--9.) Find all employees who earn more than the average salary of all employees of their company.
SELECT employee_name, company_name FROM tbl_Works w1
WHERE salary > (SELECT AVG(salary) FROM tbl_Works WHERE tbl_Works.company_name = w1.company_name);

--10.) Find the company that has the most employees.
SELECT TOP 1 company_name, COUNT(*) AS Employee_number FROM tbl_Works 
GROUP BY company_name
ORDER BY Company_name DESC;

--11.) Find the company that has the smallest payroll.
SELECT TOP 1 company_name, AVG(salary) AS Payroll FROM tbl_Works 
GROUP BY company_name
ORDER BY Payroll DESC;

--12.) Find those companies whose employees earn a higher salary, on average, than the average salary at First Bank Corporation
SELECT company_name FROM tbl_Works 
GROUP BY company_name
HAVING MIN(salary)>(SELECT AVG(Salary) FROM tbl_Works WHERE company_name = 'First Bank Corporation');

--3.1) Modify the database so that Jones now lives in Newtown
UPDATE tbl_Employee
SET city = 'Newton'
WHERE employee_name = 'John Smith';
SELECT employee_name,city FROM tbl_Employee;

--3.2) Give all employees of First Bank Corporation a 10 percent raise.
UPDATE tbl_Works
SET salary= salary*1.1
WHERE company_name = 'First Bank Corporation';
SELECT * FROM tbl_Works;

--3.3) Give all managers of First Bank Corporation a 10 percent raise
SELECT tbl_Employee.employee_name FROM tbl_Employee,tbl_Employee E1,tbl_Manages
WHERE tbl_Manages.manager_name = E1.employee_name

