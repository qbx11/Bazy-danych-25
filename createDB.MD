dropdb kino
createdb kino

psql -d kino -f create_database.sql
psql -d kino -f insert_big_data.sql
psql -d kino -f insert_bookings.sql
psql -d kino -f insert_tickets.sql
