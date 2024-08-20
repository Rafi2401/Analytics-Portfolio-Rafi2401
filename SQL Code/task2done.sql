CREATE DATABASE IF NOT EXISTS hotel_reservations;

USE hotel_reservations;

CREATE TABLE reservations (
    Booking_ID VARCHAR(50) PRIMARY KEY,
    no_of_adults INT,
    no_of_children INT,
    no_of_weekend_nights INT,
    no_of_week_nights INT,
    type_of_meal_plan VARCHAR(50),
    room_type_reserved VARCHAR(50),
    lead_time INT,
    arrival_date DATE,
    market_segment_type VARCHAR(50),
    avg_price_per_room DECIMAL(10, 2),
    booking_status VARCHAR(50)
);

SHOW VARIABLES LIKE "secure_file_priv";
/* LOAD DATA INFILE 'C:\\ProgramData\\MySQL\MySQL Server 8.0\\Uploads\\Hotel_Reservation_Dataset.csv'
INTO TABLE reservations
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Booking_ID, no_of_adults, no_of_children, no_of_weekend_nights, no_of_week_nights, type_of_meal_plan, room_type_reserved, lead_time, arrival_date, market_segment_type, avg_price_per_room, booking_status);
*/
-- Load data error 1290 cant fix this error, using table data import wizard.
-- Using table data import wizard error, nothing data imported.
-- Because in the arrival date column there is a DD-MM-YYYY format which needs to be changed to date
/* CLEAN DATA
UPDATE reservations 
SET arrival_date = STR_TO_DATE(arrival_date, '%d-%m-%Y')
WHERE arrival_date IS NOT NULL AND arrival_date <> '';
*/
/* USING PYTHON CLEAN DATA
-- Loading data from CSV file, Changing arrival_date column from VARCHAR to DATE with correct format.
-- Remove duplicate data, Remove incomplete data (missing values), Save the cleaned data results to a new file as Cleaned_Hotel_Reservation_Dataset.csv.
-- Done, then import Cleaned_Hotel_Reservation_Dataset.csv.
*/

-- 1. Total number of reservations:
SELECT COUNT(*) AS total_reservations FROM reservations;

-- 2. Most popular meal plan:
SELECT type_of_meal_plan, COUNT(*) AS count
FROM reservations
GROUP BY type_of_meal_plan
ORDER BY count DESC
LIMIT 10;

-- 3. Average price per room for reservations involving children:
SELECT AVG(avg_price_per_room) AS average_price
FROM reservations
WHERE no_of_children > 0;

-- 4. Number of reservations made for a specific year (replace XX with the year):
/*SELECT COUNT(*) AS reservations_for_year, COUNT(*) AS reservations_for_year
FROM reservations
WHERE YEAR(arrival_date) = 20XX;
*/
SELECT YEAR(arrival_date) AS year, COUNT(*) AS reservations_for_year
FROM reservations
WHERE YEAR(arrival_date) IN (2015,2016,2017,2018,2019,2020,2021,2022,2023,2024)
GROUP BY YEAR(arrival_date);

-- 5. Most commonly booked room type:
SELECT room_type_reserved, COUNT(*) AS count
FROM reservations
GROUP BY room_type_reserved
ORDER BY count DESC
LIMIT 10;

-- 6. Number of reservations falling on a weekend:
SELECT COUNT(*) AS weekend_reservations
FROM reservations
WHERE no_of_weekend_nights > 0;

-- 7. Highest and lowest lead time for reservations:
SELECT MAX(lead_time) AS highest_lead_time, MIN(lead_time) AS lowest_lead_time
FROM reservations;

-- 8. Most common market segment type:
SELECT market_segment_type, COUNT(*) AS count
FROM reservations
GROUP BY market_segment_type
ORDER BY count DESC
LIMIT 10;

-- 9. Number of reservations with a booking status of "Confirmed":
SELECT COUNT(*) AS confirmed_reservations
FROM reservations
WHERE booking_status = 'Not_Canceled';

-- 10. Total number of adults and children across all reservations:
SELECT SUM(no_of_adults) AS total_adults, SUM(no_of_children) AS total_children
FROM reservations;

-- 11. Average number of weekend nights for reservations involving children:
SELECT AVG(no_of_weekend_nights) AS average_weekend_nights
FROM reservations
WHERE no_of_children > 0;

-- 12. Number of reservations made in each month of the year:
SELECT MONTH(arrival_date) AS month, COUNT(*) AS reservations_count
FROM reservations
GROUP BY MONTH(arrival_date)
ORDER BY month;

-- 13. Average number of nights (both weekend and weekday) spent by guests for each room type:
SELECT room_type_reserved,
       AVG(no_of_weekend_nights + no_of_week_nights) AS average_nights
FROM reservations
GROUP BY room_type_reserved;

-- 14. Most common room type and average price for that room type for reservations involving children:
SELECT room_type_reserved, 
       COUNT(*) AS count,
       AVG(avg_price_per_room) AS average_price
FROM reservations
WHERE no_of_children > 0
GROUP BY room_type_reserved
ORDER BY count DESC
LIMIT 10;

-- 15. Market segment type that generates the highest average price per room:
SELECT market_segment_type,
       AVG(avg_price_per_room) AS average_price
FROM reservations
GROUP BY market_segment_type
ORDER BY average_price DESC
LIMIT 10;