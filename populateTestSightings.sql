USE SuperheroSightings_Test;


-- Clear and add basic info to Coordinates Table
-- DELETE FROM SuperheroSightings.Coordinates WHERE CoordinateId >= 0;

-- INSERT INTO Coordinates (CoordinateId, Latitude, Longitude)
-- VALUES (1, 38.8977, -77.0365), (2, 38.8719, -77.0563), (3, 41.8789, -87.6359), (4, 40.7624, -73.9738), (5, 38.2540, -85.7484);



-- Clear and add basic info to Addresses Table
-- DELETE FROM SuperheroSightings_Test.Addresses WHERE AddressId >= 0;
-- 
-- INSERT INTO SuperheroSightings_Test.Addresses (AddressId, StreetAddress, City, State, Zip, Latitude, Longitude)
-- VALUES (1, "1600 Pennsylvania Ave NW", "Washington", "D.C.", 20500, 38.8977, -77.0365),
-- 		(2, "1000 Defense Pentagon", "Washington", "D.C.", 20301, 38.8719, -77.0563),
--         (3, "233 S Wacker Dr", "Chicago", "IL", 60606, 41.8789, -87.6359),
--         (4, "725 5th Ave", "New York", "NY", 10022, 40.7624, -73.9738),
--         (5, "252 E Market St", "Louisville", "KY", 40202, 38.2540, -85.7484);
        
 
 
-- Clear and add basic info to Locations Table
DELETE FROM SuperheroSightings_Test.Locations WHERE LocationId >= 0;

INSERT INTO SuperheroSightings_Test.Locations (LocationId, Landmark, Description, StreetAddress, City, State, Zip, Latitude, Longitude)
VALUES (1, "The White House", "Home of the United States President", "1600 Pennsylvania Ave NW", "Washington", "D.C.", 20500, 38.8977, -77.0365),
		(2, "The Pentagon", "Department of Defense Headquarters", "1000 Defense Pentagon", "Washington", "D.C.", 20301, 38.8719, -77.0563),
        (3, "Sears Tower", "Corporate office building and tourist attraction", "233 S Wacker Dr", "Chicago", "IL", 60606, 41.8789, -87.6359),
        (4, "Trump Tower", "Looks like success, smells like...", "725 5th Ave", "New York", "NY", 10022, 40.7624, -73.9738),
        (5, "The Software Guild", "Louisville Branch, developing developers", "252 E Market St", "Louisville", "KY", 40202, 38.2540, -85.7484);
        
  
  
-- Clear and add basic info to Organizations Table
DELETE FROM SuperheroSightings_Test.Organizations WHERE OrganizationId >= 0;

INSERT INTO SuperheroSightings_Test.Organizations (OrganizationId, Name, Description, LocationId)
VALUES (1, "JAVA Heroes", "POJO just sounds better", 5),
		(2, "dotNET Scum", "POCOs sounds like chalkboard scratching.  You'd turn evil too!", 5);
        
        

-- Clear and add basic info to Sightings Table
DELETE FROM SuperheroSightings_Test.Sightings WHERE SightingId >= 0;

INSERT INTO SuperheroSightings_Test.Sightings (SightingId, LocationId, SightingDate)
VALUES (1, 5, "2017-05-08"),
		(2, 1, "2017-05-08"),
        (3, 2, "2017-06-10"),
        (4, 3, "2017-06-10"),
        (5, 4, "2017-6-09");



-- Clear and add basic info to HeroesAndVillains Table
DELETE FROM SuperheroSightings_Test.HeroesAndVillains WHERE SuperId >= 0;

INSERT INTO SuperheroSightings_Test.HeroesAndVillains (SuperId, SuperName, Alias, Cover, isVillain)
VALUES (1, "Fr-austyn", "Austyn Hill", "Teacher", 0),
		(2, "Gallowayoursoul", "Alan Galloway", "Teacher", 1),
        (3, "Jenn", "Jennifer Sauer", "Student", 0),
        (4, "Matt", "Matt Weirich", "Student", 1),
        (5, "Alex", "Alex Schaper", "Student", 1);
        
        
        
-- Clear and add basic info to Superpowers Table
DELETE FROM SuperheroSightings_Test.Superpowers WHERE SuperpowerId >= 0;

INSERT INTO SuperheroSightings_Test.Superpowers (SuperpowerId, Superpower)
VALUES (1, "OOP Programming"),
		(2, "Impeccable Attire"),
		(3, "Rock Climbing"),
        (4, "Mechanical Engineering"),
		(5, "Cohort Trolling"),
        (6, "Llama Whispering");



-- Clear and add basic info to SupersSuperpowers Table
DELETE FROM SuperheroSightings_Test.SupersSuperpowers WHERE SuperId >= 0;
DELETE FROM SuperheroSightings_Test.SupersSuperpowers WHERE SuperpowerId >= 0;

INSERT INTO SuperheroSightings_Test.SupersSuperpowers (SuperId, SuperpowerId)
VALUES (1, 1), (1, 2), (1, 6),
		(2, 1), (2, 5),
		(3, 1), (3, 3), (3, 4),
        (4, 1), (4, 2),
		(5, 1), (5, 3), (5, 5);
        
	

-- Clear and add basic info to OrganizationsSupers Table
DELETE FROM SuperheroSightings_Test.OrganizationsSupers WHERE OrganizationId >= 0;
DELETE FROM SuperheroSightings_Test.OrganizationsSupers WHERE SuperId >= 0;

INSERT INTO SuperheroSightings_Test.OrganizationsSupers (OrganizationId, SuperId)
VALUES (1, 1), (1, 3),
		(2, 2), (2, 4), (2, 5);




-- Clear and add basic info to SupersSightings Table
DELETE FROM SuperheroSightings_Test.SupersSightings WHERE SuperId >= 0;
DELETE FROM SuperheroSightings_Test.SupersSightings WHERE SightingId >= 0;


INSERT INTO SuperheroSightings_Test.SupersSightings (SuperId, SightingId)
VALUES (1, 1), (2, 1), (3, 1), (4, 1), (5, 1),
		(1, 2), (2, 2),
        (2, 3), (5, 3),
		(3, 4), (4, 4),
		(2, 5), (4, 5), (5, 5);