SELECT COUNT(*) AS total_weekend_reservations
FROM reservations
WHERE no_of_weekend_nights > 0;
