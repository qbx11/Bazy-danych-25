INSERT INTO movies (title, duration, genre, short_description, release_date, min_age) VALUES
('Oppenheimer', 180, 'Biograficzny', 'Historia twórcy bomby atomowej', 2023, 12),
('Barbie', 114, 'Komedia', 'Przygody lalki Barbie w prawdziwym świecie', 2023, 7),
('Dune: Part Two', 166, 'Science Fiction', 'Kontynuacja epickie historii Paula Atrydy', 2024, 12),
('Avatar: The Way of Water', 192, 'Science Fiction', 'Powrót na Pandorę', 2022, 12),
('Spider-Man: Across the Spider-Verse', 140, 'Animacja', 'Miles Morales w multiwersum', 2023, 7);

INSERT INTO screening_room (room_name, num_of_seats, num_of_rows, room_type) VALUES
('Sala 1', 150, 10, '2D'),
('Sala 2', 200, 12, '3D'),
('Sala 3', 100, 8, 'IMAX'),
('Sala VIP', 50, 5, 'VIP');

INSERT INTO clients (client_name, client_surname, email, phone_number, birth_date) VALUES
('Jan', 'Kowalski', 'jan.kowalski@email.com', '123456789', '1990-05-15'),
('Anna', 'Nowak', 'anna.nowak@email.com', '987654321', '1995-08-22'),
('Piotr', 'Wiśniewski', 'piotr.wisniewski@email.com', '555666777', '1988-03-10'),
('Maria', 'Wójcik', 'maria.wojcik@email.com', '111222333', '2000-12-01'),
('Katarzyna', 'Kowalczyk', 'kata.kowalczyk@email.com', '444555666', '1992-07-18');

INSERT INTO screening (id_movie, id_room, date_hour, base_price, screening_language) VALUES
(1, 3, '2025-11-14 18:00:00', 35.00, 'Angielski'),
(1, 3, '2025-11-14 21:30:00', 35.00, 'Angielski'),
(2, 1, '2025-11-14 16:00:00', 25.00, 'Polski dubbing'),
(2, 2, '2025-11-14 19:00:00', 30.00, '3D Polski'),
(3, 2, '2025-11-15 17:00:00', 32.00, 'Napisy PL'),
(3, 3, '2025-11-15 20:00:00', 38.00, 'IMAX Napisy'),
(4, 2, '2025-11-15 15:00:00', 30.00, '3D Napisy'),
(5, 1, '2025-11-16 14:00:00', 22.00, 'Polski dubbing');

INSERT INTO bookings (id_client, id_screening, booking_status, booking_code) VALUES
(1, 1, 'confirmed', 'BOOK001'),
(2, 3, 'confirmed', 'BOOK002'),
(3, 5, 'confirmed', 'BOOK003'),
(4, 6, 'pending', 'BOOK004'),
(5, 2, 'confirmed', 'BOOK005');

INSERT INTO tickets (id_booking, ticket_type, seat_num, row_num, price) VALUES
-- Rezerwacja 1: Jan Kowalski - Oppenheimer IMAX
(1, 'normal', 15, 5, 35.00),
(1, 'normal', 16, 5, 35.00),
-- Rezerwacja 2: Anna Nowak - Barbie
(2, 'student', 10, 3, 20.00),
-- Rezerwacja 3: Piotr Wiśniewski - Dune Part 2
(3, 'normal', 12, 6, 32.00),
(3, 'senior', 13, 6, 26.00),
-- Rezerwacja 4: Maria Wójcik - Dune IMAX
(4, 'vip', 5, 2, 45.00),
-- Rezerwacja 5: Katarzyna - Oppenheimer
(5, 'student', 20, 7, 28.00),
(5, 'student', 21, 7, 28.00);