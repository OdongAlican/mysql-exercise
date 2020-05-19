/*
1.List the films where the yr is 1962 [Show id, title]
*/

SELECT id, title
FROM movie
WHERE yr=1962

/*
2.Give year of 'Citizen Kane'.
*/

SELECT yr FROM movie WHERE title = 'Citizen Kane'

/*
3.List all of the Star Trek movies, include the id, 
title and yr (all of these movies include the words Star Trek in the title). Order results by year.
*/

SELECT id, title, yr FROM movie WHERE title LIKE '%Star Trek%'

/*
4.What id number does the actor 'Glenn Close' have?
*/

SELECT id FROM actor WHERE name = 'Glenn Close' 

/*
5.What is the id of the film 'Casablanca'
*/

SELECT id FROM movie WHERE title = 'Casablanca' 

/*
6.Obtain the cast list for 'Casablanca'.

Use movieid=11768, (or whatever value you got from the previous question)
*/

SELECT name FROM actor JOIN casting ON(id=actorid) WHERE movieid = 27 GROUP BY name 

/*
7.Obtain the cast list for the film 'Alien'
*/

SELECT name FROM actor JOIN casting ON (actor.id = actorid) 
WHERE movieid IN  (SELECT movieid FROM movie JOIN casting ON (movie.id = movieid) 
WHERE title = 'Alien')

/*
8.List the films in which 'Harrison Ford' has appeared
*/

SELECT title FROM movie JOIN casting 
ON (movie.id = movieid) WHERE actorid IN 
(SELECT actorid FROM casting JOIN actor ON (actorid = actor.id) WHERE name = 'Harrison Ford') 

/*
9.List the films where 'Harrison Ford' has appeared - 
but not in the starring role. [Note: the ord field of 
casting gives the position of the actor. If ord=1 then this actor is in the starring role]
*/

SELECT title FROM movie JOIN casting 
ON (movie.id = movieid) WHERE movieid IN 
(SELECT movieid FROM casting JOIN actor ON (actorid = actor.id) 
WHERE name = 'Harrison Ford' and ord != 1) GROUP BY title

/*
10.List the films together with the leading star for all 1962 films.
*/

SELECT movie.title, actor.name FROM movie 
INNER JOIN casting ON casting.movieid = movie.id 
INNER JOIN actor ON casting.actorid = actor.id WHERE movie.yr = '1962' AND casting.ord = 1

/*
11.Which were the busiest years for 'Rock Hudson', 
show the year and the number of movies he made 
each year for any year in which he made more than 2 movies.
*/

SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Doris Day'
GROUP BY yr
HAVING COUNT(title) > 1

/*
12.List the film title and the leading actor for all of the films 'Julie Andrews' played in.
*/

SELECT title, name FROM movie JOIN casting 
ON (movieid=movie.id AND ord=1) JOIN actor ON (actorid=actor.id) 
WHERE movie.id IN (SELECT movieid FROM casting 
WHERE actorid IN (SELECT id FROM actor WHERE name='Julie Andrews'))

/*
13.Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.
*/

SELECT name
FROM actor
JOIN casting ON (id = actorid AND (SELECT COUNT(ord) 
FROM casting WHERE actorid = actor.id AND ord=1)>=15)
GROUP BY name

/*
14.List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
*/

SELECT title, COUNT(actorid) as cast
FROM movie JOIN casting on id=movieid
WHERE yr = 1978
GROUP BY title
ORDER BY cast DESC, title

/*
15.List all the people who have worked with 'Art Garfunkel'.
*/

SELECT movie.id FROM movie JOIN casting 
ON(casting.movieid=movie.id) JOIN actor 
ON (casting.actorid=actor.id) WHERE actor.name = 'Art Garfunkel' 