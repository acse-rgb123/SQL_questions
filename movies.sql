USE movielens;

-- List the titles and release dates of movies released between 1983-1993 in reverse chronological order.
SELECT title, release_date 
FROM movies 
WHERE release_date > '1982-12-31' 
  AND release_date < '1994-01-01' 
ORDER BY release_date DESC;

-- Without using LIMIT, list the titles of the movies with the lowest average rating.
SELECT title 
FROM movies 
LEFT JOIN ratings ON movies.id = ratings.movie_id 
WHERE ratings.rating = 1;

-- List the unique records for Sci-Fi movies where male 24-year-old students have given 5-star ratings.
SELECT DISTINCT title 
FROM movies 
INNER JOIN genres_movies ON genres_movies.movie_id = movies.id 
INNER JOIN genres ON genres.id = genres_movies.genre_id 
INNER JOIN ratings ON ratings.movie_id = movies.id 
INNER JOIN users ON users.id = ratings.user_id
WHERE genres.name = 'Sci-Fi' 
  AND users.age = 24 
  AND users.gender = 'M' 
  AND users.occupation_id = (SELECT id FROM occupations WHERE name = 'Student') 
  AND ratings.rating = 5;

-- List the unique titles of each of the movies released on the most popular release day.
SELECT title 
FROM movies 
WHERE release_date = (
    SELECT release_date 
    FROM movies 
    GROUP BY release_date 
    ORDER BY COUNT(*) DESC 
    LIMIT 1
);

-- Find the total number of movies in each genre; list the results in ascending numeric order.
SELECT genres.name, COUNT(movies.id) AS total_movies 
FROM movies 
INNER JOIN genres_movies ON genres_movies.movie_id = movies.id  
INNER JOIN genres ON genres.id = genres_movies.genre_id  
GROUP BY genres.name 
ORDER BY total_movies ASC;
