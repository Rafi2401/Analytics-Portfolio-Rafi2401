SELECT market_segment_type, COUNT(*) AS count
FROM reservations
GROUP BY market_segment_type
ORDER BY count DESC;
