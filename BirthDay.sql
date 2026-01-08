WITH next_birthdays AS (
    -- Oblicz następne urodziny dla każdego klienta względem aktualnej daty
    SELECT 
        id_client,
        client_surname || ' ' || client_name AS full_name,
        email,
        birth_date,
        CASE
            WHEN EXTRACT(MONTH FROM birth_date) > EXTRACT(MONTH FROM CURRENT_DATE) 
                 OR (EXTRACT(MONTH FROM birth_date) = EXTRACT(MONTH FROM CURRENT_DATE) 
                     AND EXTRACT(DAY FROM birth_date) >= EXTRACT(DAY FROM CURRENT_DATE))
            THEN MAKE_DATE(EXTRACT(YEAR FROM CURRENT_DATE)::INTEGER, 
                           EXTRACT(MONTH FROM birth_date)::INTEGER, 
                           EXTRACT(DAY FROM birth_date)::INTEGER)
            ELSE MAKE_DATE(EXTRACT(YEAR FROM CURRENT_DATE)::INTEGER + 1, 
                           EXTRACT(MONTH FROM birth_date)::INTEGER, 
                           EXTRACT(DAY FROM birth_date)::INTEGER)
        END AS next_birthday
    FROM clients
),
closest_clients AS (
    -- Wybierz top  klientów z najbliższymi urodzinami 
    SELECT 
        id_client,
        full_name,
        email,
        next_birthday,
        next_birthday - CURRENT_DATE AS days_to_birthday
    FROM next_birthdays
    WHERE next_birthday >= CURRENT_DATE 
    ORDER BY days_to_birthday ASC
    LIMIT 7
),
favorite_genres AS (
    -- Dla wybranych klientów zlicz gatunki filmów z ich seansów
    SELECT 
        cc.id_client,
        m.genre,
        COUNT(DISTINCT s.id_screening) AS watch_count,
        ROW_NUMBER() OVER (PARTITION BY cc.id_client ORDER BY COUNT(DISTINCT s.id_screening) DESC) AS rn
    FROM closest_clients cc
    LEFT JOIN bookings b ON cc.id_client = b.id_client
    LEFT JOIN screening s ON b.id_screening = s.id_screening
    LEFT JOIN movies m ON s.id_movie = m.id_movie
    GROUP BY cc.id_client, m.genre
)
-- Końcowy wynik
SELECT 
    cc.full_name AS "Pani/Pan",
    cc.email,
    cc.days_to_birthday AS "Dni do urodzin",
    cc.next_birthday AS "Data urodzin",
    fg.genre AS "Ulubiony gatunek",
    fg.watch_count AS "Liczba seansów"
FROM closest_clients cc
LEFT JOIN favorite_genres fg ON cc.id_client = fg.id_client AND fg.rn = 1  -- tylko top gatunek per klient
ORDER BY cc.days_to_birthday ASC;