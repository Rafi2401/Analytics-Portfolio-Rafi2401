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
