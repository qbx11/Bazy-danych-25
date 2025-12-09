SELECT * 
FROM tickets t
JOIN bookings b ON t.id_booking = b.id_booking
WHERE b.id_screening = 1 
  AND t.row_num = 5 
  AND t.seat_num = 15;