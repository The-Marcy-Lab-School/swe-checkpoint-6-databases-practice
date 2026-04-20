-- part-1-queries-solution.sql
-- SOLUTION FILE — do not share with students before the assessment.

-- ============================================================
-- Part 1: SELECT — Basic Reads
-- ============================================================

-- 1. Select all columns from all artists.
SELECT * FROM artists;


-- 2. Select only the title and release_year from all albums.
SELECT title, release_year FROM albums;


-- 3. Select all columns from all albums, ordered by release_year from newest to oldest.
SELECT * FROM albums ORDER BY release_year DESC;


-- ============================================================
-- Part 2: WHERE — Filtering Data
-- ============================================================

-- 4. Select all albums released after 2015.
SELECT * FROM albums WHERE release_year > 2015;


-- 5. Select all artists from 'USA'.
SELECT * FROM artists WHERE country = 'USA';


-- ============================================================
-- Part 3: INSERT, UPDATE, DELETE — Modifying Data
-- ============================================================

-- 6. Insert a new artist with name 'Beyoncé' and country 'USA'.
INSERT INTO artists (name, country) VALUES ('Beyoncé', 'USA');


-- 7. Update the title of album_id = 9 to 'El Último Tour Del Mundo (Deluxe)'.
UPDATE albums
SET title = 'El Último Tour Del Mundo (Deluxe)'
WHERE album_id = 9;


-- 8. Delete the genre with genre_id = 6.
DELETE FROM genres WHERE genre_id = 6;


-- ============================================================
-- Part 4: Aggregates — COUNT, GROUP BY, HAVING
-- ============================================================

-- 9. Count the total number of albums in the table.
SELECT COUNT(*) AS total_albums FROM albums;


-- 10. Count how many albums each artist has released.
--     Show artist_id and album_count.
SELECT artist_id, COUNT(*) AS album_count
FROM albums
GROUP BY artist_id;


-- 11. Show only artists who have released more than 2 albums.
SELECT artist_id, COUNT(*) AS album_count
FROM albums
GROUP BY artist_id
HAVING COUNT(*) > 2;

-- ============================================================
-- Part 5: JOIN Queries
-- ============================================================

-- 12. Show each album's title and its artist's name.
--     Only include albums that have a matching artist (INNER JOIN).
SELECT albums.title, artists.name
FROM albums
INNER JOIN artists ON albums.artist_id = artists.artist_id;


-- 13. Show all artists and their album count, including artists who have
--     released zero albums (LEFT JOIN). Order by album_count descending.
SELECT artists.name, COUNT(albums.album_id) AS album_count
FROM artists
LEFT JOIN albums ON artists.artist_id = albums.artist_id
GROUP BY artists.artist_id
ORDER BY album_count DESC;


-- 14. Show the name of every genre associated with the album titled
--     'good kid, m.A.A.d city'.
SELECT genres.name
FROM genres
INNER JOIN album_genres ON genres.genre_id = album_genres.genre_id
INNER JOIN albums ON album_genres.album_id = albums.album_id
WHERE albums.title = 'good kid, m.A.A.d city';


-- 15. Show the title and artist name of every album in the 'reggaeton' genre.
SELECT albums.title, artists.name
FROM albums
INNER JOIN album_genres ON albums.album_id = album_genres.album_id
INNER JOIN genres ON album_genres.genre_id = genres.genre_id
INNER JOIN artists ON albums.artist_id = artists.artist_id
WHERE genres.name = 'reggaeton';


-- 16. Show each genre name and how many albums use it.
--     Order by album_count from highest to lowest.
SELECT genres.name, COUNT(album_genres.album_id) AS album_count
FROM genres
INNER JOIN album_genres ON genres.genre_id = album_genres.genre_id
GROUP BY genres.genre_id
ORDER BY album_count DESC;


-- 17. Show the title of every album that has no genres.
SELECT albums.title
FROM albums
LEFT JOIN album_genres ON albums.album_id = album_genres.album_id
WHERE album_genres.album_id IS NULL;
