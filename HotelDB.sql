CREATE SCHEMA hotel
CREATE TABLE hotel.RoomTypes(
    room_type_id     SERIAL     PRIMARY KEY ,
    type_name        VARCHAR(50) NOT NULL  UNIQUE ,
    price_per_night  NUMERIC(10,2) CHECK ( price_per_night > 0 ),
    max_capacity     INTEGER       CHECK ( max_capacity > 0 )
)
CREATE TABLE hotel.Rooms(
    room_id          SERIAL      PRIMARY KEY ,
    room_number      VARCHAR(10) NOT NULL UNIQUE ,
    room_type_id     INTEGER    REFERENCES hotel.RoomTypes(room_type_id),
    status           VARCHAR(20) CHECK ( status in ('Available','Occupied','Maintenance'))

)
CREATE TABLE hotel.Customers(
    customer_id      SERIAL    PRIMARY KEY ,
    full_name        VARCHAR(100) NOT NULL ,
    email            VARCHAR(100) UNIQUE NOT NULL ,
    phone           VARCHAR(15)   NOT NULL
)
CREATE TABLE  hotel.Bookings(
    booking_id     SERIAL    PRIMARY KEY ,
    customer_id    INT       REFERENCES hotel.Customers(customer_id),
    room_id        INT       REFERENCES hotel.Rooms(room_id),
    check_in       DATE      NOT NULL ,
    check_out      DATE      NOT NULL ,
    status         VARCHAR(20) CHECK ( status in ('Pending','Confirmed','Cancelled'))
)

CREATE TABLE hotel.Payments(
    payment_id     SERIAL    PRIMARY KEY,
    booking_id     INT       REFERENCES hotel.Bookings(booking_id),
    amount         NUMERIC(10,2)  CHECK ( amount >=0 ),
    payment_date   DATE       NOT NULL ,
    method         VARCHAR(20)   CHECK ( method in ('Credit Card','Cash','Bank Transfer'))

)