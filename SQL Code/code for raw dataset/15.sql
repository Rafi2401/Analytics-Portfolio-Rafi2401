SELECT market_segment_type,
       AVG(avg_price_per_room) AS average_price_per_room
FROM reservations
GROUP BY market_segment_type
ORDER BY average_price_per_room DESC;
