-- In Application logic code if everything is OK we call ""COMMIT"" ,
-- else if anything fails or error in app code logic then we "ROLLBACK"

--  Transaction BEGIN
BEGIN;

UPDATE users SET balance = balance - 500 WHERE email = 'alice@example.com';
UPDATE users SET balance = balance + 500 WHERE email = 'bob@example.com';

COMMIT;
-- Transaction COMMIT

--  Transaction BEGIN
BEGIN;

UPDATE users SET balance = balance - 500 WHERE email = 'alice@example.com';
UPDATE users SET balance = balance + 500 WHERE email = 'bob@example.com';

ROLLBACK;
-- Transaction ROLLBACK
