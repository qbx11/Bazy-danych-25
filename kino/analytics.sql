-- Ile łącznie sprzedano biletów?
SELECT 
    COUNT(*) as "Liczba sprzedanych biletów",
    SUM(price) as "Łączny przychód (zł)",
    ROUND(AVG(price), 2) as "Średnia cena biletu (zł)"
FROM tickets t
JOIN bookings b ON t.id_booking = b.id_booking
WHERE b.booking_status = 'confirmed';