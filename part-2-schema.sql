-- part-2-schema.sql
-- Practice: Schema Design
--
-- Scenario: A community events platform.
--   - The platform has organizers. Each organizer has a name, a city, and an email.
--   - Each organizer can host many events. Each event belongs to exactly one organizer
--     and has a title, a description, an event date, and a max capacity.
--   - Events have attendees. An attendee has a name and an email.
--     An attendee can RSVP to many events, and a single event can have many attendees.
--     The link between an event and an attendee also stores an RSVP status
--     (e.g. 'confirmed', 'waitlisted').
--
-- Your task:
--   Part 1 — Design the schema. Write DROP, CREATE, and INSERT statements below.
--   Part 2 — Write SQL queries to answer the 5 questions at the bottom of this file.
--
-- Run your file to verify it works without errors:
--   Mac:     psql -f part-2-schema.sql
--   Windows: sudo -u postgres psql -f part-2-schema.sql
--
-- Run it a second time to confirm it still works cleanly.

-- ============================================================
-- Step 1: Create the database and connect to it
-- ============================================================

DROP DATABASE IF EXISTS events_db;
CREATE DATABASE events_db;
\c events_db

-- ============================================================
-- Step 2: Drop tables in reverse dependency order
-- (most dependent first, so foreign key constraints aren't violated)
-- ============================================================



-- ============================================================
-- Step 3: Create tables in dependency order
-- (parent tables first, then tables that reference them)
--
-- Requirements:
--   [ ] Every table has a SERIAL PRIMARY KEY named after the table (e.g. organizer_id)
--   [ ] All columns have appropriate data types
--   [ ] Foreign key columns use REFERENCES other_table(other_table_id)
--   [ ] The association table has UNIQUE (col1, col2) on its two foreign key columns
--   [ ] At least two columns across the schema have NOT NULL constraints
-- ============================================================



-- ============================================================
-- Step 4: Seed each table with at least 3 rows of realistic data
-- ============================================================



-- ============================================================
-- Step 5: Write queries to answer each question below
-- ============================================================

-- Question 1:
-- What events has the organizer named 'Sofia Rivera' hosted?
-- Show the event title and event date.


-- Question 2:
-- Who has RSVP'd to the event titled 'React Workshop'?
-- Show the attendee's name and their RSVP status.


-- Question 3:
-- How many events has each organizer hosted?
-- Show the organizer's name and their event count.
-- Order by event count from highest to lowest.


-- Question 4:
-- Which attendees have RSVP'd to more than 2 events?
-- Show the attendee's name and the number of events they've RSVP'd to.


-- Question 5:
-- List every organizer alongside the total number of distinct attendees
-- across all of their events.
-- Show the organizer's name and the attendee count.
