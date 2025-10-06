-- Create table users with predefined fields
CREATE TABLE users (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Show all the tables in that database
SHOW TABLES;

-- Get more data about the table
DESCRIBE users;

-- Insert data into users TABLES
INSERT INTO users (email, name)
VALUES ('rpursotam@gmail.com', 'rahul');

INSERT INTO users (email, name)
VALUES ('test1@gmail.com', 'pursotam');

INSERT INTO users (email, name)
VALUES ('test2@gmail.com', 'raj');

-- Show all users
SELECT  id , email FROM users;

-- Conditionally picking rows from table
SELECT id ,email
FROM users
WHERE (
    email = 'test@gmail.com'
);

--  picking rows that have particular pattern
-- % = zero , one or multiple character
-- _ = one single character
SELECT id ,email
FROM users
WHERE (
    email LIKE 'test%.co%'
);

-- Update the particular row which matches the condition
UPDATE users
SET email = 'test2@test.com'
where (
    name = "raj"
);

-- delete particualr user from users table
DELETE FROM users
WHERE (
    email LIKE '%test%'
);

-- alter the table = add more columns to the predefined table
-- ADD COLUMN , RENAME COLUMN, DROP COLUMN
-- TO change the data type MODIFY COLUMN
ALTER TABLE users
ADD COLUMN (
    last_name VARCHAR(30) DEFAULT NULL ,
    age INT DEFAULT 18
);

