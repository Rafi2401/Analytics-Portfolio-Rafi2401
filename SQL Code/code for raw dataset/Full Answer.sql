SELECT * FROM reservations.reservations;

-- 1
SELECT COUNT(*) AS total_reservations FROM reservations;

-- 2
SELECT type_of_meal_plan, COUNT(*) AS count
FROM reservations
GROUP BY type_of_meal_plan
ORDER BY count DESC;

-- 3
SELECT AVG(avg_price_per_room) AS average_price_per_room
FROM reservations
WHERE no_of_children > 0;

-- 4
-- 2017
SELECT COUNT(*) AS reservation_count
FROM reservations
WHERE 
    (arrival_date LIKE '%/%' AND YEAR(STR_TO_DATE(arrival_date, '%d/%m/%Y')) = 2017)
    OR
    (arrival_date LIKE '%-%' AND YEAR(STR_TO_DATE(arrival_date, '%d-%m-%Y')) = 2017);
-- 2018
SELECT COUNT(*) AS reservation_count
FROM reservations
WHERE 
    (arrival_date LIKE '%/%' AND YEAR(STR_TO_DATE(arrival_date, '%d/%m/%Y')) = 2018)
    OR
    (arrival_date LIKE '%-%' AND YEAR(STR_TO_DATE(arrival_date, '%d-%m-%Y')) = 2018);

-- 5
SELECT room_type_reserved, COUNT(*) AS count
FROM reservations
GROUP BY room_type_reserved
ORDER BY count DESC;

-- 6
SELECT COUNT(*) AS total_weekend_reservations
FROM reservations
WHERE no_of_weekend_nights > 0;

-- 7
SELECT MAX(lead_time) AS highest_wait_time, MIN(lead_time) AS lowest_wait_time
FROM reservations;

-- 8
SELECT market_segment_type, COUNT(*) AS count
FROM reservations
GROUP BY market_segment_type
ORDER BY count DESC;

-- 9
SELECT COUNT(*) AS confirmed_reservations
FROM reservations
WHERE booking_status = 'Not_Canceled';

-- 10
SELECT SUM(no_of_adults) AS total_adults,
       SUM(no_of_children) AS total_children
FROM reservations;

-- 11
SELECT AVG(no_of_weekend_nights) AS average_weekend_nights_with_children
FROM reservations
WHERE no_of_children > 0;

-- 12
SELECT MONTH(STR_TO_DATE(arrival_date, '%Y-%m-%d')) AS month_number,
       COUNT(*) AS reservations_count
FROM (
    SELECT 
        CASE
            WHEN arrival_date LIKE '%-%' THEN arrival_date  -- Handle format with '-'
            WHEN arrival_date LIKE '%/%' THEN REPLACE(arrival_date, '/', '-')  -- Convert '/' to '-'
        END AS arrival_date
    FROM reservations
) AS formatted_dates
WHERE arrival_date IS NOT NULL
GROUP BY MONTH(STR_TO_DATE(arrival_date, '%Y-%m-%d'))
ORDER BY month_number;

-- 13
SELECT room_type_reserved,
       AVG(no_of_weekend_nights + no_of_week_nights) AS avg_total_nights
FROM reservations
GROUP BY room_type_reserved;

-- 14
SELECT room_type_reserved, COUNT(*) AS num_reservations
FROM reservations
WHERE no_of_children > 0
GROUP BY room_type_reserved
ORDER BY num_reservations DESC;

SELECT AVG(avg_price_per_room) AS average_price
FROM reservations
WHERE room_type_reserved = (
    SELECT room_type_reserved
    FROM (
        SELECT room_type_reserved, COUNT(*) AS num_reservations
        FROM reservations
        WHERE no_of_children > 0
        GROUP BY room_type_reserved
        ORDER BY num_reservations DESC
    ) AS most_common_room
);

-- 15
SELECT market_segment_type,
       AVG(avg_price_per_room) AS average_price_per_room
FROM reservations
GROUP BY market_segment_type
ORDER BY average_price_per_room DESC;
