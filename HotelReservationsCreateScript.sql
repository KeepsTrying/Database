SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema HotelReservations
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `HotelReservations` ;

-- -----------------------------------------------------
-- Schema HotelReservations
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `HotelReservations` DEFAULT CHARACTER SET latin1 ;
USE `HotelReservations` ;

-- -----------------------------------------------------
-- Table `HotelReservations`.`Amenities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HotelReservations`.`Amenities` ;

CREATE TABLE IF NOT EXISTS `HotelReservations`.`Amenities` (
  `AmenityId` INT(11) NOT NULL AUTO_INCREMENT,
  `AmenityType` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`AmenityId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `HotelReservations`.`Customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HotelReservations`.`Customers` ;

CREATE TABLE IF NOT EXISTS `HotelReservations`.`Customers` (
  `CustomerId` INT(11) NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Phone` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`CustomerId`),
  UNIQUE INDEX `customerId_UNIQUE` (`CustomerId` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `HotelReservations`.`Hotels`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HotelReservations`.`Hotels` ;

CREATE TABLE IF NOT EXISTS `HotelReservations`.`Hotels` (
  `HotelId` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `State` VARCHAR(45) NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  `StreetAddress` VARCHAR(45) NOT NULL,
  `ZipCode` CHAR(5) NOT NULL,
  PRIMARY KEY (`HotelId`));


-- -----------------------------------------------------
-- Table `HotelReservations`.`RoomTypes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HotelReservations`.`RoomTypes` ;

CREATE TABLE IF NOT EXISTS `HotelReservations`.`RoomTypes` (
  `RoomTypeId` INT NOT NULL AUTO_INCREMENT,
  `RoomType` VARCHAR(20) NOT NULL,
  `MaxOccupants` INT NOT NULL,
  `BaseCost` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`RoomTypeId`));


-- -----------------------------------------------------
-- Table `HotelReservations`.`Rooms`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HotelReservations`.`Rooms` ;

CREATE TABLE IF NOT EXISTS `HotelReservations`.`Rooms` (
  `RoomId` INT NOT NULL AUTO_INCREMENT,
  `HotelId` INT NOT NULL,
  `Floor` INT NOT NULL,
  `RoomNumber` INT NOT NULL,
  `RoomTypeId` INT NOT NULL,
  PRIMARY KEY (`RoomId`),
  INDEX `fk_HotelId_idx` (`HotelId` ASC),
  INDEX `fk_RoomTypeId_idx` (`RoomTypeId` ASC),
  CONSTRAINT `fk_HotelId`
    FOREIGN KEY (`HotelId`)
    REFERENCES `HotelReservations`.`Hotels` (`HotelId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RoomTypeId`
    FOREIGN KEY (`RoomTypeId`)
    REFERENCES `HotelReservations`.`RoomTypes` (`RoomTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `HotelReservations`.`RoomsAmenities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HotelReservations`.`RoomsAmenities` ;

CREATE TABLE IF NOT EXISTS `HotelReservations`.`RoomsAmenities` (
  `RoomId` INT NOT NULL,
  `AmenityId` INT NOT NULL,
  `AmenityCount` INT NULL,
  PRIMARY KEY (`RoomId`, `AmenityId`),
  INDEX `fk_AmenityId` (`AmenityId` ASC),
  INDEX `fk_RoomId` (`RoomId` ASC),
  CONSTRAINT `fk_RoomId`
    FOREIGN KEY (`RoomId`)
    REFERENCES `HotelReservations`.`Rooms` (`HotelId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AmenityId`
    FOREIGN KEY (`AmenityId`)
    REFERENCES `HotelReservations`.`Amenities` (`AmenityId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `HotelReservations`.`DeltaTypes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HotelReservations`.`DeltaTypes` ;

CREATE TABLE IF NOT EXISTS `HotelReservations`.`DeltaTypes` (
  `DeltaTypeId` INT NOT NULL,
  `DeltaType` VARCHAR(1) NOT NULL,
  PRIMARY KEY (`DeltaTypeId`));


-- -----------------------------------------------------
-- Table `HotelReservations`.`Promotions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HotelReservations`.`Promotions` ;

CREATE TABLE IF NOT EXISTS `HotelReservations`.`Promotions` (
  `PromotionCode` INT NOT NULL,
  `Amount` DECIMAL(6,2) NOT NULL,
  `DeltaTypeId` INT NOT NULL,
  `StartDate` DATE NOT NULL,
  `EndDate` DATE NOT NULL,
  PRIMARY KEY (`PromotionCode`),
  INDEX `fk_DeltaTypeId_idx` (`DeltaTypeId` ASC),
  CONSTRAINT `fk_DeltaTypeId`
    FOREIGN KEY (`DeltaTypeId`)
    REFERENCES `HotelReservations`.`DeltaTypes` (`DeltaTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `HotelReservations`.`Reservations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HotelReservations`.`Reservations` ;

CREATE TABLE IF NOT EXISTS `HotelReservations`.`Reservations` (
  `ReservationId` INT NOT NULL AUTO_INCREMENT,
  `HotelId` INT NOT NULL,
  `CustomerId` INT NOT NULL,
  `StartDate` DATE NOT NULL,
  `EndDate` DATE NOT NULL,
  `PromotionCode` INT NULL,
  `InvoiceTotal` DECIMAL(7,2) NULL DEFAULT 0.00,
  `PaymentReceived` DECIMAL(7,2) NULL DEFAULT 0.00,
  `AmountDue` DECIMAL(7,2) NULL DEFAULT 0.00,
  PRIMARY KEY (`ReservationId`),
  INDEX `fk_HotelId_idx` (`HotelId` ASC),
  INDEX `fk_CustomerId_idx` (`CustomerId` ASC),
  INDEX `fk_PromotionCode_idx` (`PromotionCode` ASC),
  CONSTRAINT `fk_ReservationHotelId`
    FOREIGN KEY (`HotelId`)
    REFERENCES `HotelReservations`.`Hotels` (`HotelId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ReservationCustomerId`
    FOREIGN KEY (`CustomerId`)
    REFERENCES `HotelReservations`.`Customers` (`CustomerId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ReservationPromotionCode`
    FOREIGN KEY (`PromotionCode`)
    REFERENCES `HotelReservations`.`Promotions` (`PromotionCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `HotelReservations`.`Guests`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HotelReservations`.`Guests` ;

CREATE TABLE IF NOT EXISTS `HotelReservations`.`Guests` (
  `GuestId` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(35) NOT NULL DEFAULT 'Minor',
  `Age` INT NULL,
  PRIMARY KEY (`GuestId`));


-- -----------------------------------------------------
-- Table `HotelReservations`.`ReservationsGuests`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HotelReservations`.`ReservationsGuests` ;

CREATE TABLE IF NOT EXISTS `HotelReservations`.`ReservationsGuests` (
  `ReservationId` INT NOT NULL,
  `GuestId` INT NOT NULL,
  PRIMARY KEY (`ReservationId`, `GuestId`),
  INDEX `fk_GuestId` (`GuestId` ASC),
  INDEX `fk_ReservationId` (`ReservationId` ASC),
  CONSTRAINT `fk_ReservationId`
    FOREIGN KEY (`ReservationId`)
    REFERENCES `HotelReservations`.`Reservations` (`ReservationId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_GuestId`
    FOREIGN KEY (`GuestId`)
    REFERENCES `HotelReservations`.`Guests` (`GuestId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `HotelReservations`.`ReservationsRooms`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HotelReservations`.`ReservationsRooms` ;

CREATE TABLE IF NOT EXISTS `HotelReservations`.`ReservationsRooms` (
  `ReservationRoomId` INT NOT NULL,
  `ReservationId` INT NOT NULL,
  `RoomId` INT NOT NULL,
  PRIMARY KEY (`ReservationRoomId`),
  INDEX `fl_RoomId_idx` (`RoomId` ASC),
  INDEX `fk_ReservationId_idx` (`ReservationId` ASC),
  CONSTRAINT `fk_ReservationsRoomId`
    FOREIGN KEY (`ReservationId`)
    REFERENCES `HotelReservations`.`Reservations` (`ReservationId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fl_RoomsReservationId`
    FOREIGN KEY (`RoomId`)
    REFERENCES `HotelReservations`.`Rooms` (`RoomId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `HotelReservations`.`CustomersGuests`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HotelReservations`.`CustomersGuests` ;

CREATE TABLE IF NOT EXISTS `HotelReservations`.`CustomersGuests` (
  `CustomerId` INT(11) NOT NULL,
  `GuestId` INT NOT NULL,
  PRIMARY KEY (`CustomerId`, `GuestId`),
  INDEX `fk_CGGuestId` (`GuestId` ASC),
  INDEX `fk_CGCustomerId` (`CustomerId` ASC),
  CONSTRAINT `fk_CGCustomerId`
    FOREIGN KEY (`CustomerId`)
    REFERENCES `HotelReservations`.`Customers` (`CustomerId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CGGuestId`
    FOREIGN KEY (`GuestId`)
    REFERENCES `HotelReservations`.`Guests` (`GuestId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `HotelReservations`.`BillDetails`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HotelReservations`.`BillDetails` ;

CREATE TABLE IF NOT EXISTS `HotelReservations`.`BillDetails` (
  `BillDetailsId` INT NOT NULL AUTO_INCREMENT,
  `ReservationId` INT NOT NULL,
  `ReservationRoomId` INT NOT NULL,
  `Date` DATE NOT NULL,
  `RoomCharge` DECIMAL(7,2) NOT NULL,
  PRIMARY KEY (`BillDetailsId`),
  INDEX `fk_ReservationId_idx` (`ReservationId` ASC),
  INDEX `fk_ReservationRoomId_idx` (`ReservationRoomId` ASC),
  CONSTRAINT `fk_BDReservationId`
    FOREIGN KEY (`ReservationId`)
    REFERENCES `HotelReservations`.`Reservations` (`ReservationId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_BDReservationRoomId`
    FOREIGN KEY (`ReservationRoomId`)
    REFERENCES `HotelReservations`.`ReservationsRooms` (`ReservationRoomId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
COMMENT = 'Constraint ReservationRoomDate UNIQUE (Date, ReservationRoomId)';


-- -----------------------------------------------------
-- Table `HotelReservations`.`ConvenienceTypes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HotelReservations`.`ConvenienceTypes` ;

CREATE TABLE IF NOT EXISTS `HotelReservations`.`ConvenienceTypes` (
  `ConvenienceTypeId` INT NOT NULL AUTO_INCREMENT,
  `ConvenienceType` VARCHAR(25) NOT NULL,
  `ConvenienceTypeCost` DECIMAL(7,2) NOT NULL,
  PRIMARY KEY (`ConvenienceTypeId`));


-- -----------------------------------------------------
-- Table `HotelReservations`.`Conveniences`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HotelReservations`.`Conveniences` ;

CREATE TABLE IF NOT EXISTS `HotelReservations`.`Conveniences` (
  `BillDetailsId` INT NOT NULL,
  `ConvenienceType` INT NOT NULL,
  `ConvenienceCost` DECIMAL(7,2) NULL DEFAULT 0.00,
  INDEX `fk_ConvenienceTypeId_idx` (`ConvenienceType` ASC),
  CONSTRAINT `fk_BillDetailsId`
    FOREIGN KEY (`BillDetailsId`)
    REFERENCES `HotelReservations`.`BillDetails` (`BillDetailsId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ConvenienceTypeId`
    FOREIGN KEY (`ConvenienceType`)
    REFERENCES `HotelReservations`.`ConvenienceTypes` (`ConvenienceTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
