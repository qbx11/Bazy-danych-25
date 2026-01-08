SELECT 
    sr.room_name,
    sr.room_type,
    COUNT(s.id_screening) as liczba_seansow,
    COUNT(DISTINCT b.id_booking) as liczba_rezerwacji
FROM screening_room sr
LEFT JOIN screening s ON sr.id_room = s.id_room
LEFT JOIN bookings b ON s.id_screening = b.id_screening
GROUP BY sr.id_room, sr.room_name, sr.room_type
ORDER BY liczba_seansow DESC;