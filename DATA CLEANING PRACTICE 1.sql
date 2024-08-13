#DATA CLEANING PRACTICE
#source: ALEX THE ANALYST
#link: https://www.youtube.com/watch?v=4UltKCnnnTA&t=1707s

SELECT *
FROM layoffs;

#STEPS
#1. Remove Duplicates
#2. Standardized the Data (Fix Formats)
#3. Change or Remove Null & Blank Values
#4.Remove Unnecessary Columns

CREATE TABLE layoff_staging
LIKE layoffs;

SELECT *
FROM layoff_staging;

INSERT layoff_staging
SELECT *
FROM layoffs;

#1. REMOVE DUPLICATES
	#Selecting date with duplicates identified by row numbers
    
SELECT *,
ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off, arrangement, stage, country, funds_raised_millions) row_num
FROM layoff_staging;

#CTE used to easily identify rows >1
WITH CTE_Duplicate AS
(SELECT *,
ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off, arrangement, stage, country, funds_raised_millions) row_num
FROM layoff_staging)
SELECT *
FROM CTE_Duplicate
WHERE row_num > 1;

#Creating similar table basing it off from the cte duplicate to delete the rows >1

CREATE TABLE `layoff_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `arrangement` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoff_staging2;

INSERT INTO layoff_staging2
(SELECT *,
ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off, arrangement, stage, country, funds_raised_millions) row_num
FROM layoff_staging);

#Select the table and the rows to be deleted first to double check
SELECT *
FROM layoff_staging2
WHERE row_num >1;

#Deleting the duplicates
DELETE
FROM layoff_staging2
WHERE row_num >1;

#2. Standardized the Data (Fix Formats)
		#Check every columns
#remove unnecessary spaces
SELECT TRIM(company) 
FROM layoff_staging2;

UPDATE layoff_staging2
SET company = TRIM(company);

SELECT industry
FROM layoff_staging2
WHERE industry LIKE 'Crypto%';

UPDATE layoff_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT industry 
FROM layoff_staging2
ORDER BY 1;

SELECT DISTINCT country
FROM layoff_staging2
WHERE country LIKE '%.';

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoff_staging2
ORDER BY 1;

UPDATE layoff_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

#FIXING THE TEXT TO DATE FORMAT

SELECT arrangement,
STR_TO_DATE(arrangement, '%m/%d/%Y')
FROM layoff_staging2;

UPDATE layoff_staging2
SET arrangement = STR_TO_DATE(arrangement, '%m/%d/%Y');

SELECT arrangement
FROM layoff_staging2;

#Change the data type at the beginning then alter the date format for it to be easier
ALTER TABLE layoff_staging2
MODIFY COLUMN arrangement DATE;

SELECT arrangement
FROM layoff_staging2;

SELECT *
FROM layoff_staging2
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;

SELECT *
FROM layoff_staging2
WHERE industry IS NULL OR industry = '';

SELECT *
FROM layoff_staging2
WHERE company = 'Airbnb';

SELECT *
FROM layoff_staging2 T1
JOIN layoff_staging2 T2
	ON T1.company = T2.company    
WHERE (T1.industry IS NULL OR T1.industry = '')
AND T2.industry IS NOT NULL;

SELECT T1.industry, T2.industry
FROM layoff_staging2 T1
JOIN layoff_staging2 T2
	ON T1.company = T2.company    
WHERE (T1.industry IS NULL OR T1.industry = '')
AND T2.industry IS NOT NULL;

UPDATE layoff_staging2 T1
JOIN layoff_staging2 T2
	ON T1.company = T2.company
SET T1.industry = T2.industry
WHERE T1.industry IS NULL 
AND T2.industry IS NOT NULL;

UPDATE layoff_staging2 
SET industry = NULL
WHERE industry = '';

SELECT *
FROM layoff_staging2
WHERE company = 'Airbnb';

SELECT *
FROM layoff_staging2
WHERE industry IS NULL OR industry = '';

SELECT *
FROM layoff_staging2
WHERE company LIKE 'Bally%';

SELECT DISTINCT industry
FROM layoff_staging2;

SELECT *
FROM layoff_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE 
FROM layoff_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM layoff_staging2;

ALTER TABLE layoff_staging2
DROP COLUMN row_num;
