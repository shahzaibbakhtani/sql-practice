select * from SQLMDB.countries;

SELECT COUNT(*) AS disney_studio_count
FROM sqlmdb.studios
WHERE studio_name LIKE '%Disney%';

SELECT movie_title, release_year, COUNT(*) AS tagline_count
FROM
    sqlmdb.movies
    INNER JOIN sqlmdb.taglines
        USING (movie_guid)
GROUP BY movie_guid, movie_title, release_year
ORDER BY COUNT(*) DESC
FETCH FIRST 5 ROWS ONLY;


SELECT COUNT(*) AS high_metascore_count
FROM sqlmdb.critic_reviews
WHERE metascore >= 80;


SELECT movie_title, release_year, imdb_rating
FROM
    sqlmdb.movies m
    INNER JOIN sqlmdb.movie_genres mg
        ON m.movie_guid = mg.movie_guid
WHERE
    (mg.genre_code = 'ACT') AND
    (imdb_rating IS NOT NULL)
ORDER BY imdb_rating DESC
FETCH FIRST 5 ROWS ONLY;


SELECT movie_title, release_year, imdb_rating
FROM sqlmdb.movies
WHERE imdb_rating IS NOT NULL
ORDER BY imdb_rating DESC
FETCH FIRST 5 ROWS ONLY;



SELECT COUNT(*) AS bad_title_count
FROM sqlmdb.movies
WHERE UPPER(movie_title) LIKE '%BAD%';


SELECT COUNT(*) AS bad_title_count
FROM sqlmdb.movies
WHERE UPPER(movie_title) LIKE '%BAD%';


SELECT COUNT(*) AS actor_and_director_count
FROM (
    SELECT person_guid
    FROM sqlmdb.movie_actors
    INTERSECT
    SELECT person_guid
    FROM sqlmdb.movie_jobs
    WHERE job_code = 'DRTR'
);


SELECT ROUND(AVG(imdb_rating), 1) AS avg_rating_1960s
FROM sqlmdb.movies
WHERE release_year BETWEEN 1960 AND 1969;


SELECT COUNT(*) AS near_perfect_count
FROM
    sqlmdb.movies
    INNER JOIN sqlmdb.critic_reviews
        USING (movie_guid)
    INNER JOIN sqlmdb.rotten_tomatoes
        USING (movie_guid)
WHERE
    (metascore >= 99) AND
    (tomatometer >= 99);




SELECT
    p.person_name,
    COUNT(*) AS credit_count
FROM
    sqlmdb.movie_actors ma
    INNER JOIN sqlmdb.movies m
        ON ma.movie_guid = m.movie_guid
    INNER JOIN sqlmdb.persons p
        ON ma.person_guid = p.person_guid
WHERE
    m.release_year BETWEEN 1990 AND 1999
GROUP BY p.person_name
ORDER BY COUNT(*) DESC
FETCH FIRST 3 ROWS ONLY;



SELECT ROUND(AVG(movie_count), 1) AS avg_movies_per_studio
FROM (
    SELECT studio_guid, COUNT(*) AS movie_count
    FROM sqlmdb.movie_studios
    GROUP BY studio_guid
);


SELECT ROUND(AVG(cr.metascore), 2) AS avg_metascore
FROM
    sqlmdb.movies m
    INNER JOIN sqlmdb.movie_actors ma
        ON m.movie_guid = ma.movie_guid
    INNER JOIN sqlmdb.persons p
        ON ma.person_guid = p.person_guid
    INNER JOIN sqlmdb.critic_reviews cr
        ON m.movie_guid = cr.movie_guid
WHERE
    p.person_name = 'Tom Hanks';
    
    
SELECT COUNT(*) AS worse_remake_count
FROM
    sqlmdb.movies m1
    INNER JOIN sqlmdb.movies m2
        ON m1.remake_guid = m2.movie_guid
WHERE
    m1.imdb_rating < m2.imdb_rating;
    
    
    
SELECT
    p.person_name,
    COUNT(*) AS total_films
FROM
    sqlmdb.movie_actors ma
    INNER JOIN sqlmdb.persons p
        ON ma.person_guid = p.person_guid
WHERE
    ma.person_guid IN (
        SELECT ma2.person_guid
        FROM sqlmdb.movie_actors ma2
        WHERE ma2.movie_guid IN (
            SELECT movie_guid
            FROM sqlmdb.movies
            WHERE imdb_rating IS NOT NULL
            ORDER BY imdb_rating DESC, imdb_votes DESC
            FETCH FIRST 20 ROWS ONLY
        )
    )
GROUP BY p.person_name
ORDER BY COUNT(*) DESC
FETCH FIRST 5 ROWS ONLY;



SELECT * FROM books WHERE genre = 'Horror' OR genre = 'True Crime';





SELECT
    person_name,
    COUNT(*) AS movie_tally,
    SUM(worldwide_gross) AS sum_worldwide_gross,
    MAX(worldwide_gross) AS max_worldwide_gross,
    ROUND(MAX(worldwide_gross) / SUM(worldwide_gross) * 100, 1) AS pct_contribution
FROM
    sqlmdb.persons
    INNER JOIN sqlmdb.movie_actors
        USING (person_guid)
    INNER JOIN sqlmdb.movies
        USING (movie_guid)
WHERE
    worldwide_gross IS NOT NULL
GROUP BY person_guid, person_name
HAVING COUNT(*) > 9
ORDER BY pct_contribution DESC
FETCH FIRST 5 ROWS ONLY;