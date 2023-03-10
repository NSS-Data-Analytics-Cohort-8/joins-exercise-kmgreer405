-- ** Movie Database project. See the file movies_erd for table\column info. **

-- 1. Give the name, release year, and worldwide gross of the lowest grossing movie.
SELECT film_title, release_year, worldwide_gross AS min_gross
FROM specs
	INNER JOIN revenue
	ON specs.movie_id = revenue.movie_id
ORDER BY worldwide_gross ASC
LIMIT 1;

--Lowest grossing movie worldwide is "Semi-Tough" released in 1977 with a gross of 37,187,139

-- 2. What year has the highest average imdb rating?
SELECT release_year, ROUND(AVG(imdb_rating), 2) AS avg_imdb
FROM specs
	INNER JOIN rating
	ON specs.movie_id = rating.movie_id
GROUP BY release_year
ORDER BY AVG(imdb_rating) DESC
LIMIT 1;

--1991 has the highest average imdb rating at 7.45

-- 3. What is the highest grossing G-rated movie? Which company distributed it?
SELECT film_title, mpaa_rating, company_name, worldwide_gross AS max_gross
FROM specs
	INNER JOIN distributors
	ON specs.domestic_distributor_id = 		distributors.distributor_id
	INNER JOIN revenue
	ON specs.movie_id = revenue.movie_id
WHERE mpaa_rating = 'G'
ORDER BY worldwide_gross DESC
LIMIT 1;

--"Toy Story 4" is the highest grossing G rated film at 1,073,394,593. Released by Walt Disney.

-- 4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.
SELECT company_name, COUNT(film_title) AS num_of_films
FROM distributors
	LEFT JOIN specs
	ON distributor_id = domestic_distributor_id
GROUP BY company_name
ORDER BY COUNT(film_title);

SELECT COUNT(*)
FROM distributors;

-- 5. Write a query that returns the five distributors with the highest average movie budget.
SELECT company_name, AVG(film_budget) AS avg_film_budget
FROM specs
	INNER JOIN distributors
	ON domestic_distributor_id = distributor_id
	INNER JOIN revenue
	ON specs.movie_id = revenue.movie_id
GROUP BY company_name
ORDER BY AVG(film_budget) DESC
LIMIT 5;


-- 6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?
SELECT company_name, headquarters, film_title, imdb_rating
FROM distributors
	LEFT JOIN specs
	ON distributor_id = domestic_distributor_id
	INNER JOIN rating
	ON specs.movie_id = rating.movie_id
WHERE headquarters NOT LIKE '%, CA'
ORDER BY imdb_rating DESC;

SELECT *
FROM distributors;

--2 films. "Dirty Dancing" has the highest imdb rating of these two films at 7.0. 

-- 7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?
SELECT ROUND(AVG(imdb_rating), 2)
FROM specs
	INNER JOIN rating
	ON specs.movie_id = rating.movie_id
WHERE length_in_min > 120
UNION
SELECT ROUND(AVG(imdb_rating), 2)
FROM specs
	INNER JOIN rating
	ON specs.movie_id = rating.movie_id
WHERE length_in_min < 120;

--Movies longer than 2 hours have a higher rating at 7.26 compared to 6.92 for less than 2 hours. 




