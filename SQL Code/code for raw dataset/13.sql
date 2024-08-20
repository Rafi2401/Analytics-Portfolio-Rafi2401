SELECT room_type_reserved,
       AVG(no_of_weekend_nights + no_of_week_nights) AS avg_total_nights
FROM reservations
GROUP BY room_type_reserved;
