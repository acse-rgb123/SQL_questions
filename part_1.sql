-- List all actors.
SELECT * FROM actor;

-- Find the surname of the actor with the forename 'John'.
SELECT last_name 
FROM actor
WHERE first_name LIKE 'John';

-- Find all actors with surname 'Neeson'.
SELECT * 
FROM actor
WHERE last_name LIKE 'Neeson';

-- Find all actors with ID numbers divisible by 10.
SELECT * 
FROM actor
WHERE MOD(actor_id, 10) = 0;

-- What is the description of the movie with an ID of 100.
SELECT * 
FROM film
WHERE film_id = 100;

-- Find every R-rated movie.
SELECT * 
FROM film 
WHERE rating = 'R';

-- Find every non-R-rated movie.
SELECT * 
FROM film 
WHERE rating <> 'R';

-- Find the ten shortest movies.
SELECT title, length 
FROM film 
ORDER BY length ASC 
LIMIT 10;

-- Find the movies with the longest runtime, without using LIMIT.
SELECT * 
FROM film 
ORDER BY length DESC;

-- Using HAVING, reverse-alphabetically list the last names that are not repeated.
SELECT first_name
FROM actor
GROUP BY first_name
HAVING COUNT(last_name) = 1;

-- Using HAVING, list the last names that appear more than once, from highest to lowest frequency.
SELECT last_name, COUNT(last_name) AS freq
FROM (
    SELECT last_name FROM actor
    UNION ALL
    SELECT last_name FROM customer
) AS combined_last_names
GROUP BY last_name
HAVING freq > 1
ORDER BY freq DESC;

-- Which actor has appeared in the most films.
SELECT actor.*, COUNT(film_actor.actor_id) AS freq
FROM actor
LEFT JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id
ORDER BY freq DESC
LIMIT 1;

-- When is 'Academy Dinosaur' due?
SELECT rental.rental_date + INTERVAL film.rental_duration DAY AS due_date
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE film.title = 'Academy Dinosaur'
LIMIT 1;

-- What is the average runtime of all films?
SELECT AVG(length) AS average_runtime
FROM film;

-- List the average runtime for every film category.
SELECT c.name AS category_name, AVG(f.length) AS average_runtime
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

-- List all movies featuring a robot.
SELECT f.title
FROM film f
JOIN film_text ft ON f.film_id = ft.film_id
WHERE ft.description LIKE '%robot%';

-- How many movies were released in 2010?
SELECT COUNT(*) AS movie_count
FROM film
WHERE release_year = 2010;

-- Find the titles of all the horror movies.
SELECT f.title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Horror';

-- List the full name of the staff member with the ID of 2.
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM staff
WHERE staff_id = 2;

-- List all the movies that Fred Costner has appeared in.
SELECT f.title
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
WHERE a.first_name = 'Fred' AND a.last_name = 'Costner';

-- How many distinct countries are there?
SELECT count(DISTINCT country) 
FROM country;

-- List the name of every language in reverse-alphabetical order.
SELECT * 
FROM language 
ORDER BY name DESC;

-- List the full names of every actor whose surname ends with '-son' in alphabetical order by their forename.
SELECT first_name, last_name 
FROM actor 
WHERE last_name LIKE '%son' 
ORDER BY first_name ASC;

-- Which category contains the most films?
SELECT category_id, COUNT(category_id) AS freq 
FROM film_category 
GROUP BY category_id 
ORDER BY freq DESC 
LIMIT 1;
