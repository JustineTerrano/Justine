#WHERE CLAUSE
SELECT salary
FROM parks_and_recreation.employee_salary;

SELECT *
FROM parks_and_recreation.employee_salary
WHERE salary >50000;

SELECT *
FROM parks_and_recreation.employee_salary
WHERE salary != 50000;




SELECT *
FROM parks_and_recreation.employee_demographics
WHERE birth_date > '1985-01-01';

#LOGICAL OPEARATORS (AND, OR, NOT)

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE birth_date > '1985-01-01'
AND gender = 'Male';

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE birth_date > '1985-01-01'
OR gender = 'Male';

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE (first_name = 'Leslie' AND age = 44) OR age >55;

#(ISOLATED CONDITIONAL STATEMENT) 
#LIKE STATEMENT LOOKS FOR SEQUENCE AND CAN BRING VALUES THAT ARE NOT EXACTLY MATCHED EX. JERRY, JEROME CAN BE PICKED UP BY PUTTING 'JER' IN THE LIKE STATEMENT.
#UNLIKE WHERE, WHICH BRINGS EXACT VALUE.

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE 'Leslie';


#% REPRESENTS 'ANYTHING' SUBSTITUTE THE MISSING VALUE.
# _ REPRESENTS HOW MANY VALUES ARE MISSING PER UNDERSCORE EXACTLY, SO 1 _ MEANS ONE VALUE, 2 MEANS 2 VALUE OR LETTERS.

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE 'Les%';

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE '%es%';

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE 'L__%';


      #SELECT
	  #FROM
	  #WHERE
	  #LIKE
      
#GROUP BY
#GROUP BY groups ROWS with same VALUES in SPECIFIED COLUMNS
#GROUP BY HAS VALUES COMPARED TO DISTINCT WHICH DOES NOT HAVE VALUES UNDER
#GROUP BY - AGGREGATED FUNCTION

#AGGREGATE FUNCTION PUT IN SELECT 

SELECT gender
FROM parks_and_recreation.employee_demographics
GROUP BY gender; 

SELECT gender, AVG(age)
FROM parks_and_recreation.employee_demographics
GROUP BY gender;

SELECT occupation, AVG (salary)
FROM parks_and_recreation.employee_salary
GROUP BY occupation;

SELECT gender, AVG(age), MAX(age)
FROM parks_and_recreation.employee_demographics
GROUP BY gender;


 #ORDER BY (ASC OR DESC)
 
 SELECT *
 FROM parks_and_recreation.employee_demographics
 ORDER BY age DESC, birth_date DESC;
 
 SELECT occupation, AVG(salary)
 FROM parks_and_recreation.employee_salary
 GROUP BY occupation
 ORDER BY AVG(salary) DESC;
 
 
 #SELECT 
 #FROM 
 #GROUP BY 
 #ORDER BY
 
 #group by should be identified first before the HAVING clause and the aggrefgate function
 
 SELECT gender, AVG(age)
 FROM parks_and_recreation.employee_demographics
 GROUP BY gender
 HAVING AVG(age)>40;
 
#HAVING Clause will only work for aggregated function AFTER GROUP BY CLAUSE

SELECT occupation, AVG(salary) 
FROM parks_and_recreation.employee_salary
WHERE occupation LIKE '%Manager%'
GROUP BY occupation
HAVING AVG(salary) >75000;


#LIMIT to specify the ROW in the OUTPUT

SELECT *
FROM parks_and_recreation.employee_salary
ORDER BY salary DESC
LIMIT 5;

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY age DESC
LIMIT 2, 1;
