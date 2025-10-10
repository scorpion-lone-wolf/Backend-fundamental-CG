--  ENUMS used
CREATE TYPE CURRENCY AS ENUM ('IND', 'USD', 'YEN');

-- users table
-- This basically hold all the info about users. We could create profile table as well to store more data about user , but this will work fo now.
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    hash_pass VARCHAR(100) NOT NULL,
    profile_pic_url VARCHAR(255),
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMPTZ
);

-- plan table
-- This table holds all the plain availabe in our platform. We assume all plans are for 1 months
CREATE TABLE plans (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    price DECIMAL(5,2) NOT NULL,
    currency_type CURRENCY NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- subscriptions table
-- This table is a junction between plans and users. Which user has which plain subscribed.
CREATE TABLE subscriptions (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    plan_id INT NOT NULL REFERENCES plans(id),
    started_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    end_at TIMESTAMPTZ,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);
-- ENFORCE ONE ACTIVE SUBSCRIPTION PER USER
CREATE UNIQUE INDEX unique_active_subscription_per_user
ON subscriptions (user_id)
WHERE is_active = true;

-- movies table
-- genres table
-- series table
-- episodes table

