USE SuperheroSightings;

-- SELECT * FROM Coordinates;


SELECT * FROM Addresses;

SELECT * FROM Locations;

SELECT * FROM Organizations;

SELECT * FROM Sightings;

SELECT * FROM HeroesAndVillains; -- WHERE isVillain = 1;

SELECT SuperId, Alias, Superpower 
FROM HeroesAndVillains
LEFT JOIN SupersSuperpowers USING (SuperId)
INNER JOIN Superpowers USING (SuperpowerId)
WHERE SuperId = 1;



SELECT Name, SuperName
FROM Organizations
LEFT JOIN OrganizationsSupers USING (OrganizationId)
INNER JOIN HeroesAndVillains USING (SuperId)
WHERE OrganizationId = 2;


SELECT * FROM SupersSightings;


SELECT Landmark, SightingDate, Alias
FROM HeroesAndVillains
LEFT JOIN SupersSightings USING (SuperId)
INNER JOIN Sightings USING (SightingId)
LEFT JOIN Locations USING (LocationId)
WHERE SightingId = 1;

-- to get all sightings at a location
SELECT * FROM Sightings WHERE LocationId = ?;

SELECT SightingId, LocationId, SightingDate
FROM Sightings
LEFT JOIN SupersSightings USING (SightingId)
LEFT JOIN HeroesAndVillains USING (SuperId)
WHERE SuperId = ?;



-- To get all superpowers for a particular hero/villain
SELECT SuperpowerId, Superpower
FROM Superpowers
LEFT JOIN SupersSuperpowers USING (SuperpowerId)
LEFT JOIN HeroesAndVillains USING (SuperId)
WHERE SuperId = ?;


SELECT SuperpowerId, Superpower
From HeroesAndVillains;



-- to add a superpower to a superhuman
INSERT INTO SupersSuperpowers (SuperId, SuperpowerId)
VALUES (5, 2);


-- to remove a superpower from a superhuman
DELETE FROM SupersSuperpowers
WHERE SuperId = 1 AND SuperpowerId = 2;

DELETE FROM Superpowers
WHERE SuperpowerId = 2;

SELECT * FROM Superpowers;


-- To get all Superhumans with Superpower
USE SuperheroSightings;
SELECT SuperId, SuperName, Alias, Cover, isVillain
FROM HeroesAndVillains
LEFT JOIN SupersSuperpowers USING (SuperId)
LEFT JOIN Superpowers USING (SuperpowerId)
WHERE SuperpowerId = 2;


-- to remove superpower from all superhumans
DELETE FROM SupersSuperpowers
WHERE SuperpowerId = 3;

SELECT * FROM SupersSuperpowers;

-- To get all superpower IDs for a particular hero/villain
SELECT Superpower
FROM HeroesAndVillains
LEFT JOIN SupersSuperpowers USING (SuperId)
INNER JOIN Superpowers USING (SuperpowerId)
WHERE SuperId = ?;

-- to get the 10 most recent sightings
SELECT * FROM Sightings ORDER BY SightingDate DESC LIMIT 10;



-- To get all heroes at a particular sighting
SELECT SuperName
FROM HeroesAndVillains
LEFT JOIN SupersSightings USING (SuperId)
INNER JOIN Sightings USING (SightingId)
WHERE SightingId = 2;

SELECT SuperName, SuperId
FROM Sightings
RIGHT JOIN SupersSightings USING (SightingId)
RIGHT JOIN HeroesAndVillains USING (SuperId)
WHERE SightingId = 1;





-- To get all sightings for a date
SELECT SightingId
FROM Sightings
WHERE SightingDate = "2017-05-08";

-- To get all locations a particular hero has been sighted at
SELECT LocationId, Landmark, Description, StreetAddress, City, State, Zip, Latitude, Longitude
FROM Locations
LEFT JOIN Sightings USING (LocationId)
LEFT JOIN SupersSightings USING (SightingId)
LEFT JOIN HeroesAndVillains USING (SuperId)
WHERE SuperId = ?;


-- To get all Heroes spotted at a particular location
SELECT SuperId
FROM Locations
RIGHT JOIN Sightings USING (LocationId)
RIGHT JOIN SupersSightings USING (SightingId)
RIGHT JOIN HeroesAndVillains USING (SuperId)
WHERE LocationId = 1;


-- To get all organizations a particular superhero belongs to
SELECT OrganizationId
FROM HeroesAndVillains
LEFT JOIN OrganizationsSupers USING (SuperId)
INNER JOIN Organizations USING (OrganizationId)
WHERE SuperId = ?;


-- To get all heroes in a particular Organization
SELECT SuperId
FROM Organizations
LEFT JOIN OrganizationsSupers USING (OrganizationId)
INNER JOIN HeroesAndVillains USING (SuperId)
WHERE OrganizationId = ?;

-- get organization id + name,  get hero id + name for membership
USE SuperheroSightings_Test;
SELECT OrganizationId, Name, SuperId, SuperName
FROM Organizations
LEFT JOIN OrganizationsSupers USING (OrganizationId)
LEFT JOIN HeroesAndVillains USING (SuperId)
WHERE OrganizationId = ?;

-- get single membership
SELECT OrganizationId, Name, SuperId, SuperName
FROM Organizations
LEFT JOIN OrganizationsSupers USING (OrganizationId)
LEFT JOIN HeroesAndVillains USING (SuperId)
WHERE OrganizationId = ? AND SuperId = ?;
