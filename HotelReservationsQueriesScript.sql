USE HotelReservations;

-- --------------------------------------------------------------------------------
-- PROPERLY WORKING QUERIES
-- --------------------------------------------------------------------------------

-- Returns all rooms reserved for a particular customer
SELECT RoomId, Rooms.HotelId, Floor, RoomNumber
FROM Rooms
LEFT JOIN ReservationsRooms USING (RoomId)
LEFT JOIN Reservations USING (ReservationId)
WHERE CustomerId = ?;

-- Returns a list of reservations that end today
SELECT ReservationId, HotelId, CustomerId, StartDate, EndDate, InvoiceTotal, PaymentReceived, AmountDue
FROM Reservations
WHERE EndDate = '2017-07-15';

-- Returns a list of promo codes and when used
SELECT * FROM Promotions;

SELECT ReservationId, HotelId, CustomerId, Reservations.StartDate, Reservations.EndDate, PromotionCode, Promotions.StartDate AS PromotionStart, Promotions.EndDate AS PromotionEnd
FROM Reservations
INNER JOIN Promotions USING (PromotionCode)
WHERE PromotionCode = ?;  -- 145975  9111642

-- Returns the 10 most expensive bills charged.  
SELECT ReservationID, CustomerId, InvoiceTotal
FROM Reservations
ORDER BY InvoiceTotal DESC LIMIT 10;
-- BONUS: allow specific customer
SELECT ReservationId, Customers.Name, InvoiceTotal
FROM Reservations
INNER JOIN Customers USING (CustomerId)
WHERE CustomerId = ? ORDER BY InvoiceTotal DESC LIMIT 10;



-- --------------------------------------------------------------------------------
-- NOT WORKING QUERIES =(
-- --------------------------------------------------------------------------------

-- Return all rooms NOT reserved on a particular date
SELECT RoomId, Rooms.HotelId, Floor, RoomNumber
FROM Rooms
LEFT JOIN ReservationsRooms USING (RoomId)
LEFT JOIN Reservations USING (ReservationId)
WHERE '2017-07-15' < StartDate OR '2017-07-15' > EndDate;
-- Returns rooms, but not all rooms that it should


-- Returns all rooms that contain a set of amenities  BONUS: order by cheapest
SELECT RoomId, HotelId, Floor, RoomNumber, BaseCost
FROM RoomTypes
INNER JOIN Rooms USING (RoomTypeId)
INNER JOIN RoomsAmenities USING (RoomId)
INNER JOIN Amenities USING (AmenityId)
-- GROUP BY RoomId
WHERE AmenityId IN (1, 2, 3, 4, 5);
-- HAVING AmenityId = 1 AND AmenityId = 2 AND AmenityId = 3 AND AmenityId = 4 AND  AmenityId = 5;

-- HAVING AmenityId = 1 AND AmenityId = 2 AND AmenityId = 3 AND AmenityId = 4 AND  AmenityId = 5;
-- ORDER BY BaseCost ASC;
-- where column name IN;

SELECT RoomId, HotelId, Floor, RoomNumber, BaseCost
FROM RoomsAmenities
INNER JOIN Rooms USING (RoomTypeId)
LEFT JOIN RoomsAmenities USING (RoomId)
-- LEFT JOIN Amenities USING (AmenityId)
HAVING AmenityId = 1 AND AmenityId = 2 AND AmenityId = 3 AND AmenityId = 4 AND  AmenityId = 5;