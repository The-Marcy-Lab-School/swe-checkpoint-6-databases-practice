DROP DATABASE IF EXISTS music_db;
CREATE DATABASE music_db;
\c music_db

CREATE TABLE artists (
  artist_id  SERIAL      PRIMARY KEY,
  name       TEXT        NOT NULL UNIQUE,
  country    TEXT        NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE albums (
  album_id     SERIAL      PRIMARY KEY,
  title        TEXT        NOT NULL,
  release_year INTEGER     NOT NULL,
  artist_id    INTEGER     REFERENCES artists(artist_id) ON DELETE CASCADE,
  created_at   TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE genres (
  genre_id SERIAL PRIMARY KEY,
  name     TEXT   NOT NULL UNIQUE
);

CREATE TABLE album_genres (
  album_genre_id SERIAL  PRIMARY KEY,
  album_id       INTEGER REFERENCES albums(album_id)  ON DELETE CASCADE,
  genre_id       INTEGER REFERENCES genres(genre_id)  ON DELETE CASCADE,
  UNIQUE (album_id, genre_id)
);

INSERT INTO artists (name, country, created_at) VALUES
  ('Kendrick Lamar', 'USA',           '2024-01-05 09:00:00'),
  ('Adele',          'UK',            '2024-01-12 10:00:00'),
  ('Bad Bunny',      'Puerto Rico',   '2024-01-20 11:00:00'),
  ('Tame Impala',    'Australia',     '2024-02-01 09:30:00'),
  ('Mitski',         'USA',           '2024-02-15 14:00:00'),
  ('Stromae',        'Belgium',       '2024-03-01 16:00:00');

INSERT INTO albums (title, release_year, artist_id, created_at) VALUES
  ('Section.80',                    2011, 1, '2024-01-10 09:00:00'),
  ('good kid, m.A.A.d city',        2012, 1, '2024-01-18 10:00:00'),
  ('To Pimp a Butterfly',           2015, 1, '2024-02-02 11:00:00'),
  ('DAMN.',                         2017, 1, '2024-02-20 12:00:00'),
  ('21',                            2011, 2, '2024-01-22 09:00:00'),
  ('25',                            2015, 2, '2024-02-10 10:30:00'),
  ('30',                            2021, 2, '2024-03-05 14:00:00'),
  ('YHLQMDLG',                      2020, 3, '2024-02-08 09:00:00'),
  ('El Último Tour Del Mundo',      2020, 3, '2024-02-25 11:00:00'),
  ('Un Verano Sin Ti',              2022, 3, '2024-03-15 13:00:00'),
  ('Currents',                      2015, 4, '2024-03-10 10:00:00'),
  ('The Slow Rush',                 2020, 4, '2024-04-01 09:00:00');

INSERT INTO genres (name) VALUES
  ('hip-hop'),
  ('pop'),
  ('r&b'),
  ('reggaeton'),
  ('psychedelic rock'),
  ('conscious rap');

INSERT INTO album_genres (album_id, genre_id) VALUES
  (1,  1),  -- Section.80              → hip-hop
  (1,  6),  -- Section.80              → conscious rap
  (2,  1),  -- good kid, m.A.A.d city → hip-hop
  (2,  3),  -- good kid, m.A.A.d city → r&b
  (2,  6),  -- good kid, m.A.A.d city → conscious rap
  (3,  1),  -- To Pimp a Butterfly    → hip-hop
  (3,  3),  -- To Pimp a Butterfly    → r&b
  (3,  6),  -- To Pimp a Butterfly    → conscious rap
  (4,  1),  -- DAMN.                  → hip-hop
  (4,  6),  -- DAMN.                  → conscious rap
  (5,  2),  -- 21                     → pop
  (5,  3),  -- 21                     → r&b
  (6,  2),  -- 25                     → pop
  (6,  3),  -- 25                     → r&b
  (7,  2),  -- 30                     → pop
  (8,  4),  -- YHLQMDLG               → reggaeton
  (9,  4),  -- El Último Tour Del Mundo → reggaeton
  (10, 4),  -- Un Verano Sin Ti       → reggaeton
  (11, 5);  -- Currents               → psychedelic rock
  -- album 12 (The Slow Rush) intentionally has no genres
