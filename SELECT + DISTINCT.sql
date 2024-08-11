SELECT first_name, last_name, birth_date, age,
age + 10
FROM employee_demographics;

SELECT DISTINCT first_name
FROM parks_and_recreation.employee_demographics;

#DISTINCT IS USED TO IDENTIFY UNIQUE VALUE IN A COLUMN

SELECT DISTINCT gender
FROM parks_and_recreation.employee_demographics;
