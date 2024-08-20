SELECT COUNT(*) AS confirmed_reservations
FROM reservations
WHERE booking_status = 'Not_Canceled';
