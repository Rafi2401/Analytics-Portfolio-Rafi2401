-- 2017 --
SELECT COUNT(*) AS reservation_count
FROM reservations
WHERE 
    (arrival_date LIKE '%/%' AND YEAR(STR_TO_DATE(arrival_date, '%d/%m/%Y')) = 2017)
    OR
    (arrival_date LIKE '%-%' AND YEAR(STR_TO_DATE(arrival_date, '%d-%m-%Y')) = 2017);
-- 2018 -- 
SELECT COUNT(*) AS reservation_count
FROM reservations
WHERE 
    (arrival_date LIKE '%/%' AND YEAR(STR_TO_DATE(arrival_date, '%d/%m/%Y')) = 2018)
    OR
    (arrival_date LIKE '%-%' AND YEAR(STR_TO_DATE(arrival_date, '%d-%m-%Y')) = 2018);
