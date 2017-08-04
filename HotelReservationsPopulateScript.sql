USE HotelReservations;

DELETE FROM Promotions WHERE PromotionCode >= 0;
DELETE FROM Rooms WHERE RoomId >= 0;
DELETE FROM CustomersGuests WHERE CustomerId >= 0;
DELETE FROM ReservationsGuests WHERE ReservationId >= 0;
DELETE FROM RoomsAmenities WHERE RoomId >= 0;
DELETE FROM Reservations WHERE ReservationId >= 0;
DELETE FROM Conveniences WHERE BillDetailsId >= 0;
DELETE FROM BillDetails WHERE BillDetailsId >= 0;
DELETE FROM ReservationsRooms WHERE ReservationRoomId >= 0;

DELETE FROM Hotels WHERE HotelId >= 0;
DELETE FROM Customers WHERE CustomerId >= 0;
DELETE FROM Guests WHERE GuestId >= 0;
DELETE FROM DeltaTypes WHERE DeltaTypeId >= 0;
DELETE FROM ConvenienceTypes WHERE ConvenienceTypeId >= 0;
DELETE FROM RoomTypes WHERE RoomTypeId >= 0;
DELETE FROM Amenities WHERE AmenityId >= 0;

INSERT INTO Hotels (HotelId, Name, State, City, StreetAddress, ZipCode)
VALUES (1, 'GHOAT', 'Kentucky', 'Louisville', '925 W. Main St.', 40208);

INSERT INTO Customers (CustomerId, Name, Email, Phone)
VALUES (1, 'Brennan', 'brennan@tswg.net', '404-889-5555'),
(2, 'Camber', 'camber@tswg.net', '502-751-5555'),
(3, 'Jenn', 'jenn@tswg.net', '502-451-5555'),
(4, 'Paul', 'paul@tswg.net', '502-526-5555');

INSERT INTO Guests (GuestId, Name, Age)
VALUES (1, 'Kai', 2),
(2, 'Matt', 32),
(3, 'Rando', 39),
(4, 'Batman', 45),
(5, 'Joker', 44),
(6, 'Brennan', 22);

INSERT INTO CustomersGuests (CustomerId, GuestId)
VALUES (4, 1), (4, 6), (4, 5), (2, 4), (2, 6), (1, 2), (1, 3);

INSERT INTO DeltaTypes (DeltaTypeId, DeltaType)
VALUES (1, '$'), (2, '%');

INSERT INTO ConvenienceTypes (ConvenienceTypeId, ConvenienceType, ConvenienceTypeCost)
VALUES (1, 'Cheap Wine', 20.00),
(2, 'Decent Wine', 50.00), 
(3, 'Good Wine', 120.00),
(4, 'Burger Plate', 20.00),
(5, 'Sirloin Plate', 30.00),
(6, 'Filet Plate', 47.50);

INSERT INTO RoomTypes (RoomTypeId, RoomType, MaxOccupants, BaseCost)
VALUES (1, 'Queen', 4, 200.00), (2, 'King', 4, 250.00), (3, 'Suite', 6, 300.00);

INSERT INTO Amenities (AmenityId, AmenityType)
VALUES (1, 'TV'), (2, 'Fridge'), (3, 'Minibar'), (4, 'Jacuzzi'), (5, 'Fold-out couch');

INSERT INTO Promotions (PromotionCode, Amount, DeltaTypeId, StartDate, EndDate)
VALUES ('145975', 100.00, 1, '2017-07-01', '2017-07-31'),
('9111642', 20, 2, '2017-06-01', '2017-06-30');

INSERT INTO Rooms (RoomId, HotelId, Floor, RoomNumber, RoomTypeId)
VALUES (1, 1, 1, 100, 1), (2, 1, 1, 101, 1), (3, 1, 1, 102, 1), (4, 1, 1, 103, 1),
(5, 1, 2, 200, 2), (6, 1, 2, 201, 2), (7, 1, 2, 202, 2), (8, 1, 2, 203, 2), 
(9, 1, 3, 300, 3), (10, 1, 3, 301, 3), (11, 1, 3, 302, 3), (12, 1, 3, 303, 3);

INSERT INTO RoomsAmenities (RoomId, AmenityId, AmenityCount)
VALUES (1, 1, 1), (1, 2, 1), (2, 1, 1), (2, 2, 1), (3, 1, 1), (3, 2, 1), (4, 1, 2), (4, 2, 1), (4, 3, 1),
(5, 1, 1), (5, 2, 1), (5, 3, 1), (6, 1, 1), (6, 2, 1), (6, 3, 1), (7, 1, 1), (7, 2, 1), (7, 3, 1), (8, 1, 2), (8, 2, 1), (8, 3, 1), 
(9, 1, 2), (9, 2, 1), (9, 3, 1), (9, 4, 1), (9, 5, 1), (10, 1, 2), (10, 2, 1), (10, 3, 1), (10, 4, 1), (10, 5, 1), 
(11, 1, 2), (11, 2, 1), (11, 3, 1), (11, 4, 1), (11, 5, 1), (12, 1, 2), (12, 2, 1), (12, 3, 2), (12, 4, 1), (12, 5, 1);

INSERT INTO Reservations (ReservationId, HotelId, CustomerId, StartDate, EndDate, PromotionCode, InvoiceTotal, PaymentReceived, AmountDue)
VALUES (1, 1, 1, '2017-06-12', '2017-06-19', '9111642', 1800.00, 1800.00, 0.00),
(2, 1, 1, '2017-07-12', '2017-07-15', '145975', 1200.95, 1200.95, 0.00),
(3, 1, 3, '2017-06-15', '2017-06-18', '9111642', 600.00, 600.00, 0.00),
(4, 1, 2, '2017-06-01', '2017-06-02', null, 600.00, 400.00, 200.00),
(5, 1, 2, '2017-08-01', '2017-08-05', null, 0.00, 0.00, 0.00), 
(6, 1, 4, '2017-07-12', '2017-07-15', null, 1000.00, 999.99, 0.01),
(7, 1, 4, '2017-08-15', '2017-08-16', null, 0.00, 0.00, 0.00);

INSERT INTO ReservationsGuests (ReservationId, GuestId)
VALUES (1, 2), (2, 2), (2, 3), (4, 4), (4, 6), (6, 1), (6, 5), (7, 6);

INSERT INTO ReservationsRooms (ReservationRoomId, ReservationId, RoomId)
VALUES (1, 1, 12), (2, 1, 11), (3, 2, 3), (4, 2, 5), (5, 3, 9), (6, 4, 12), (7, 5, 12), (8, 6, 8), (9, 6, 9), (10, 7, 10);

INSERT INTO BillDetails (BillDetailsId, ReservationId, ReservationRoomId, Date, RoomCharge)
VALUES (1, 1, 1, '2017-06-12', 300.00), (2, 1, 1, '2017-06-13', 300.00), (3, 1, 1, '2017-06-14', 300.00), (4, 1, 1, '2017-06-15', 300.00), (5, 1, 1, '2017-06-16', 300.00), (6, 1, 1, '2017-06-17', 300.00), (7, 1, 1, '2017-06-18', 300.00), (8, 1, 1, '2017-06-19', 300.00),
(9, 1, 2, '2017-06-12', 300.00), (10, 1, 2, '2017-06-13', 300.00), (11, 1, 2, '2017-06-14', 300.00), (12, 1, 2, '2017-06-15', 300.00), (13, 1, 2, '2017-06-16', 300.00), (14, 1, 2, '2017-06-17', 300.00), (15, 1, 2, '2017-06-18', 300.00), (16, 1, 2, '2017-06-19', 300.00),
(17, 2, 3, '2017-07-12', 200.00), (18, 2, 3, '2017-07-13', 200.00), (19, 2, 3, '2017-07-14', 200.00), (20, 2, 3, '2017-07-15', 200.00),
(21, 2, 4, '2017-07-12', 200.00), (22, 2, 4, '2017-07-13', 200.00), (23, 2, 4, '2017-07-14', 200.00), (24, 2, 4, '2017-07-15', 200.00),
(25, 3, 5, '2017-06-15', 300.00), (26, 3, 5, '2017-06-16', 300.00), (27, 3, 5, '2017-06-17', 300.00), (28, 3, 5, '2017-06-18', 300.00),
(29, 4, 6, '2017-06-01', 300.00), (30, 4, 6, '2017-06-02', 300.00),
(31, 5, 7, '2017-08-01', 0.00), (32, 5, 7, '2017-08-02', 0.00), (33, 5, 7, '2017-08-03', 0.00), (34, 5, 7, '2017-08-04', 0.00), (35, 5, 7, '2017-08-05', 0.00),
(36, 6, 8, '2017-07-12', 250.00), (37, 6, 8, '2017-07-13', 250.00), (38, 6, 8, '2017-07-14', 250.00), (39, 6, 8, '2017-07-15', 250.00),
(40, 6, 9, '2017-07-12', 300.00), (41, 6, 9, '2017-07-13', 300.00), (42, 6, 9, '2017-07-14', 300.00), (43, 6, 9, '2017-07-15', 300.00),
(44, 7, 10, '2017-08-15', 0.00), (45, 7, 10, '2017-08-16', 0.00);



INSERT INTO Conveniences (BillDetailsId, ConvenienceType, ConvenienceCost)
VALUES (1, 4, 20.00), (1, 1, 20.00), (2, 3, 120.00), (2, 6, 47.50), (9, 4, 20.00), (10, 6, 47.50),
(17, 4, 0.00), (21, 4, 0.00),
(30, 5, 30.00),
(37, 4, 20.00);











-- (1, 'Cheap Wine', 20.00),
-- (2, 'Decent Wine', 50.00), 
-- (3, 'Good Wine', 120.00),
-- (4, 'Burger Plate', 20.00),
-- (5, 'Sirloin Plate', 30.00),
-- (6, 'Filet Plate', 47.50);












