#SUBQUERIES
#Query WITHIN a Query 

#SUBQUERY IN WHERE
	#Primary query (subquery)
SELECT *
FROM employee_demographics
WHERE employee_id in
					(SELECT employee_id
                    FROM employee_salary
                    WHERE dept_id =1);

#SUBQUERY IN SELECT STATEMENT

SELECT first_name, salary,
(SELECT AVG(salary)
FROM employee_salary)
FROM employee_salary;
  
#SUBQUERY IN FROM STATEMENT

SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender;


SELECT AVG(`MAX(age)`)
FROM (SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender) Agg_Table;

SELECT AVG(`MaxAge`) AS AveofMaxAge
FROM (SELECT gender, AVG(age) AveAge, MAX(age) MaxAge, MIN(age) MinAge, COUNT(age) CountofAge
FROM employee_demographics
GROUP BY gender) Agg_Table;


#WINDOW FUNCTION


SELECT demo.first_name, gender, AVG(salary) OVER(PARTITION BY gender)
FROM employee_demographics demo
JOIN employee_salary wage
	ON demo.employee_id = wage.employee_id;
    
SELECT demo.first_name, gender, SUM(salary) OVER(PARTITION BY gender)
FROM employee_demographics demo
JOIN employee_salary wage
	ON demo.employee_id = wage.employee_id;
    
SELECT demo.first_name, demo.last_name, salary, 
SUM(salary) OVER(PARTITION BY gender ORDER BY demo.employee_id) AS Rolling_Total
FROM employee_demographics demo
JOIN employee_salary wage
	ON demo.employee_id = wage.employee_id;

SELECT demo.first_name, demo.last_name, salary, 
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary 	DESC) AS SalaryRowPerGender
FROM employee_demographics demo
JOIN employee_salary wage
	ON demo.employee_id = wage.employee_id;
    
SELECT demo.first_name, demo.last_name, salary, 
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS SalaryRow,
RANK()OVER(PARTITION BY gender ORDER BY salary DESC) AS SalaryRank,
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary 	DESC) AS SalaryDenseRank
FROM employee_demographics demo
JOIN employee_salary wage
	ON demo.employee_id = wage.employee_id;
    
#TABLES

#CTE TABLE

#Creating CTE - WITH (used to create CTE

WITH CTE_Example (Gender, AVE, MAX, MIN, COUNT) AS
(SELECT gender, AVG(salary) ave, MAX(salary) max, MIN(salary) min, COUNT(salary) count
FROM employee_demographics demo
JOIN employee_salary wage
		ON demo.employee_id = wage.employee_id
GROUP BY gender
)
SELECT *
FROM CTE_Example;  


WITH CTE_Example AS
(SELECT employee_id, gender, birth_date
FROM employee_demographics demo
WHERE birth_date > 1985-01-01 
),
CTE_Example2 AS
(SELECT *
FROM employee_salary
WHERE salary > 50000
) 
SELECT * 
FROM CTE_Example
JOIN CTE_Example2 
	ON CTE_Example.employee.id = CTE_Example2.employee.id;
    
    
#TEMP_TABLE

CREATE TEMPORARY TABLE temp_table
(first_name varchar(50),
last_name varchar(50),
favorite_movie varchar(100)
);

SELECT *
FROM temp_table;

INSERT INTO temp_table VALUES
('Justine', 'Terrano', 'Gone Girl');

CREATE TEMPORARY TABLE SalaryOver50k
SELECT *
FROM employee_salary
WHERE salary >= 50000;

SELECT *
FROM SalaryOver50k;

#STORED_PROCEDURES


USE parks_and_recreation;
CREATE PROCEDURE large_salaries()
SELECT *
FROM employee_salary
WHERE salary >= 50000;

CALL large_salaries();


DELIMITER $$
CREATE PROCEDURE large_salaries2()
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 50000;
	SELECT *
	FROM employee_salary
	WHERE salary >= 15000;
END $$
DELIMITER ;

CALL large_salaries2();

#PARAMETER

DELIMITER $$
CREATE PROCEDURE large_salariesnew(idparameter INT)
BEGIN
	SELECT salary
	FROM employee_salary
	WHERE employee_id = idparameter ;
END $$
DELIMITER ;

CALL large_salariesnew(1);

DELIMITER $$
CREATE TRIGGER new_employee
	AFTER INSERT ON employee_salary
    FOR EACH ROW
BEGIN
	INSERT INTO employee_demographics(employee_id, first_name, last_name)
    VALUES (NEW.employee_id, NEW.first_name, NEW.lasT_name);
END $$
DELIMITER ;

SELECT *
FROM employee_demographics;
    
INSERT INTO employee_salary(employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES (13, 'Justine', 'Terrano', 'Data Analyst', 20000, NULL);

SELECT *
FROM employee_salary;

SELECT *
FROM employee_demographics;

#EVENTS

DELIMITER $$
CREATE EVENT ToRetire
ON SCHEDULE EVERY 30 SECOND
DO
BEGIN
	DELETE
	FROM employee_demographics
    WHERE age >=60;
END $$
DELIMITER ;









