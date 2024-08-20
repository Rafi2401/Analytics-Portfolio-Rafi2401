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
