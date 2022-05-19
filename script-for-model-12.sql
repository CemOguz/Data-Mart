-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema airbnb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema airbnb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `airbnb` DEFAULT CHARACTER SET utf8 ;
USE `airbnb` ;

-- -----------------------------------------------------
-- Table `airbnb`.`guests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`guests` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_type` VARCHAR(1) NOT NULL,
  `first_name` VARCHAR(35) NOT NULL,
  `last_name` VARCHAR(35) NOT NULL,
  `username` VARCHAR(20) NOT NULL,
  `password` VARCHAR(25) NOT NULL,
  `e-mail` VARCHAR(50) NOT NULL,
  `gender` TINYINT NOT NULL,
  `birthdate` DATE NOT NULL,
  `job` VARCHAR(25) NOT NULL,
  `mobile_phone` VARCHAR(20) NOT NULL,
  `booking_count` INT NULL,
  `review_score` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `e-mail_UNIQUE` (`e-mail` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`dependents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`dependents` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `guest_id` INT NOT NULL,
  `spouse` TINYINT NOT NULL,
  `children` INT NOT NULL,
  `infants` INT NOT NULL,
  `pets` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `guest_id` (`guest_id` ASC) VISIBLE,
  CONSTRAINT `key4`
    FOREIGN KEY (`guest_id`)
    REFERENCES `airbnb`.`guests` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`hosts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`hosts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_type` VARCHAR(1) NOT NULL,
  `first_name` VARCHAR(35) NOT NULL,
  `last_name` VARCHAR(35) NOT NULL,
  `username` VARCHAR(20) NOT NULL,
  `password` VARCHAR(25) NOT NULL,
  `e-mail` VARCHAR(50) NOT NULL,
  `gender` TINYINT NOT NULL,
  `birthdate` DATE NOT NULL,
  `job` VARCHAR(25) NOT NULL,
  `mobile_phone` VARCHAR(20) NOT NULL,
  `booking_count` INT NULL,
  `review_score` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `e-mail_UNIQUE` (`e-mail` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`country` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `continent` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`city` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `country_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `key1`
    FOREIGN KEY (`country_id`)
    REFERENCES `airbnb`.`country` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `host_id` INT NOT NULL,
  `street` VARCHAR(20) NOT NULL,
  `neighborhood` VARCHAR(25) NOT NULL,
  `number` INT NOT NULL,
  `postcode` VARCHAR(10) NOT NULL,
  `city_id` INT NOT NULL,
  `country_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `host_id` (`host_id` ASC) VISIBLE,
  INDEX `city_id` (`city_id` ASC) INVISIBLE,
  INDEX `country_id` (`country_id` ASC) VISIBLE,
  CONSTRAINT `fk_host_id`
    FOREIGN KEY (`host_id`)
    REFERENCES `airbnb`.`hosts` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_city_id`
    FOREIGN KEY (`city_id`)
    REFERENCES `airbnb`.`city` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_country_id`
    FOREIGN KEY (`country_id`)
    REFERENCES `airbnb`.`country` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`rules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`rules` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pets` TINYINT NOT NULL,
  `smoking` TINYINT NOT NULL,
  `late_checkout` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_rules_id` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`amenities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`amenities` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `kitchen` TINYINT NOT NULL,
  `ac` TINYINT NOT NULL,
  `heater` TINYINT NOT NULL,
  `washer` TINYINT NOT NULL,
  `dryer` TINYINT NOT NULL,
  `internet` TINYINT NOT NULL,
  `tv` TINYINT NOT NULL,
  `smart_home` TINYINT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`properties`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`properties` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sqft` INT NOT NULL,
  `rooms` INT NOT NULL,
  `security` TINYINT NOT NULL,
  `elevator` TINYINT NOT NULL,
  `gym` TINYINT NOT NULL,
  `free_parking` TINYINT NOT NULL,
  `for_handicapped` TINYINT NOT NULL,
  `pool` TINYINT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`listing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`listing` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `caption` VARCHAR(60) NOT NULL,
  `desc` TEXT NOT NULL,
  `price` INT NOT NULL,
  `adress_id` INT NOT NULL,
  `host_id` INT NOT NULL,
  `amenities_id` INT NOT NULL,
  `properties_id` INT NOT NULL,
  `rules_id` INT NOT NULL,
  `created_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_amenities_id` (`amenities_id` ASC) INVISIBLE,
  INDEX `fk_properties_id` (`properties_id` ASC) INVISIBLE,
  INDEX `fk_rules_id` (`rules_id` ASC) VISIBLE,
  CONSTRAINT `key5`
    FOREIGN KEY (`adress_id`)
    REFERENCES `airbnb`.`address` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `key6`
    FOREIGN KEY (`host_id`)
    REFERENCES `airbnb`.`hosts` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `key7`
    FOREIGN KEY (`rules_id`)
    REFERENCES `airbnb`.`rules` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `key8`
    FOREIGN KEY (`amenities_id`)
    REFERENCES `airbnb`.`amenities` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `key9`
    FOREIGN KEY (`properties_id`)
    REFERENCES `airbnb`.`properties` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`reservations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`reservations` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `guest_id` INT NOT NULL,
  `dependents_id` INT NOT NULL,
  `listing_id` INT NOT NULL,
  `rented_at` TIMESTAMP NOT NULL,
  `check_in` DATE NOT NULL,
  `check_out` DATE NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `key14`
    FOREIGN KEY (`guest_id`)
    REFERENCES `airbnb`.`guests` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `key15`
    FOREIGN KEY (`dependents_id`)
    REFERENCES `airbnb`.`dependents` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `key16`
    FOREIGN KEY (`listing_id`)
    REFERENCES `airbnb`.`listing` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`reviews_hosts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`reviews_hosts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `host_id` INT NOT NULL,
  `comment` TEXT NOT NULL,
  `stars` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `host_id` (`host_id` ASC) INVISIBLE,
  CONSTRAINT `key18`
    FOREIGN KEY (`host_id`)
    REFERENCES `airbnb`.`hosts` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`staff` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_type` VARCHAR(1) NOT NULL,
  `first_name` VARCHAR(25) NOT NULL,
  `last_name` VARCHAR(25) NOT NULL,
  `username` VARCHAR(20) NOT NULL,
  `password` VARCHAR(25) NOT NULL,
  `department` VARCHAR(25) NOT NULL,
  `position` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`deals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`deals` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `staff_id` INT NOT NULL,
  `city_id` INT NOT NULL,
  `percent_off` INT NOT NULL,
  `valid_from` DATE NOT NULL,
  `valid_until` DATE NOT NULL,
  `created_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `key2`
    FOREIGN KEY (`staff_id`)
    REFERENCES `airbnb`.`staff` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `key3`
    FOREIGN KEY (`city_id`)
    REFERENCES `airbnb`.`city` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`messaging`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`messaging` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sender_id` INT NOT NULL,
  `sender_type` VARCHAR(1) NOT NULL,
  `receiver_id` INT NOT NULL,
  `receiver_type` VARCHAR(1) NOT NULL,
  `message` TEXT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`payment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `reservation_id` INT NOT NULL,
  `listing_id` INT NOT NULL,
  `guest_id` INT NOT NULL,
  `paid_at` TIMESTAMP NULL,
  `payment_method` VARCHAR(25) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `key10`
    FOREIGN KEY (`reservation_id`)
    REFERENCES `airbnb`.`reservations` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `key11`
    FOREIGN KEY (`listing_id`)
    REFERENCES `airbnb`.`listing` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `key12`
    FOREIGN KEY (`guest_id`)
    REFERENCES `airbnb`.`guests` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`tickets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`tickets` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `guest_id` INT NOT NULL,
  `host_id` INT NOT NULL,
  `raised_by` VARCHAR(1) NOT NULL,
  `issue` TEXT NOT NULL,
  `reply` TEXT NOT NULL,
  `mark_as_solved` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `key19`
    FOREIGN KEY (`guest_id`)
    REFERENCES `airbnb`.`guests` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `key20`
    FOREIGN KEY (`host_id`)
    REFERENCES `airbnb`.`hosts` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`user_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`user_details` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_type` VARCHAR(1) NOT NULL,
  `registered_at` DATE NOT NULL,
  `last_login` TIMESTAMP NOT NULL,
  `language` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`reviews_guests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`reviews_guests` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `guest_id` INT NOT NULL,
  `comment` TEXT NOT NULL,
  `stars` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `key17`
    FOREIGN KEY (`guest_id`)
    REFERENCES `airbnb`.`guests` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`photos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`photos` (
  `id` INT NOT NULL,
  `listing_id` INT NOT NULL,
  `photo_url` VARCHAR(100) NULL,
  `created_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `key13`
    FOREIGN KEY (`listing_id`)
    REFERENCES `airbnb`.`listing` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
