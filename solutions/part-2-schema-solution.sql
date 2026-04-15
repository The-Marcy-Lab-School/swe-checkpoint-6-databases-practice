-- part-2-schema-solution.sql
-- SOLUTION FILE — do not share with students before the assessment.

-- ============================================================
-- Step 1: Create the database and connect to it
-- ============================================================

DROP DATABASE IF EXISTS events_db;
CREATE DATABASE events_db;
\c events_db

-- ============================================================
-- Step 2: Drop tables in reverse dependency order
-- ============================================================

DROP TABLE IF EXISTS rsvps;
DROP TABLE IF EXISTS events;
DROP TABLE IF EXISTS attendees;
DROP TABLE IF EXISTS organizers;

-- ============================================================
-- Step 3: Create tables in dependency order
-- ============================================================

CREATE TABLE organizers (
  organizer_id SERIAL PRIMARY KEY,
  name         TEXT NOT NULL,
  city         TEXT NOT NULL,
  email        TEXT NOT NULL UNIQUE
);

CREATE TABLE events (
  event_id     SERIAL  PRIMARY KEY,
  title        TEXT    NOT NULL,
  description  TEXT,
  event_date   DATE    NOT NULL,
  max_capacity INTEGER NOT NULL,
  organizer_id INTEGER REFERENCES organizers(organizer_id) ON DELETE CASCADE
);

CREATE TABLE attendees (
  attendee_id SERIAL PRIMARY KEY,
  name        TEXT   NOT NULL,
  email       TEXT   NOT NULL UNIQUE
);

CREATE TABLE rsvps (
  rsvp_id     SERIAL  PRIMARY KEY,
  event_id    INTEGER REFERENCES events(event_id)      ON DELETE CASCADE,
  attendee_id INTEGER REFERENCES attendees(attendee_id) ON DELETE CASCADE,
  status      TEXT    NOT NULL DEFAULT 'confirmed',
  UNIQUE (event_id, attendee_id)
);

-- ============================================================
-- Step 4: Seed data
-- ============================================================

INSERT INTO organizers (name, city, email) VALUES
  ('Sofia Rivera', 'Brooklyn',       'sofia@events.com'),
  ('Marcus Chen',  'San Francisco',  'marcus@events.com'),
  ('Amara Osei',   'Atlanta',        'amara@events.com');

INSERT INTO events (title, description, event_date, max_capacity, organizer_id) VALUES
  ('React Workshop',       'Hands-on intro to React hooks and state management.', '2024-03-15', 30,  1),
  ('SQL Deep Dive',        'Advanced SQL: window functions, CTEs, and indexes.',  '2024-04-01', 20,  1),
  ('Intro to Python',      'Python fundamentals for beginners.',                  '2024-03-20', 25,  2),
  ('Machine Learning 101', 'Supervised learning with scikit-learn.',              '2024-04-10', 40,  2),
  ('Portfolio Review',     'Instructor feedback on student portfolios.',          '2024-05-01', 15,  2),
  ('Networking Night',     'Meet local tech professionals over dinner.',          '2024-04-20', 100, 3);

INSERT INTO attendees (name, email) VALUES
  ('Jordan Lee',    'jordan@email.com'),
  ('Priya Sharma',  'priya@email.com'),
  ('Devon Brooks',  'devon@email.com'),
  ('Kai Nakamura',  'kai@email.com'),
  ('Zoe Williams',  'zoe@email.com');

INSERT INTO rsvps (event_id, attendee_id, status) VALUES
  (1, 1, 'confirmed'),   -- React Workshop       → Jordan
  (1, 2, 'confirmed'),   -- React Workshop       → Priya
  (1, 3, 'confirmed'),   -- React Workshop       → Devon
  (2, 1, 'confirmed'),   -- SQL Deep Dive        → Jordan
  (2, 4, 'waitlisted'),  -- SQL Deep Dive        → Kai
  (3, 1, 'confirmed'),   -- Intro to Python      → Jordan
  (3, 2, 'confirmed'),   -- Intro to Python      → Priya
  (4, 1, 'confirmed'),   -- Machine Learning 101 → Jordan
  (4, 5, 'confirmed'),   -- Machine Learning 101 → Zoe
  (5, 2, 'waitlisted'),  -- Portfolio Review     → Priya
  (6, 3, 'confirmed'),   -- Networking Night     → Devon
  (6, 4, 'confirmed');   -- Networking Night     → Kai

-- ============================================================
-- Step 5: Queries
-- ============================================================

-- Question 1:
-- What events has the organizer named 'Sofia Rivera' hosted?
-- Show the event title and event date.
SELECT events.title, events.event_date
FROM events
INNER JOIN organizers ON events.organizer_id = organizers.organizer_id
WHERE organizers.name = 'Sofia Rivera';


-- Question 2:
-- Who has RSVP'd to the event titled 'React Workshop'?
-- Show the attendee's name and their RSVP status.
SELECT attendees.name, rsvps.status
FROM attendees
INNER JOIN rsvps ON attendees.attendee_id = rsvps.attendee_id
INNER JOIN events ON rsvps.event_id = events.event_id
WHERE events.title = 'React Workshop';


-- Question 3:
-- How many events has each organizer hosted?
-- Show the organizer's name and their event count.
-- Order by event count from highest to lowest.
SELECT organizers.name, COUNT(events.event_id) AS event_count
FROM organizers
LEFT JOIN events ON organizers.organizer_id = events.organizer_id
GROUP BY organizers.organizer_id
ORDER BY event_count DESC;


-- Question 4:
-- Which attendees have RSVP'd to more than 2 events?
-- Show the attendee's name and the number of events they've RSVP'd to.
SELECT attendees.name, COUNT(rsvps.event_id) AS rsvp_count
FROM attendees
INNER JOIN rsvps ON attendees.attendee_id = rsvps.attendee_id
GROUP BY attendees.attendee_id
HAVING COUNT(rsvps.event_id) > 2;


-- Question 5:
-- List every organizer alongside the total number of distinct attendees
-- across all of their events.
-- Show the organizer's name and the attendee count.
SELECT organizers.name, COUNT(DISTINCT rsvps.attendee_id) AS attendee_count
FROM organizers
LEFT JOIN events ON organizers.organizer_id = events.organizer_id
LEFT JOIN rsvps ON events.event_id = rsvps.event_id
GROUP BY organizers.organizer_id;
