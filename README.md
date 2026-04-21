# swe-checkpoint-6-databases-practice

This is a **practice checkpoint** for Mod 6 Databases. It covers the same topics and follows the same structure as the real checkpoint. Use it to build familiarity with the format, identify gaps, and practice working under timed conditions.

- [Overview](#overview)
- [Part 1: SQL Coding](#part-1-sql-coding)
  - [Setup](#setup)
  - [Schema Reference](#schema-reference)
  - [Grading: Part 1](#grading-part-1)
  - [Expected Output](#expected-output)
- [Part 2: Schema Design](#part-2-schema-design)
  - [Scenario](#scenario)
  - [Grading: Part 2 (22 pts)](#grading-part-2-22-pts)

---

## Overview

| Part               | File                       | Points |
| ------------------ | -------------------------- | ------ |
| 1 — SQL Coding     | `part-1-queries.sql`       | 30 pts |
| 2 — Schema Design  | `part-2-schema.sql`        | 22 pts |
| 3 — Short Response | `part-3-short-response.md` | 21 pts |

---

## Part 1: SQL Coding

You will write 18 SQL queries against a pre-built `music_db` database — no JavaScript involved.

### Setup

**1. Run the seed file to create and populate `music_db`:**

**Mac:**
```sh
psql -f part-1-setup.sql
```

**Windows/WSL:**
```sh
sudo -u postgres psql -f part-1-setup.sql
```

**2. Connect to the database:**

**Mac:**
```sh
psql music_db
```

**Windows/WSL:**
```sh
sudo -u postgres psql music_db
```

**3. Open `part-1-queries.sql`** and write your answer below each prompt. You can test queries directly in `psql`, or open the file in TablePlus and run them from there.

---

### Schema Reference

The `music_db` database has four tables:

```
artists
  artist_id  SERIAL PRIMARY KEY
  name       TEXT NOT NULL UNIQUE
  country    TEXT NOT NULL
  created_at TIMESTAMPTZ

albums
  album_id     SERIAL PRIMARY KEY
  title        TEXT NOT NULL
  release_year INTEGER NOT NULL
  artist_id    INTEGER REFERENCES artists(artist_id)
  created_at   TIMESTAMPTZ

genres
  genre_id SERIAL PRIMARY KEY
  name     TEXT NOT NULL UNIQUE

album_genres
  album_genre_id SERIAL PRIMARY KEY
  album_id       INTEGER REFERENCES albums(album_id)
  genre_id       INTEGER REFERENCES genres(genre_id)
  UNIQUE (album_id, genre_id)
```

**Relationships:**
- `artists` → `albums` is **one-to-many** (one artist can release many albums; each album belongs to one artist)
- `albums` ↔ `genres` is **many-to-many** via `album_genres` (an album can belong to many genres; a genre can contain many albums)

---

### Grading: Part 1

Each query is worth 1 point based on correctness. Half credit (0.5 points) is awarded for queries that use the right structure but contain minor errors.

**SELECT — Basic Reads**
- [ ] 1. Select all columns from all artists
- [ ] 2. Select only the title and release_year from all albums
- [ ] 3. Select all columns from all albums, ordered by release_year newest to oldest

**WHERE — Filtering Data**
- [ ] 4. Select all albums released after 2015
- [ ] 5. Select all artists from 'USA'

**INSERT, UPDATE, DELETE — Modifying Data**
- [ ] 6. Insert a new artist with name 'Beyoncé' and country 'USA'
- [ ] 7. Update the title of album_id = 9 to 'El Último Tour Del Mundo (Deluxe)'
- [ ] 8. Delete the genre with genre_id = 6

**Aggregates — COUNT, GROUP BY, HAVING**
- [ ] 9. Count the total number of album
- [ ] 10. Count albums per artist; show artist_id and album_count
- [ ] 11. Show only artists who have released more than 2 albums

**JOIN Queries**
- [ ] 12. Show each album's title and its artist's name using INNER JOI
- [ ] 13. Show all artists and their album count, including zero-album artists, using LEFT JOIN
- [ ] 14. Show all genre names for the album 'good kid, m.A.A.d city'
- [ ] 15. Show the title and artist name of every album in the 'reggaeton' genre
- [ ] 16. Show each genre name and how many albums use it, ordered by count descending
- [ ] 17. Show the title of every album that has no genres

---

### Expected Output

**<details><summary>1. All artists (6 rows)</summary>**

| artist_id | name           | country     | created_at          |
| --------- | -------------- | ----------- | ------------------- |
| 1         | Kendrick Lamar | USA         | 2024-01-05 09:00:00 |
| 2         | Adele          | UK          | 2024-01-12 10:00:00 |
| 3         | Bad Bunny      | Puerto Rico | 2024-01-20 11:00:00 |
| 4         | Tame Impala    | Australia   | 2024-02-01 09:30:00 |
| 5         | Mitski         | USA         | 2024-02-15 14:00:00 |
| 6         | Stromae        | Belgium     | 2024-03-01 16:00:00 |

</details>

**<details><summary>2. Title and release_year from all albums (12 rows)</summary>**

| title                    | release_year |
| ------------------------ | ------------ |
| Section.80               | 2011         |
| good kid, m.A.A.d city   | 2012         |
| To Pimp a Butterfly      | 2015         |
| DAMN.                    | 2017         |
| 21                       | 2011         |
| 25                       | 2015         |
| 30                       | 2021         |
| YHLQMDLG                 | 2020         |
| El Último Tour Del Mundo | 2020         |
| Un Verano Sin Ti         | 2022         |
| Currents                 | 2015         |
| The Slow Rush            | 2020         |

</details>

**<details><summary>3. All albums ordered by release_year newest to oldest (12 rows)</summary>**

| album_id | title                    | release_year | created_at          |
| -------- | ------------------------ | ------------ | ------------------- |
| 10       | Un Verano Sin Ti         | 2022         | 2024-03-15 13:00:00 |
| 7        | 30                       | 2021         | 2024-03-05 14:00:00 |
| 8        | YHLQMDLG                 | 2020         | 2024-02-08 09:00:00 |
| 9        | El Último Tour Del Mundo | 2020         | 2024-02-25 11:00:00 |
| 12       | The Slow Rush            | 2020         | 2024-04-01 09:00:00 |
| 4        | DAMN.                    | 2017         | 2024-02-20 12:00:00 |
| 3        | To Pimp a Butterfly      | 2015         | 2024-02-02 11:00:00 |
| 6        | 25                       | 2015         | 2024-02-10 10:30:00 |
| 11       | Currents                 | 2015         | 2024-03-10 10:00:00 |
| 2        | good kid, m.A.A.d city   | 2012         | 2024-01-18 10:00:00 |
| 1        | Section.80               | 2011         | 2024-01-10 09:00:00 |
| 5        | 21                       | 2011         | 2024-01-22 09:00:00 |

Note: rows with the same release_year may appear in a different order — that's okay.

</details>

**<details><summary>4. Albums released after 2015 (5 rows)</summary>**

Note: order may vary.

| album_id | title                    | release_year | artist_id | created_at          |
| -------- | ------------------------ | ------------ | --------- | ------------------- |
| 4        | DAMN.                    | 2017         | 1         | 2024-02-20 12:00:00 |
| 7        | 30                       | 2021         | 2         | 2024-03-05 14:00:00 |
| 8        | YHLQMDLG                 | 2020         | 3         | 2024-02-08 09:00:00 |
| 9        | El Último Tour Del Mundo | 2020         | 3         | 2024-02-25 11:00:00 |
| 10       | Un Verano Sin Ti         | 2022         | 3         | 2024-03-15 13:00:00 |
| 12       | The Slow Rush            | 2020         | 4         | 2024-04-01 09:00:00 |

</details>

**<details><summary>5. Artists from 'USA' (2 rows)</summary>**

| artist_id | name           | country | created_at          |
| --------- | -------------- | ------- | ------------------- |
| 1         | Kendrick Lamar | USA     | 2024-01-05 09:00:00 |
| 5         | Mitski         | USA     | 2024-02-15 14:00:00 |

</details>

**<details><summary>6. After inserting 'Beyoncé'</summary>**

You should see: `INSERT 0 1`

Run `SELECT * FROM artists;` to verify — you should see 7 rows with Beyoncé appearing last (artist_id = 7).

</details>

**<details><summary>7. After updating album_id = 9</summary>**

You should see: `UPDATE 1`

Run `SELECT * FROM albums WHERE album_id = 9;` to verify the title reads `El Último Tour Del Mundo (Deluxe)`.

</details>

**<details><summary>8. After deleting genre_id = 6</summary>**

You should see: `DELETE 1`

Run `SELECT * FROM genres;` to verify — you should see 5 rows and `conscious rap` should be gone.

</details>

**<details><summary>9. Total number of albums (1 row)</summary>**

| total_albums |
| ------------ |
| 12           |

</details>

**<details><summary>10. Album count per artist (4 rows)</summary>**

Note: order may vary.

| artist_id | album_count |
| --------- | ----------- |
| 1         | 4           |
| 2         | 3           |
| 3         | 3           |
| 4         | 2           |

</details>

**<details><summary>11. Artists with more than 2 albums (3 rows)</summary>**

Note: order may vary.

| artist_id | album_count |
| --------- | ----------- |
| 1         | 4           |
| 2         | 3           |
| 3         | 3           |

</details>

**<details><summary>12. Album titles with artist names — INNER JOIN (12 rows)</summary>**

Note: order may vary.

| title                    | name           |
| ------------------------ | -------------- |
| Section.80               | Kendrick Lamar |
| good kid, m.A.A.d city   | Kendrick Lamar |
| To Pimp a Butterfly      | Kendrick Lamar |
| DAMN.                    | Kendrick Lamar |
| 21                       | Adele          |
| 25                       | Adele          |
| 30                       | Adele          |
| YHLQMDLG                 | Bad Bunny      |
| El Último Tour Del Mundo | Bad Bunny      |
| Un Verano Sin Ti         | Bad Bunny      |
| Currents                 | Tame Impala    |
| The Slow Rush            | Tame Impala    |

</details>

**<details><summary>13. All artists with album count — LEFT JOIN (6 rows)</summary>**

| name           | album_count |
| -------------- | ----------- |
| Kendrick Lamar | 4           |
| Adele          | 3           |
| Bad Bunny      | 3           |
| Tame Impala    | 2           |
| Mitski         | 0           |
| Beyoncé        | 0           |
| Stromae        | 0           |

</details>

**<details><summary>14. Genres for 'good kid, m.A.A.d city' (2 rows)</summary>**

Note: order may vary. This reflects the removal of the "conscious rap" genre.

| name    |
| ------- |
| hip-hop |
| r&b     |

</details>

**<details><summary>15. Albums in the 'reggaeton' genre (3 rows)</summary>**

Note: order may vary.

| title                    | name      |
| ------------------------ | --------- |
| YHLQMDLG                 | Bad Bunny |
| El Último Tour Del Mundo | Bad Bunny |
| Un Verano Sin Ti         | Bad Bunny |

</details>

**<details><summary>16. Genre names with album counts (5 rows)</summary>**

Note: rows with the same count may appear in a different order — that's okay. Also, the "conscious rap" genre was removed in problem 8.

| name             | album_count |
| ---------------- | ----------- |
| hip-hop          | 4           |
| r&b              | 4           |
| pop              | 3           |
| reggaeton        | 3           |
| psychedelic rock | 1           |

</details>

**<details><summary>17. Albums with no genres (1 row)</summary>**

| title         |
| ------------- |
| The Slow Rush |

</details>

---

## Part 2: Schema Design

Open `part-2-schema.sql` and complete both parts: design the schema and write the 5 queries.

### Scenario

You are building a database for a **community events platform**. Here is what you need to store:

- The platform has **organizers**. Each organizer has a name, a city, and an email.
- Each organizer can host many **events**. Each event belongs to exactly one organizer and has a title, a description, an event date, and a max capacity.
- Events have **attendees**. An attendee has a name and an email. An attendee can RSVP to many events, and a single event can have many attendees. The link between an event and an attendee also stores an RSVP **status** (e.g. `'confirmed'`, `'waitlisted'`).

Your schema must represent:
- A **one-to-many** relationship between organizers and events
- A **many-to-many** relationship between events and attendees, via an association table

### Grading: Part 2 (22 pts)

**Setup (3 pts)**
- [ ] Tables are dropped in reverse-dependency order before they are created
- [ ] Tables are created in dependency order
- [ ] When running the file a second time, the database and tables are dropped and recreated cleanly

**Table Structure (8 pts)**
- [ ] Every table has a primary key column with auto-incrementing integer values. The primary key column is named after the table (e.g. `organizer_id`)
- [ ] All columns have appropriate data types
- [ ] At least two columns across the schema have `NOT NULL` constraints
- [ ] Foreign key columns properly reference the primary key of their dependent table

**Relationships (4 pts)**
- [ ] The one-to-many relationship (organizers → events) is represented with a foreign key column on the child table
- [ ] The many-to-many relationship (events ↔ attendees) is represented with a dedicated association table
- [ ] The association table has a `UNIQUE (col1, col2)` constraint on its two foreign key columns
- [ ] The association table includes a `status` column with an appropriate data type

**Seed Data (2 pts)**
- [ ] At least 3 rows are inserted into each table with realistic, consistent data

**Queries (5 pts)**
- [ ] Q1: Events by a specific organizer — title and event date
- [ ] Q2: Attendees for a specific event — name and RSVP status
- [ ] Q3: Event count per organizer, ordered by count descending
- [ ] Q4: Attendees who have RSVP'd to more than 2 events

**Bonus**
- [ ] Each organizer with a count of distinct attendees across all their events
