-- =========================================================
-- 📘 PostgreSQL Example: RANGE PARTITIONING
-- Table: t1
-- Column used for partitioning: year_col
-- =========================================================


-- Step 1️⃣: Create the main (parent) table
-- ----------------------------------------
-- This table defines the schema and declares that
-- it will be partitioned by RANGE on year_col.

CREATE TABLE t1 (
  id INT,
  year_col INT
)
PARTITION BY RANGE (year_col);


-- Step 2️⃣: Create partitions (child tables)
-- ------------------------------------------
-- Each partition holds a specific range of years.

-- Partition p0: for all years < 1991
CREATE TABLE t1_p0 PARTITION OF t1
FOR VALUES FROM (MINVALUE) TO (1991);

-- Partition p1: for years 1991 - 1994
CREATE TABLE t1_p1 PARTITION OF t1
FOR VALUES FROM (1991) TO (1995);

-- Partition p2: for years 1995 - 1998
CREATE TABLE t1_p2 PARTITION OF t1
FOR VALUES FROM (1995) TO (1999);

-- Partition p3: for years 1999 - 2002
CREATE TABLE t1_p3 PARTITION OF t1
FOR VALUES FROM (1999) TO (2003);

-- Partition p4: for years 2003 - 2006
CREATE TABLE t1_p4 PARTITION OF t1
FOR VALUES FROM (2003) TO (2007);


-- Step 3️⃣: Insert data into the parent table
-- -------------------------------------------
-- PostgreSQL automatically routes rows to the
-- correct partition based on the year_col value.

INSERT INTO t1 (id, year_col) VALUES
(1, 1985),  -- goes to t1_p0
(2, 1990),  -- goes to t1_p0
(3, 1992),  -- goes to t1_p1
(4, 1994),  -- goes to t1_p1
(5, 1997),  -- goes to t1_p2
(6, 1998),  -- goes to t1_p2
(7, 2000),  -- goes to t1_p3
(8, 2002),  -- goes to t1_p3
(9, 2004),  -- goes to t1_p4
(10, 2006); -- goes to t1_p4


-- Step 4️⃣: Query data
-- --------------------
-- Fetch users between 1991 and 1999.
-- PostgreSQL will automatically scan only the
-- partitions that match this range.

SELECT *
FROM t1
WHERE year_col BETWEEN 1991 AND 1999;
