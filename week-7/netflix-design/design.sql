-- ENUMS used
CREATE TYPE CURRENCY AS ENUM ('IND', 'USD', 'YEN');

-- users table
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

-- plans table
-- Holds all available plans on the platform. Each plan is monthly.
CREATE TABLE plans (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    currency_type CURRENCY NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- subscriptions table
-- Maps which user has which plan subscribed.
CREATE TABLE subscriptions (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    plan_id INT NOT NULL REFERENCES plans(id),
    started_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    end_at TIMESTAMPTZ,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    CHECK (end_at IS NULL OR end_at > started_at)
);

-- Enforce one active subscription per user
CREATE UNIQUE INDEX unique_active_subscription_per_user
ON subscriptions (user_id)
WHERE is_active = true;

-- movies table
CREATE TABLE movies (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    duration_minutes INT NOT NULL CHECK (duration_minutes > 0),
    content_url VARCHAR(255) NOT NULL,
    released_year SMALLINT CHECK (released_year >= 1900 AND released_year <= EXTRACT(YEAR FROM CURRENT_DATE) + 1),
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- genres table
CREATE TABLE genres (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- junction table: movies <-> genres (many-to-many)
CREATE TABLE genres_movie (
    genres_id INT NOT NULL REFERENCES genres(id) ON DELETE CASCADE,
    movie_id INT NOT NULL REFERENCES movies(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (genres_id, movie_id)
);

-- series table
CREATE TABLE series (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    avg_duration_minutes INT CHECK (avg_duration_minutes > 0),
    released_year SMALLINT CHECK (released_year >= 1900 AND released_year <= EXTRACT(YEAR FROM CURRENT_DATE) + 1),
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- episodes table
CREATE TABLE episodes (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    duration_minutes INT NOT NULL CHECK (duration_minutes > 0),
    series_id INT NOT NULL REFERENCES series(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- junction table: series <-> genres (many-to-many)
CREATE TABLE genres_series (
    genres_id INT NOT NULL REFERENCES genres(id) ON DELETE CASCADE,
    series_id INT NOT NULL REFERENCES series(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (genres_id, series_id)
);
