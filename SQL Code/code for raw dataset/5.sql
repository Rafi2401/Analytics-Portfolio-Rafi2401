SELECT room_type_reserved, COUNT(*) AS count
FROM reservations
GROUP BY room_type_reserved
ORDER BY count DESC;
