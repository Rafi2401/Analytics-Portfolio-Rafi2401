SELECT AVG(avg_price_per_room) AS average_price_per_room
FROM reservations
WHERE no_of_children > 0;
