-- part-1-queries.sql
-- Write your SQL query below each prompt.
--
-- Setup: run the seed file first to create music_db.
--   Mac:     psql -f part-1-setup.sql
--   Windows: sudo -u postgres psql -f part-1-setup.sql
--
-- Then connect to the database:
--   Mac:     psql music_db
--   Windows: sudo -u postgres psql music_db
--
-- You can also open this file in TablePlus and run queries from there.

-- ============================================================
-- Part 1: SELECT — Basic Reads
-- ============================================================

-- 1. Select all columns from all artists.


-- 2. Select only the title and release_year from all albums.


-- 3. Select all columns from all albums, ordered by release_year from newest to oldest.


-- ============================================================
-- Part 2: WHERE — Filtering Data
-- ============================================================

-- 4. Select all albums released after 2015.


-- 5. Select all artists from 'USA'.


-- ============================================================
-- Part 3: INSERT, UPDATE, DELETE — Modifying Data
-- ============================================================

-- 6. Insert a new artist with name 'Beyoncé' and country 'USA'.


-- 7. Update the title of the album with album_id = 9 to
--    'El Último Tour Del Mundo (Deluxe)'.


-- 8. Delete the genre with genre_id = 6.


-- ============================================================
-- Part 4: Aggregates — COUNT, GROUP BY, HAVING
-- ============================================================

-- 9. Count the total number of albums in the table.
--    Name the result column total_albums.


-- 10. Count how many albums each artist has released.
--     Show artist_id and the count. Name the count column album_count.


-- 11. Show only the artist_id values for artists who have released
--     more than 2 albums. Include the album count.
--     Name the count column album_count.

-- ============================================================
-- Part 5: JOIN Queries
-- ============================================================

-- 12. Show each album's title and its artist's name.
--     Only include albums that have a matching artist (use INNER JOIN).
--     Show title and name.


-- 13. Show all artists and their album count, including artists who have
--     released zero albums (use LEFT JOIN).
--     Show name and album_count. Order by album_count descending.


-- 14. Show the name of every genre associated with the album titled
--     'good kid, m.A.A.d city'.
--     Show only the genre name column.


-- 15. Show the title and artist name of every album in the 'reggaeton' genre.
--     Show title and name.


-- 16. Show each genre name and how many albums use it.
--     Name the count column album_count.
--     Order by album_count from highest to lowest.


-- 17. Show the title of every album that has no genres.
--     Hint: use a LEFT JOIN on album_genres and filter for NULL.
