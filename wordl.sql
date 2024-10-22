-- 1. Using COUNT, get the number of cities in the USA.
SELECT COUNT(*) AS city_count
FROM city
JOIN country ON city.CountryCode = country.Code
WHERE country.Name = 'United States';

-- 2. Find out the population and life expectancy for people in Argentina.
SELECT population, lifeexpectancy
FROM country
WHERE name = 'Argentina';

-- 3. Using IS NOT NULL, ORDER BY, and LIMIT, which country has the highest life expectancy?
SELECT name, lifeexpectancy
FROM country
WHERE lifeexpectancy IS NOT NULL
ORDER BY lifeexpectancy DESC
LIMIT 1;

-- 4. Using JOIN ... ON, find the capital city of Spain.
SELECT city.Name AS capital_city
FROM country
JOIN city ON country.Capital = city.ID
WHERE country.Name = 'Spain';

-- 5. Using JOIN ... ON, list all the languages spoken in the Southeast Asia region.
SELECT language.Language
FROM country
JOIN countrylanguage AS language ON country.Code = language.CountryCode
WHERE country.Region = 'Southeast Asia';

-- 6. Using a single query, list 25 cities around the world that start with the letter F.
SELECT Name
FROM city
WHERE Name LIKE 'F%'
LIMIT 25;

-- 7. Using COUNT and JOIN ... ON, get the number of cities in China.
SELECT COUNT(*) AS city_count
FROM city
JOIN country ON city.CountryCode = country.Code
WHERE country.Name = 'China';

-- 8. Using IS NOT NULL, ORDER BY, and LIMIT, which country has the lowest population? Discard non-zero populations.
SELECT name, population
FROM country
WHERE population IS NOT NULL AND population > 0
ORDER BY population ASC
LIMIT 1;

-- 9. Using aggregate functions, return the number of countries the database contains.
SELECT COUNT(*) AS country_count
FROM country;

-- 10. What are the top ten largest countries by area?
SELECT name, surfaceArea FROM country ORDER BY SurfaceArea DESC LIMIT 10;

-- 11. List the five largest cities by population in Japan.
SELECT city.Name, city.Population
FROM city
JOIN country ON city.CountryCode = country.Code
WHERE country.Name = 'Japan'
ORDER BY city.Population DESC
LIMIT 5;

-- 12. List the names and country codes of every country with Elizabeth II as its Head of State. You will need to fix the mistake first!
-- Assuming there is a typo in the HeadOfState field for "Elizabeth II" that needs fixing:
UPDATE country
SET HeadOfState = 'Elizabeth II'
WHERE HeadOfState LIKE '%Elisabeth%'; -- Fix typo

SELECT name, Code
FROM country
WHERE HeadOfState = 'Elizabeth II';

-- 13. List the top ten countries with the smallest population-to-area ratio. Discard any countries with a ratio of 0.
SELECT name, Population / SurfaceArea AS pop_area_ratio
FROM country
WHERE Population > 0 AND SurfaceArea > 0
ORDER BY pop_area_ratio ASC
LIMIT 10;

-- 14. List every unique world language.
SELECT DISTINCT Language
FROM countrylanguage;

-- 15. List the names and GNP of the world's top 10 richest countries.
SELECT name, GNP
FROM country
ORDER BY GNP DESC
LIMIT 10;

-- 16. List the names of, and number of languages spoken by, the top ten most multilingual countries.
SELECT country.Name, COUNT(DISTINCT language.Language) AS languages_spoken
FROM country
JOIN countrylanguage AS language ON country.Code = language.CountryCode
GROUP BY country.Name
ORDER BY languages_spoken DESC
LIMIT 10;

-- 17. List every country where over 50% of its population can speak German.
SELECT country.Name
FROM country
JOIN countrylanguage AS language ON country.Code = language.CountryCode
WHERE language.Language = 'German' AND language.Percentage > 50;

-- 18. Which country has the worst life expectancy? Discard zero or null values.
SELECT name, lifeexpectancy
FROM country
WHERE lifeexpectancy IS NOT NULL AND lifeexpectancy > 0
ORDER BY lifeexpectancy ASC
LIMIT 1;

-- 19. List the top three most common government forms.
SELECT governmentform, COUNT(*) AS frequency
FROM country
GROUP BY governmentform
ORDER BY frequency DESC
LIMIT 3;

-- 20. How many countries have gained independence since records began?
SELECT COUNT(*) AS independent_countries
FROM country
WHERE IndependenceYear IS NOT NULL;

