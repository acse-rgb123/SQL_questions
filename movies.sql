use movielens;

-- I HAVENT DONE THIS NICELY YET SO I WILL POST AFTER ITS NICE

-- List the titles and release dates of movies released between 1983-1993 in reverse chronological order.
select title, release_date from movies where release_date > '1982-12-31' and release_date < '1994-01-01' order by release_date desc;

-- Without using LIMIT, list the titles of the movies with the lowest average rating.
select title from movies left join ratings on movies.id = ratings.id where ratings.rating = 1;

-- List the unique records for Sci-Fi movies where male 24-year-old students have given 5-star ratings.
select title from movies inner join genres_movies on genres_movies.movie_id = movies.id inner join genres on genres.id = genres_movies.genre_id inner join ratings on ratings.movie_id = movies.id inner join users on users.id = ratings.user_id
where users.age > 24 and ratings.rating = 5;

-- List the unique titles of each of the movies released on the most popular release day.
select title from movies where release_date = (select release_date from movies group by release_date order by count(*) desc limit 1);

-- Find the total number of movies in each genre; list the results in ascending numeric order.
select * from movies inner join genres_movies on genres_movies.movie_id = movies.id inner join genres on genres.id = genres_movies.genre_id group by genres.name;