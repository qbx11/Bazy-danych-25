SELECT
    c.client_surname || ' ' || c.client_name AS "Pan\Pani",
    c.phone_number,
    SUM(m.duration) AS "Czas spedzony w kinie (minuty)",
    COUNT(sc.id_screening)  AS "Liczba obejrzanych seansów"
FROM clients c
JOIN bookings b USING(id_client)
JOIN screening sc USING(id_screening)
JOIN movies m USING(id_movie)
GROUP BY "Pan\Pani", c.phone_number
ORDER BY "Czas spedzony w kinie (minuty)" DESC
LIMIT 10