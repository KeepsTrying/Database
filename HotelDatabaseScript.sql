-- MySQL Script generated by MySQL Workbench
-- Mon 03 Jul 2017 04:13:09 AM EDT
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema HotelReservations
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema HotelReservations
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `HotelReservations` DEFAULT CHARACTER SET latin1 ;
USE `HotelReservations` ;

-- -----------------------------------------------------
-- Table `HotelReservations`.`Amenities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HotelReservations`.`Amenities` (
  `AmenityId` INT(11) NOT NULL AUTO_INCREMENT,
  `AmenityType` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`AmenityId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `HotelReservations`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HotelReservations`.`Customers` (
  `CustomerId` INT(11) NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Phone` CHAR NOT NULL,
  PRIMARY KEY (`CustomerId`),
  UNIQUE INDEX `customerId_UNIQUE` (`CustomerId` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `HotelReservations`.`Room`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HotelReservations`.`Rooms` (
  `HotelId` INT(11) NOT NULL,
  `RoomNumber` INT(11) NOT NULL,
  `Floor` INT(11) NOT NULL,
  `RoomType` INT(11) NOT NULL,
  PRIMARY KEY (`HotelId`, `RoomNumber`, `Floor`, `RoomType`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `HotelReservations`.`Room_has_Amenities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HotelReservations`.`Room_has_Amenities` (
  `Room_Table_HotelId` INT(11) NOT NULL,
  `Room_Table_RoomNumber` INT(11) NOT NULL,
  `Room_Table_Floor` INT(11) NOT NULL,
  `Amenities_AmenityId` INT(11) NOT NULL,
  `AmenityCount` INT NULL,
  PRIMARY KEY (`Room_Table_HotelId`, `Room_Table_RoomNumber`, `Room_Table_Floor`, `Amenities_AmenityId`),
  INDEX `fk_Room_Table_has_Amenities_Amenities1_idx` (`Amenities_AmenityId` ASC),
  INDEX `fk_Room_Table_has_Amenities_Room_Table1_idx` (`Room_Table_HotelId` ASC, `Room_Table_RoomNumber` ASC, `Room_Table_Floor` ASC),
  CONSTRAINT `fk_Room_Table_has_Amenities_Room_Table1`
    FOREIGN KEY (`Room_Table_HotelId` , `Room_Table_RoomNumber` , `Room_Table_Floor`)
    REFERENCES `HotelReservations`.`Room` (`HotelId` , `RoomNumber` , `Floor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Room_Table_has_Amenities_Amenities1`
    FOREIGN KEY (`Amenities_AmenityId`)
    REFERENCES `HotelReservations`.`Amenities` (`AmenityId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `HotelReservations`.`RoomTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HotelReservations`.`RoomTypes` (
  `RoomTypeId` INT NOT NULL AUTO_INCREMENT,
  `RoomType` CHAR NOT NULL,
  `MaxOccupants` INT NOT NULL,
  `BaseCost` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`RoomTypeId`),
  CONSTRAINT `fk_RoomTypeId`
    FOREIGN KEY (`RoomTypeId`)
    REFERENCES `HotelReservations`.`Room` (`RoomTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `HotelReservations`.`Hotels`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HotelReservations`.`Hotels` (
  `HotelId` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `State` VARCHAR(45) NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  `StreetAddress` VARCHAR(45) NOT NULL,
  `ZipCode` CHAR NOT NULL,
  PRIMARY KEY (`HotelId`),
  CONSTRAINT `fk_HotelId`
    FOREIGN KEY (`HotelId`)
    REFERENCES `HotelReservations`.`Room` (`HotelId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `HotelReservations`.`Promotions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HotelReservations`.`Promotions` (
  `PromotionCode` VARCHAR(25) NOT NULL,
  `Amount` DECIMAL(6,2) NOT NULL,
  `DeltaTypeId` INT NOT NULL,
  `StartDate` DATE NOT NULL,
  `EndDate` DATE NOT NULL,
  PRIMARY KEY (`PromotionCode`),
  INDEX `DeltaTypeId` (`DeltaTypeId` ASC),
  CONSTRAINT `fk_PromotionCode`
    FOREIGN KEY (`PromotionCode`)
    REFERENCES `HotelReservations`.`Reservations` (`PromotionCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
-- -----------------------------------------------------
-- Table `HotelReservations`.`Reservations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HotelReservations`.`Reservations` (
  `ReservationId` INT NOT NULL AUTO_INCREMENT,
  `HotelId` INT NOT NULL,
  `CustomerId` INT NOT NULL,
  `StartDate` DATE NOT NULL,
  `EndDate` DATE NOT NULL,
  `PromotionCode` VARCHAR(25) NULL,
  PRIMARY KEY (`ReservationId`),
  INDEX `fk_HotelId` (`HotelId` ASC),
  INDEX `fk_CustomerId` (`CustomerId` ASC),
  INDEX `fk_PromotionCode` (`PromotionCode` ASC),
  CONSTRAINT `fk_HotelId`
    FOREIGN KEY (`HotelId`)
    REFERENCES `HotelReservations`.`Hotels` (`HotelId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CustomerId`
    FOREIGN KEY (`CustomerId`)
    REFERENCES `HotelReservations`.`Customers` (`CustomerId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PromotionCode`
    FOREIGN KEY (`PromotionCode`)
    REFERENCES `HotelReservations`.`Promotions` (`PromotionCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `HotelReservations`.`Bills`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HotelReservations`.`Bills` (
  `ReservationId` INT NOT NULL,
  `InvoiceTotal` DECIMAL(7,2) NOT NULL,
  `PaymentReceived` DECIMAL(7,2) NULL DEFAULT 0.00,
  `AmountDue` DECIMAL(7,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`ReservationId`),
  CONSTRAINT `fk_ReservationId`
    FOREIGN KEY (`ReservationId`)
    REFERENCES `HotelReservations`.`Reservations` (`ReservationId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `HotelReservations`.`Guests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HotelReservations`.`Guests` (
  `GuestId` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(35) NOT NULL DEFAULT 'Minor',
  `Age` INT NULL DEFAULT 'Minor',
  PRIMARY KEY (`GuestId`));


-- -----------------------------------------------------
-- Table `HotelReservations`.`Reservations_has_Guests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HotelReservations`.`Reservations_has_Guests` (
  `Reservations_ReservationId` INT NOT NULL,
  `Guests_GuestId` INT NOT NULL,
  PRIMARY KEY (`Reservations_ReservationId`, `Guests_GuestId`),
  INDEX `fk_Reservations_has_Guests_Guests1_idx` (`Guests_GuestId` ASC),
  INDEX `fk_Reservations_has_Guests_Reservations1_idx` (`Reservations_ReservationId` ASC),
  CONSTRAINT `fk_Reservations_has_Guests_Reservations1`
    FOREIGN KEY (`Reservations_ReservationId`)
    REFERENCES `HotelReservations`.`Reservations` (`ReservationId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reservations_has_Guests_Guests1`
    FOREIGN KEY (`Guests_GuestId`)
    REFERENCES `HotelReservations`.`Guests` (`GuestId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `HotelReservations`.`DeltaTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HotelReservations`.`DeltaTypes` (
  `DeltaTypeId` INT NOT NULL,
  `DeltaType` VARCHAR(1) NOT NULL,
  PRIMARY KEY (`DeltaTypeId`),
  UNIQUE INDEX `DeltaTypeId_UNIQUE` (`DeltaTypeId` ASC),
  UNIQUE INDEX `DeltaType_UNIQUE` (`DeltaType` ASC),
  CONSTRAINT `fk_DeltaTypeId`
    FOREIGN KEY (`DeltaTypeId`)
    REFERENCES `HotelReservations`.`Promotions` (`DeltaTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `HotelReservations`.`Reservations_has_Room`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HotelReservations`.`Reservations_has_Room` (
  `Reservations_ReservationId` INT NOT NULL,
  `Room_HotelId` INT(11) NOT NULL,
  `Room_RoomNumber` INT(11) NOT NULL,
  `Room_Floor` INT(11) NOT NULL,
  `Room_RoomType` INT(11) NOT NULL,
  PRIMARY KEY (`Reservations_ReservationId`, `Room_HotelId`, `Room_RoomNumber`, `Room_Floor`, `Room_RoomType`),
  INDEX `fk_Reservations_has_Room_Room1_idx` (`Room_HotelId` ASC, `Room_RoomNumber` ASC, `Room_Floor` ASC, `Room_RoomType` ASC),
  INDEX `fk_Reservations_has_Room_Reservations1_idx` (`Reservations_ReservationId` ASC),
  CONSTRAINT `fk_Reservations_has_Room_Reservations1`
    FOREIGN KEY (`Reservations_ReservationId`)
    REFERENCES `HotelReservations`.`Reservations` (`ReservationId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reservations_has_Room_Room1`
    FOREIGN KEY (`Room_HotelId` , `Room_RoomNumber` , `Room_Floor` , `Room_RoomType`)
    REFERENCES `HotelReservations`.`Room` (`HotelId` , `RoomNumber` , `Floor` , `RoomType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `HotelReservations`.`Customers_has_Guests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HotelReservations`.`Customers_has_Guests` (
  `Customers_CustomerId` INT(11) NOT NULL,
  `Guests_GuestId` INT NOT NULL,
  PRIMARY KEY (`Customers_CustomerId`, `Guests_GuestId`),
  INDEX `fk_Customers_has_Guests_Guests1_idx` (`Guests_GuestId` ASC),
  INDEX `fk_Customers_has_Guests_Customers1_idx` (`Customers_CustomerId` ASC),
  CONSTRAINT `fk_Customers_has_Guests_Customers1`
    FOREIGN KEY (`Customers_CustomerId`)
    REFERENCES `HotelReservations`.`Customers` (`CustomerId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Customers_has_Guests_Guests1`
    FOREIGN KEY (`Guests_GuestId`)
    REFERENCES `HotelReservations`.`Guests` (`GuestId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `HotelReservations`.`BillDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HotelReservations`.`BillDetails` (
  `ReservationId` INT NOT NULL,
  `name` (255) NOT NULL,
  PRIMARY KEY (`ReservationId`),
  CONSTRAINT `fk_ReservationId`
    FOREIGN KEY (`ReservationId`)
    REFERENCES `HotelReservations`.`Bills` (`ReservationId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
