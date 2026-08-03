# World Layoffs Data Cleaning

SELECT *
FROM layoffs;

CREATE TABLE layoffs_Backup
LIKE layoffs;

SELECT *
FROM layoffs_backup;

INSERT layoffs_backup
SELECT * 
FROM layoffs;

#Removing duplicates

SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, industry, location, total_laid_off, 
percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs;

WITH duplicate_cte AS 
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, industry, location, total_laid_off, 
percentage_laid_off, `date`, stage, country, funds_raised_millions ) AS row_num
FROM layoffs
)
SELECT * 
FROM duplicate_cte
WHERE row_num > 1;

#Testing for duplicate
SELECT * 
FROM layoffs
WHERE company = 'Casper';

#Deleting the duplicates

CREATE TABLE `layoffs2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs2;

INSERT INTO layoffs2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, industry, location, total_laid_off, 
percentage_laid_off, `date`, stage, country, funds_raised_millions ) AS row_num
FROM layoffs;

SELECT *
FROM layoffs2
WHERE row_num > 1;

DELETE
FROM layoffs2
WHERE row_num > 1;      

SELECT *
FROM layoffs2;

#Standardising Data

SELECT company, TRIM(company)
FROM layoffs2;

UPDATE layoffs2
SET company = TRIM(company);

SELECT *
FROM layoffs2
WHERE industry LIKE '%cry%';

UPDATE layoffs2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT(industry)
FROM layoffs2;

SELECT DISTINCT(country), TRIM(TRAILING '.' FROM country)
FROM layoffs2
ORDER BY country;

UPDATE layoffs2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

#Formatting the date column then changing from txt to date

SELECT `date`, STR_TO_DATE(`date`,'%m/%d/%Y')
FROM layoffs2;

UPDATE layoffs2
SET `date` = STR_TO_DATE(`date`,'%m/%d/%Y');

SELECT `date`
FROM layoffs2;

ALTER TABLE layoffs2
MODIFY COLUMN `date` DATE;

SELECT *
FROM layoffs2;

# Working with NULL and Blanks

SELECT *
FROM layoffs2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM layoffs2
WHERE industry IS NULL 
OR industry = '';

SELECT *
FROM layoffs2
WHERE company = 'Airbnb';


SELECT *
FROM layoffs2 t1
JOIN layoffs2 t2
 ON t1.company = t2.company
  AND t1.location = t2.location
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

UPDATE layoffs2
SET industry = NULL 
WHERE industry = '';

UPDATE layoffs2 t1
JOIN layoffs2 t2
  ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

SELECT *
FROM layoffs2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE
FROM layoffs2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM layoffs2;

ALTER TABLE layoffs2
DROP COLUMN row_num;



