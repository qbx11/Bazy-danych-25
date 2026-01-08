SELECT 
    sr.room_name, t.row_num, t.seat_num, COUNT(t.id_ticket) AS "Krotność wyboru miejsca"
FROM tickets t 
JOIN bookings b USING(id_booking)
JOIN screening sc USING(id_screening)
JOIN screening_room sr USING(id_room)
WHERE b.booking_status = 'confirmed' 
GROUP BY sr.room_name, t.row_num, t.seat_num ORDER BY "Krotność wyboru miejsca" DESC
LIMIT 15;
