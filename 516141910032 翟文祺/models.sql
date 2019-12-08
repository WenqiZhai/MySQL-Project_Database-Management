SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `mydb` ;
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Customer`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Customer` (
  `CustomerAccount` VARCHAR(45) NOT NULL ,
  `CustomerSex` ENUM( 'M', 'F' ) NULL ,
  `CustomerAge` INT NULL ,
  `CustomerPhone` VARCHAR(8) NULL ,
  `CustomerPassword` VARCHAR(16) NULL ,
  `CustomerPoints` INT NULL ,
  `CustomerDiscount` FLOAT NULL ,
  PRIMARY KEY (`CustomerAccount`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Supplier`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Supplier` (
  `SupplierAccount` VARCHAR(16) NOT NULL ,
  `SupplierName` VARCHAR(45) NULL ,
  `SupplierSex` ENUM( 'M', 'F' ) NULL ,
  `SupplierAge` INT NULL ,
  `SupplierPhone` VARCHAR(8) NULL ,
  `SupplierPassword` VARCHAR(16) NULL ,
  PRIMARY KEY (`SupplierAccount`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Good`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Good` (
  `GoodID` INT NOT NULL ,
  `GoodPrice` VARCHAR(45) NULL ,
  `GoodProductionDate` VARCHAR(45) NULL ,
  `GoodExpirationDate` VARCHAR(45) NULL ,
  `GoodType` VARCHAR(45) NULL ,
  `Transaction_TransactionID` VARCHAR(45) NOT NULL ,
  `Transaction_Customer_CustomerAccount` VARCHAR(45) NOT NULL ,
  `Supplier_SupplierAccount` VARCHAR(16) NOT NULL ,
  PRIMARY KEY (`GoodID`, `Transaction_TransactionID`, `Transaction_Customer_CustomerAccount`) ,
  INDEX `fk_Good_Supplier1_idx` (`Supplier_SupplierAccount` ASC) ,
  CONSTRAINT `fk_Good_Supplier1`
    FOREIGN KEY (`Supplier_SupplierAccount` )
    REFERENCES `mydb`.`Supplier` (`SupplierAccount` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Transaction`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Transaction` (
  `TransactionID` VARCHAR(45) NOT NULL ,
  `TransactionCount` INT NULL ,
  `TransactionAmount` INT NULL ,
  `TransactionOrderTime` DATETIME NULL ,
  `TransactionDelieverTime` DATETIME NULL ,
  `TransactionStatus` ENUM( '1', '2', '3' , '4') NULL ,
  `TransactionPoints` INT NULL ,
  `TransactionAddress` VARCHAR(45) NULL ,
  `GoodID` VARCHAR(45) NULL ,
  `CustomerAccount` VARCHAR(45) NULL ,
  `Customer_CustomerAccount` VARCHAR(45) NULL ,
  `Good_GoodID` INT NOT NULL ,
  `Good_Transaction_TransactionID` VARCHAR(45) NOT NULL ,
  `Good_Transaction_Customer_CustomerAccount` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`TransactionID`, `Good_GoodID`, `Good_Transaction_TransactionID`, `Good_Transaction_Customer_CustomerAccount`) ,
  INDEX `fk_Transaction_Customer1_idx` (`Customer_CustomerAccount` ASC) ,
  INDEX `fk_Transaction_Good1_idx` (`Good_GoodID` ASC, `Good_Transaction_TransactionID` ASC, `Good_Transaction_Customer_CustomerAccount` ASC) ,
  CONSTRAINT `fk_Transaction_Customer1`
    FOREIGN KEY (`Customer_CustomerAccount` )
    REFERENCES `mydb`.`Customer` (`CustomerAccount` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Transaction_Good1`
    FOREIGN KEY (`Good_GoodID` , `Good_Transaction_TransactionID` , `Good_Transaction_Customer_CustomerAccount` )
    REFERENCES `mydb`.`Good` (`GoodID` , `Transaction_TransactionID` , `Transaction_Customer_CustomerAccount` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CustomerComment`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`CustomerComment` (
  `CustomerAccount` VARCHAR(45) NOT NULL ,
  `GoodID` VARCHAR(45) NULL ,
  `CommentContent` VARCHAR(200) NULL ,
  `CommentTime` DATETIME NULL ,
  `CommentScore` INT NULL ,
  `Customer_CustomerAccount` VARCHAR(45) NOT NULL ,
  `Good_GoodID` INT NOT NULL ,
  `Good_Transaction_TransactionID` VARCHAR(45) NOT NULL ,
  `Good_Transaction_Customer_CustomerAccount` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`CustomerAccount`, `Customer_CustomerAccount`, `Good_GoodID`, `Good_Transaction_TransactionID`, `Good_Transaction_Customer_CustomerAccount`) ,
  INDEX `fk_CustomerComment_Customer1_idx` (`Customer_CustomerAccount` ASC) ,
  INDEX `fk_CustomerComment_Good1_idx` (`Good_GoodID` ASC, `Good_Transaction_TransactionID` ASC, `Good_Transaction_Customer_CustomerAccount` ASC) ,
  CONSTRAINT `fk_CustomerComment_Customer1`
    FOREIGN KEY (`Customer_CustomerAccount` )
    REFERENCES `mydb`.`Customer` (`CustomerAccount` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CustomerComment_Good1`
    FOREIGN KEY (`Good_GoodID` , `Good_Transaction_TransactionID` , `Good_Transaction_Customer_CustomerAccount` )
    REFERENCES `mydb`.`Good` (`GoodID` , `Transaction_TransactionID` , `Transaction_Customer_CustomerAccount` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
