CREATE TABLE query (
    searchid SERIAL PRIMARY KEY,
    year INT NOT NULL,
    month INT NOT NULL,
    day INT NOT NULL,
    userid INT NOT NULL,
    ts INT NOT NULL,
    devicetype VARCHAR(20) NOT NULL,
    deviceid VARCHAR(50) NOT NULL,
    query VARCHAR(255) NOT NULL
);

INSERT INTO query (year, month, day, userid, ts, devicetype, deviceid, query) VALUES
(2023, 10, 1, 101, EXTRACT(EPOCH FROM '2023-10-01 08:00:00'::timestamp), 'android', 'device1', 'к'),
(2023, 10, 1, 101, EXTRACT(EPOCH FROM '2023-10-01 08:01:00'::timestamp), 'android', 'device1', 'ку'),
(2023, 10, 1, 102, EXTRACT(EPOCH FROM '2023-10-01 08:02:00'::timestamp), 'iPhone', 'device2', 'куп'),
(2023, 10, 1, 103, EXTRACT(EPOCH FROM '2023-10-01 08:03:00'::timestamp), 'iPad', 'device3', 'купить'),
(2023, 10, 1, 103, EXTRACT(EPOCH FROM '2023-10-01 08:04:00'::timestamp), 'iPad', 'device3', 'купить кур'),
(2023, 10, 1, 104, EXTRACT(EPOCH FROM '2023-10-01 09:00:00'::timestamp), 'desktop', 'device4', 'куртка'),
(2023, 10, 1, 104, EXTRACT(EPOCH FROM '2023-10-01 09:01:00'::timestamp), 'desktop', 'device4', 'купить куртку'),
(2023, 10, 2, 105, EXTRACT(EPOCH FROM '2023-10-02 10:00:00'::timestamp), 'iPad', 'device5', 'обувь'),
(2023, 10, 2, 105, EXTRACT(EPOCH FROM '2023-10-02 10:01:00'::timestamp), 'iPad', 'device5', 'купить обувь'),
(2023, 10, 2, 106, EXTRACT(EPOCH FROM '2023-10-02 11:00:00'::timestamp), 'android', 'device6', 'игрушка'),
(2023, 10, 2, 106, EXTRACT(EPOCH FROM '2023-10-02 11:01:00'::timestamp), 'android', 'device6', 'купить игрушку'),
(2023, 10, 3, 106, EXTRACT(EPOCH FROM '2023-10-03 12:00:00'::timestamp), 'android', 'device6', 'телефон'),
(2023, 10, 3, 107, EXTRACT(EPOCH FROM '2023-10-03 12:01:00'::timestamp), 'iPhone', 'device7', 'купить телефон'),
(2023, 10, 4, 108, EXTRACT(EPOCH FROM '2023-10-04 13:00:00'::timestamp), 'iPhone', 'device8', 'ноутбук'),
(2023, 10, 4, 108, EXTRACT(EPOCH FROM '2023-10-04 13:01:00'::timestamp), 'iPhone', 'device8', 'купить ноутбук'),
(2023, 10, 4, 109, EXTRACT(EPOCH FROM '2023-10-04 14:00:00'::timestamp), 'desktop', 'device9', 'книга'),
(2023, 10, 4, 109, EXTRACT(EPOCH FROM '2023-10-04 14:01:00'::timestamp), 'desktop', 'device9', 'купить книгу'),
(2023, 10, 5, 109, EXTRACT(EPOCH FROM '2023-10-05 15:00:00'::timestamp), 'desktop', 'device9', 'чайник'),
(2023, 10, 5, 110, EXTRACT(EPOCH FROM '2023-10-05 16:00:00'::timestamp), 'android', 'device10', 'купить чайник'),
(2023, 10, 5, 111, EXTRACT(EPOCH FROM '2023-10-05 17:00:00'::timestamp), 'iPad', 'device11', 'платье'),
(2023, 10, 5, 111, EXTRACT(EPOCH FROM '2023-10-05 17:01:00'::timestamp), 'iPad', 'device11', 'купить платье');

-- создали таблицу

WITH ranked_queries AS (
    SELECT
        *,
        LAG(ts) OVER (PARTITION BY userid, deviceid ORDER BY ts) AS prev_ts,
        LEAD(query) OVER (PARTITION BY userid, deviceid ORDER BY ts) AS next_query,
        LEAD(ts) OVER (PARTITION BY userid, deviceid ORDER BY ts) AS next_ts
    FROM 
        query
    WHERE
        year = 2023 AND month = 10 AND day = 1  -- выбираем запросы за нужный день
  -- определяем значением is_final
)
SELECT 
    searchid,
    year,
    month,
    day,
    userid,
    ts,
    devicetype,
    deviceid,
    query,
    CASE 
        WHEN next_ts IS NULL THEN 1
        WHEN (next_ts - ts) > 180 THEN 1
        WHEN (next_query IS NOT NULL AND LENGTH(next_query) < LENGTH(query) AND (next_ts - ts) > 60) THEN 2
        ELSE 0
    END AS is_final
FROM 
    ranked_queries
WHERE 
    (next_ts IS NULL OR (next_ts - ts) > 60 OR (next_query IS NOT NULL AND LENGTH(next_query) < LENGTH(query) AND (next_ts - ts) > 60))
    AND (CASE 
            WHEN next_ts IS NULL THEN 1
            WHEN (next_ts - ts) > 180 THEN 1
            WHEN (next_query IS NOT NULL AND LENGTH(next_query) < LENGTH(query) AND (next_ts - ts) > 60) THEN 2
            ELSE 0
        END) IN (1, 2) AND devicetype = 'android'
-- отбираем строки, которые подходят по условию 
ORDER BY 
    ts;