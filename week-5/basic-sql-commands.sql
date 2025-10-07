-- Create table 'users' with predefined fields
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Show all tables in the current database
-- (Use this inside psql CLI)
\dt

-- Or, if running as SQL:
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';

-- Get more details about the 'users' table
-- (Use this inside psql CLI)
\d users

-- Or, as SQL query:
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_name = 'users';

-- Insert data into 'users' table
INSERT INTO users (email, name)
VALUES
  ('rpursotam@gmail.com', 'rahul'),
  ('test1@gmail.com', 'pursotam'),
  ('test2@gmail.com', 'raj');

-- Show all users
SELECT id, email FROM users;

-- Conditionally pick rows from table
SELECT id, email
FROM users
WHERE email = 'test@gmail.com';

-- Pick rows that match a particular pattern
-- % = zero, one, or multiple characters
-- _ = single character
SELECT id, email
FROM users
WHERE email LIKE 'test%.co%';

-- Update a particular row that matches the condition
UPDATE users
SET email = 'test2@test.com'
WHERE name = 'raj';

-- Delete particular users from the table
DELETE FROM users
WHERE email LIKE '%test%';

-- Alter the table to add more columns
ALTER TABLE users
ADD COLUMN last_name VARCHAR(30) DEFAULT NULL,
ADD COLUMN age INT DEFAULT 18;
