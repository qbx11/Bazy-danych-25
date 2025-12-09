# Baza Danych 

## Instalacja PostgreSQL

### Linux (Ubuntu/Debian)
```bash
sudo apt update
sudo apt install postgresql postgresql-contrib
```

### macOS
```bash
brew install postgresql@15
brew services start postgresql@15
```

### Windows
https://www.postgresql.org/download/windows/

## Konfiguracja początkowa

### 1. Uruchomienie serwera PostgreSQL

#### Linux
```bash
sudo systemctl start postgresql
sudo systemctl enable postgresql
```

#### macOS
```bash
brew services start postgresql@15
```

#### Windows
Serwis uruchamia się automatycznie po instalacji.

### 2. Logowanie do PostgreSQL

```bash
sudo -u postgres psql
```

Dla systemów Windows:
```bash
psql -U postgres
```

### 3. Utworzenie bazy danych

W terminalu PostgreSQL:
```sql
CREATE DATABASE cinema_db;
```

Sprawdzenie utworzonych baz:
```sql
\l
```

### 4. Połączenie z bazą danych

```sql
\c cinema_db
```

## Inicjalizacja struktury bazy danych

### 1. Utworzenie tabel

Będąc połączonym z bazą `cinema_db`, wykonaj:

```bash
\i /ścieżka/do/repozytorium/create_database.sql
```

Alternatywnie, z poziomu systemu operacyjnego:

```bash
psql -U postgres -d cinema_db -f create_database.sql
```

### 2. Weryfikacja utworzonych tabel

```sql
\dt
```

Powinny pojawić się tabele: movies, screening_room, screening, clients, bookings, tickets

### 3. Podgląd struktury konkretnej tabeli

```sql
\d movies
\d screening
\d tickets
```

## Import danych testowych

### 1. Import filmów, sal, klientów i seansów

```bash
psql -U postgres -d cinema_db -f insert_big_data.sql
```

Z poziomu terminala PostgreSQL:
```sql
\i /ścieżka/do/repozytorium/insert_big_data.sql
```

### 2. Import rezerwacji

```bash
psql -U postgres -d cinema_db -f insert_bookings.sql
```

### 3. Import biletów

```bash
psql -U postgres -d cinema_db -f insert_tickets.sql
```

### 4. Weryfikacja importu danych

Połącz się z bazą i sprawdź liczbę rekordów:

```sql
SELECT COUNT(*) FROM movies;        -- Powinno być 40
SELECT COUNT(*) FROM screening_room; -- Powinno być 8
SELECT COUNT(*) FROM clients;       -- Powinno być 100
SELECT COUNT(*) FROM screening;     -- Powinno być 200
SELECT COUNT(*) FROM bookings;      -- Powinno być 200
SELECT COUNT(*) FROM tickets;       -- Powinno być więcej niż 200
```

## Przykładowe zapytania

### Podstawowe zapytania

#### Wyświetl wszystkie filmy
```sql
SELECT * FROM movies;
```

#### Wyświetl seanse z datą późniejszą niż dziś
```sql
SELECT s.*, m.title 
FROM screening s
JOIN movies m ON s.id_movie = m.id_movie
WHERE s.date_hour > NOW()
ORDER BY s.date_hour;
```

#### Znajdź rezerwacje konkretnego klienta
```sql
SELECT b.*, c.client_name, c.client_surname, m.title
FROM bookings b
JOIN clients c ON b.id_client = c.id_client
JOIN screening s ON b.id_screening = s.id_screening
JOIN movies m ON s.id_movie = m.id_movie
WHERE c.id_client = 1;
```

### Zapytania analityczne

#### Statystyki sprzedaży biletów (z pliku analytics.sql)
```sql
SELECT 
    COUNT(*) as "Liczba sprzedanych biletów",
    SUM(price) as "Łączny przychód (zł)",
    ROUND(AVG(price), 2) as "Średnia cena biletu (zł)"
FROM tickets t
JOIN bookings b ON t.id_booking = b.id_booking
WHERE b.booking_status = 'confirmed';
```

#### Najbardziej popularne filmy
```sql
SELECT 
    m.title,
    COUNT(DISTINCT b.id_booking) as liczba_rezerwacji,
    COUNT(t.id_ticket) as liczba_biletow
FROM movies m
JOIN screening s ON m.id_movie = s.id_movie
JOIN bookings b ON s.id_screening = b.id_screening
JOIN tickets t ON b.id_booking = t.id_booking
WHERE b.booking_status = 'confirmed'
GROUP BY m.id_movie, m.title
ORDER BY liczba_biletow DESC
LIMIT 10;
```

#### Wykorzystanie sal kinowych
```sql
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
```
