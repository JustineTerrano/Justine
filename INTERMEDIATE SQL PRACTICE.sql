#JOINS

#INNER JOINS returns same rows of chosen columns from tables, so if it does not exist to one table it will not be returned.
SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary;

SELECT *
FROM employee_demographics demo
JOIN employee_salary sal
	ON demo.employee_id = sal.employee_id;

SELECT demo.employee_id, age, occupation
FROM employee_demographics demo
JOIN employee_salary sal
	ON demo.employee_id = sal.employee_id;
    
SELECT *
FROM employee_demographics demo
LEFT OUTER JOIN employee_salary sal
	ON demo.employee_id = sal.employee_id;
    
SELECT *
FROM employee_demographics demo
RIGHT OUTER JOIN employee_salary sal
	ON demo.employee_id = sal.employee_id;
    
#SELF JOIN - joining same table to each other, cross referencing
    
SELECT *
FROM employee_salary sal
JOIN employee_salary wage
	ON sal.employee_id + 1 = wage.employee_id;


#JOINING MULTIPLE TABLE

SELECT*
FROM employee_demographics demo
JOIN employee_salary wage
	ON demo.employee_id = wage.employee_id
JOIN parks_departments dept
	ON wage.dept_id = dept.department_id;
    

#UNION 
#to combine rows together
#can removes duplicates


SELECT first_name, last_name
FROM employee_demographics
UNION
SELECT first_name, last_name
FROM employee_salary;

SELECT employee_id
FROM employee_demographics
UNION
SELECT employee_id
FROM employee_salary
ORDER BY employee_id; 

SELECT first_name, last_name
FROM employee_demographics
UNION ALL
SELECT first_name, last_name
FROM employee_salary;


SELECT first_name, last_name, 'Old Man' Label 
FROM employee_demographics
WHERE age > 40 AND gender = 'Male'
UNION
SELECT first_name, last_name, 'Old Lady' Label 
FROM employee_demographics
WHERE age > 40 AND gender = 'Female'
UNION
SELECT first_name, last_name, 'High Pay' Label 
FROM employee_salary
WHERE salary > 70000
ORDER BY first_name, last_name;


#CASE STATEMENTS
#to add LOGIC in SELECT STATEMENTS
# WHEN, THEN
#CASE, END
SELECT first_name,last_name,age,
CASE 
	WHEN age <=30 THEN 'Young'
    WHEN age BETWEEN 30 AND 50 THEN 'Old'
    WHEN age >50 THEN 'On Deaths Door'
END AgeGroup
FROM employee_demographics;

SELECT *
FROM employee_salary;

#PAY INCREASE AND BONUS
#<50000 5%
#>50000 7%
#FINANCE 10%


SELECT first_name, last_name, salary,
CASE
	WHEN salary <50000 THEN salary + (salary * 0.05)
    WHEN salary >50000 THEN salary + (salary * 0.07)
END New_Salary,
CASE
	WHEN dept_id = 6 THEN salary * .10
END AS Bonus
FROM employee_salary;

#STRING FUNCTIONS

#LENGTH - cn be used to see length of phone numbers, sss which needs to have a specific length of numbers

SELECT first_name, LENGTH(first_name) AS characterlength
FROM employee_demographics
ORDER BY characterlength;

SELECT UPPER(last_name)
FROM employee_demographics;

SELECT LOWER(last_name)
FROM employee_demographics;


SELECT TRIM('           sky                ');

SELECT LTRIM('           sky                ');

SELECT RTRIM('           sky                ');

SELECT first_name, LEFT(first_name, 3),
RIGHT(first_name, 3),
SUBSTRING(first_name, 3, 5),
birth_date,SUBSTRING(birth_date, 6 ,2) Birth_Month
FROM employee_demographics;

#SUBSTRING - can be used to specify what placement you want to start and how many characters you would like to include. Strings read characters per number.


#REPLACE - is replacing a specific value with another. (column, the value to be replaced, value to replace it with)
SELECT first_name, REPLACE(first_name, 'a', 'j')
FROM employee_demographics;

#LOCATE - finding the specific character and locating its placement.
SELECT LOCATE('t', 'Justine');

SELECT first_name, last_name, CONCAT(first_name,'  ', last_name)
FROM employee_demographics;






