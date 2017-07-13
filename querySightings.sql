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







-- To get all superpowers for a particular hero/villain
SELECT Superpower 
FROM HeroesAndVillains
LEFT JOIN SupersSuperpowers USING (SuperId)
INNER JOIN Superpowers USING (SuperpowerId)
WHERE SuperId = ?;



-- To get all heroes at a particular sighting
SELECT SuperId
FROM HeroesAndVillains
LEFT JOIN SupersSightings USING (SuperId)
INNER JOIN Sightings USING (SightingId)
WHERE SightingId = ?;


-- To get all sightings for a date
SELECT SightingId
FROM Sightings
WHERE SightingDate = "2017-05-08";

-- To get all locations a particular hero has been sighted at
SELECT LocationId
FROM Locations
RIGHT JOIN Sightings USING (LocationId)
RIGHT JOIN SupersSightings USING (SightingId)
INNER JOIN HeroesAndVillains USING (SuperId)
WHERE SuperId = 1;


-- To get all Heroes spotted at a particular location
SELECT SuperId
FROM Locations
RIGHT JOIN Sightings USING (LocationId)
RIGHT JOIN SupersSightings USING (SightingId)
RIGHT JOIN HeroesAndVillains USING (SuperId)
WHERE LocationId = ?;


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
