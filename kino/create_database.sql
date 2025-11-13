CREATE TABLE movies (
    id_movie SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    duration INTEGER NOT NULL,
    genre VARCHAR(50),
    short_description TEXT,
    release_date INTEGER,
    min_age INTEGER

);

CREATE TABLE screening_room (
    id_room SERIAL PRIMARY KEY,
    room_name VARCHAR(50) NOT NULL,
    num_of_seats INTEGER NOT NULL,
    num_of_rows INTEGER NOT NULL,
    room_type VARCHAR(20)
);

CREATE TABLE screening (
    id_screening SERIAL PRIMARY KEY,
    id_movie INTEGER NOT NULL REFERENCES movies(id_movie),
    id_room INTEGER NOT NULL REFERENCES screening_room(id_room),
    date_hour TIMESTAMP NOT NULL,
    base_price DECIMAL(10,2) NOT NULL,
    screening_language VARCHAR(20)
);

CREATE TABLE clients (
    id_client SERIAL PRIMARY KEY,
    client_name VARCHAR(50) NOT NULL,
    client_surname VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    birth_date DATE
);

CREATE TABLE bookings (
    id_booking SERIAL PRIMARY KEY,
    id_client INTEGER NOT NULL REFERENCES clients(id_client),
    id_screening INTEGER NOT NULL REFERENCES screening(id_screening),
    booking_date TIMESTAMP DEFAULT NOW(),
    booking_status VARCHAR(20),
    booking_code VARCHAR(20) UNIQUE
);

CREATE TABLE tickets (
    id_ticket SERIAL PRIMARY KEY,
    id_booking INTEGER NOT NULL REFERENCES bookings(id_booking),
    ticket_type VARCHAR(20) NOT NULL,
    seat_num INTEGER NOT NULL,
    row_num INTEGER NOT NULL,
    price DECIMAL(10,2) NOT NULL
);