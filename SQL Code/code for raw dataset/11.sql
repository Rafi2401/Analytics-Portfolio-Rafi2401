SELECT AVG(no_of_weekend_nights) AS average_weekend_nights_with_children
FROM reservations
WHERE no_of_children > 0;
