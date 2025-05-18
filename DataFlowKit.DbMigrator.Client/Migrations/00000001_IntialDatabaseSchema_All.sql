/*
============================================================
 File        : 00000001_IntialDatabaseSchema_All.sql
 Purpose     : DDL
 Author      : Unknown
 Created On  : 2025-05-18
 Environment : All
============================================================
*/

-- Table structure for table `Amenities`
CREATE TABLE `Amenities` (
  `Id` int NOT NULL,
  `Name` varchar(1000) DEFAULT NULL,
  `Description` varchar(100) DEFAULT NULL,
  `IconLink` text DEFAULT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `ModifiedDate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IsActive` bit(1) DEFAULT b'1',
  `IsDeleted` bit(1) DEFAULT b'1',
  `CreatedBy` int DEFAULT NULL,
  `ModifiedBy` int DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `BookingTime`
CREATE TABLE `BookingTime` (
  `Id` int NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `FromTime` time DEFAULT NULL,
  `ToTime` time DEFAULT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `ModifiedDate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IsActive` bit(1) DEFAULT b'1',
  `IsDeleted` bit(1) DEFAULT b'1',
  `CreatedBy` int DEFAULT NULL,
  `ModifiedBy` int DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `City`
CREATE TABLE `City` (
  `Id` int NOT NULL,
  `Name` varchar(1000) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `ModifiedDate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IsActive` bit(1) DEFAULT b'1',
  `IsDeleted` bit(1) DEFAULT b'1',
  `CreatedBy` int DEFAULT NULL,
  `ModifiedBy` int DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `Country`
CREATE TABLE `Country` (
  `Id` int NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `ModifiedDate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IsActive` bit(1) DEFAULT b'1',
  `IsDeleted` bit(1) DEFAULT b'1',
  `CreatedBy` int DEFAULT NULL,
  `ModifiedBy` int DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `CustomerVendorChats`
CREATE TABLE `CustomerVendorChats` (
  `SentFromId` bigint DEFAULT NULL,
  `SentToId` bigint DEFAULT NULL,
  `Message` varchar(50) DEFAULT NULL,
  `IsRead` varchar(50) DEFAULT NULL,
  `ReadTime` varchar(50) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `IsActive` bit(1) DEFAULT b'1',
  `IsDeleted` bit(1) DEFAULT b'1',
  KEY `FK_CustomerVendorChats_Users` (`SentFromId`),
  KEY `FK_CustomerVendorChats_Users1` (`SentToId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `HallAmenitites`
CREATE TABLE `HallAmenitites` (
  `Id` int NOT NULL,
  `VendorId` bigint DEFAULT NULL,
  `HallId` bigint DEFAULT NULL,
  `AmenityId` int DEFAULT NULL,
  `Description` text DEFAULT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `ModifiedDate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IsActive` bit(1) DEFAULT b'1',
  `IsDeleted` bit(1) DEFAULT b'1',
  PRIMARY KEY (`Id`),
  KEY `FK_HallAmenitites_Amenities` (`AmenityId`),
  KEY `FK_HallAmenitites_Users` (`VendorId`),
  KEY `FK_HallAmenitites_VendorHalls` (`HallId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `HallBookingCustomizedMenu`
CREATE TABLE `HallBookingCustomizedMenu` (
  `HallBookingId` bigint NOT NULL,
  `MenuCategoryId` int DEFAULT NULL,
  `MenuItemId` int DEFAULT NULL,
  PRIMARY KEY (`HallBookingId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `HallBookings`
CREATE TABLE `HallBookings` (
  `Id` bigint NOT NULL,
  `VendorId` bigint DEFAULT NULL,
  `HallId` bigint DEFAULT NULL,
  `CustomerId` bigint DEFAULT NULL,
  `HallPackageId` int DEFAULT NULL,
  `TotalPrice` int DEFAULT NULL,
  `GuestCount` int DEFAULT NULL,
  `Discount` int DEFAULT NULL,
  `DiscountPercentage` int DEFAULT NULL,
  `DiscountPrice` int DEFAULT NULL,
  `BookingDate` date DEFAULT NULL,
  `BookingTimeId` int DEFAULT NULL,
  `PerHeadCost` int DEFAULT NULL,
  `TotalBookingPrice` int DEFAULT NULL,
  `BookingStatus` int DEFAULT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `ModifiedDate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IsActive` bit(1) DEFAULT b'1',
  `IsDeleted` bit(1) DEFAULT b'1',
  PRIMARY KEY (`Id`),
  KEY `FK_HallBookings_BookingTime` (`BookingTimeId`),
  KEY `FK_HallBookings_HallBookingStatus` (`BookingStatus`),
  KEY `FK_HallBookings_HallPackages` (`HallPackageId`),
  KEY `FK_HallBookings_Users` (`VendorId`),
  KEY `FK_HallBookings_Users1` (`CustomerId`),
  KEY `FK_HallBookings_VendorHalls` (`HallId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `HallBookingStatus`
CREATE TABLE `HallBookingStatus` (
  `Id` int NOT NULL,
  `Name` varchar(500) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `ModifiedDate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IsActive` bit(1) DEFAULT b'1',
  `IsDeleted` bit(1) DEFAULT b'1',
  `CreatedBy` int DEFAULT NULL,
  `ModifiedBy` int DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `HallMediaLinks`
CREATE TABLE `HallMediaLinks` (
  `Id` int NOT NULL,
  `HallId` bigint DEFAULT NULL,
  `VendorId` bigint DEFAULT NULL,
  `MediaLink` text DEFAULT NULL,
  `MediaType` int DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_HallMediaLinks_HallsMediaType` (`MediaType`),
  KEY `FK_HallMediaLinks_Users` (`VendorId`),
  KEY `FK_HallMediaLinks_VendorHalls` (`HallId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `HallMenuPrice`
CREATE TABLE `HallMenuPrice` (
  `Id` int NOT NULL,
  `VendorId` bigint DEFAULT NULL,
  `HallId` bigint DEFAULT NULL,
  `MenuCategoryId` int DEFAULT NULL,
  `MenuItemId` int DEFAULT NULL,
  `Price` float DEFAULT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `ModifiedDate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IsActive` bit(1) DEFAULT b'1',
  `IsDeleted` bit(1) DEFAULT b'1',
  PRIMARY KEY (`Id`),
  KEY `FK_HallMenuPrice_MenuCategory` (`MenuCategoryId`),
  KEY `FK_HallMenuPrice_MenuItems` (`MenuItemId`),
  KEY `FK_HallMenuPrice_Users` (`VendorId`),
  KEY `FK_HallMenuPrice_VendorHalls` (`HallId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `HallPackageComplementary`
CREATE TABLE `HallPackageComplementary` (
  `Id` int NOT NULL,
  `HallPackagesId` int DEFAULT NULL,
  `MenuCategoryId` int DEFAULT NULL,
  `MenuItemId` int DEFAULT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `ModifiedDate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IsActive` bit(1) DEFAULT b'1',
  `IsDeleted` bit(1) DEFAULT b'1',
  PRIMARY KEY (`Id`),
  KEY `FK_HallPackageComplementary_HallPackageComplementary` (`HallPackagesId`),
  KEY `FK_HallPackageComplementary_MenuCategory` (`MenuCategoryId`),
  KEY `FK_HallPackageComplementary_MenuItems` (`MenuItemId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `HallPackageMenu`
CREATE TABLE `HallPackageMenu` (
  `Id` int NOT NULL,
  `HallPackagesId` int DEFAULT NULL,
  `MenuCategoryId` int DEFAULT NULL,
  `MenuItemId` int DEFAULT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `ModifiedDate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IsActive` bit(1) DEFAULT b'1',
  `IsDeleted` bit(1) DEFAULT b'1',
  PRIMARY KEY (`Id`),
  KEY `FK_HallPackageMenu_HallPackages` (`HallPackagesId`),
  KEY `FK_HallPackageMenu_MenuCategory` (`MenuCategoryId`),
  KEY `FK_HallPackageMenu_MenuItems` (`MenuItemId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `HallPackages`
CREATE TABLE `HallPackages` (
  `Id` int NOT NULL,
  `VendorId` bigint DEFAULT NULL,
  `HallId` bigint DEFAULT NULL,
  `PackageId` int DEFAULT NULL,
  `Price` float DEFAULT NULL,
  `PackageName` text DEFAULT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `ModifiedDate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IsActive` bit(1) DEFAULT b'1',
  `IsDeleted` bit(1) DEFAULT b'1',
  PRIMARY KEY (`Id`),
  KEY `FK_HallPackages_MenuPackages` (`PackageId`),
  KEY `FK_HallPackages_Users` (`VendorId`),
  KEY `FK_HallPackages_VendorHalls` (`HallId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `HallsMediaType`
CREATE TABLE `HallsMediaType` (
  `Id` int NOT NULL,
  `MediaType` varchar(500) DEFAULT NULL,
  `PictureType` varchar(500) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `ModifiedDate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IsActive` bit(1) DEFAULT b'1',
  `IsDeleted` bit(1) DEFAULT b'1',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `MenuCategory`
CREATE TABLE `MenuCategory` (
  `Id` int NOT NULL,
  `Name` text DEFAULT NULL,
  `Description` text DEFAULT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `ModifiedDate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IsActive` bit(1) DEFAULT b'1',
  `IsDeleted` bit(1) DEFAULT b'1',
  `CreatedBy` int DEFAULT NULL,
  `ModifiedBy` int DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `MenuItems`
CREATE TABLE `MenuItems` (
  `Id` int NOT NULL,
  `Name` varchar(500) DEFAULT NULL,
  `MenuCategoryId` int DEFAULT NULL,
  `Description` varchar(500) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `ModifiedDate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IsActive` bit(1) DEFAULT b'1',
  `IsDeleted` bit(1) DEFAULT b'1',
  `CreatedBy` int DEFAULT NULL,
  `ModifiedBy` int DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_MenuItems_MenuCategory` (`MenuCategoryId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `MenuPackages`
CREATE TABLE `MenuPackages` (
  `Id` int NOT NULL,
  `Name` text DEFAULT NULL,
  `Description` text DEFAULT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `ModifiedDate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IsActive` bit(1) DEFAULT b'1',
  `IsDeleted` bit(1) DEFAULT b'1',
  `CreatedBy` int DEFAULT NULL,
  `ModifiedBy` int DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `Province`
CREATE TABLE `Province` (
  `Id` int NOT NULL,
  `Name` varchar(1000) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `ModifiedDate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IsActive` bit(1) DEFAULT b'1',
  `IsDeleted` bit(1) DEFAULT b'1',
  `CreatedBy` int DEFAULT NULL,
  `ModifiedBy` int DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `Roles`
CREATE TABLE `Roles` (
  `Id` int NOT NULL,
  `Name` varchar(250) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `ModifiedDate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IsActive` bit(1) DEFAULT b'1',
  `IsDeleted` bit(1) DEFAULT b'1',
  `CreatedBy` int DEFAULT NULL,
  `ModifiedBy` int DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `UserRoles`
CREATE TABLE `UserRoles` (
  `UserId` bigint DEFAULT NULL,
  `RoleId` int DEFAULT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `ModifiedDate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IsActive` bit(1) DEFAULT b'1',
  `IsDeleted` bit(1) DEFAULT b'1',
  KEY `FK_Roles_RoleId` (`RoleId`),
  KEY `FK_Users_UserId` (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `Users`
CREATE TABLE `Users` (
  `Id` bigint NOT NULL,
  `FirstName` text DEFAULT NULL,
  `LastName` text DEFAULT NULL,
  `LoginProvider` text DEFAULT NULL,
  `LoginProviderId` text DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `MobileNo` varchar(250) DEFAULT NULL,
  `AccessToken` text DEFAULT NULL,
  `RefreshToken` text DEFAULT NULL,
  `Pasword` text DEFAULT NULL,
  `ProfilePicture` text DEFAULT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `ModifiedDate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IsActive` bit(1) DEFAULT b'1',
  `IsDeleted` bit(1) DEFAULT b'1',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `VendorCategory`
CREATE TABLE `VendorCategory` (
  `Id` smallint NOT NULL,
  `Name` text DEFAULT NULL,
  `Description` text DEFAULT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `ModifiedDate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IsActive` bit(1) DEFAULT b'1',
  `IsDeleted` bit(1) DEFAULT b'1',
  `CreatedBy` int DEFAULT NULL,
  `ModifiedBy` int DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `VendorDetails`
CREATE TABLE `VendorDetails` (
  `UserId` bigint DEFAULT NULL,
  `CategoryId` smallint DEFAULT NULL,
  `IsVerified` bit(1) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `ModifiedDate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `FK_VendorDetails_Users` (`UserId`),
  KEY `FK_VendorDetails_VendorCategory` (`CategoryId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `VendorHallDiscounts`
CREATE TABLE `VendorHallDiscounts` (
  `Id` bigint NOT NULL,
  `VendorId` bigint DEFAULT NULL,
  `HallId` bigint DEFAULT NULL,
  `DiscountPercent` int DEFAULT NULL,
  `TotalDiscountCap` int DEFAULT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `ModifiedDate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IsActive` bit(1) DEFAULT b'1',
  `IsDeleted` bit(1) DEFAULT b'1',
  PRIMARY KEY (`Id`),
  KEY `FK_VendorHallDiscounts_Users` (`VendorId`),
  KEY `FK_VendorHallDiscounts_VendorHalls` (`HallId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `VendorHallRatings`
CREATE TABLE `VendorHallRatings` (
  `Id` bigint NOT NULL,
  `VendorId` bigint DEFAULT NULL,
  `HallId` bigint DEFAULT NULL,
  `CustomerId` bigint DEFAULT NULL,
  `Stars` float DEFAULT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `IsActive` bit(1) DEFAULT b'1',
  `IsDeleted` bit(1) DEFAULT b'1',
  PRIMARY KEY (`Id`),
  KEY `FK_VendorHallRatings_Users` (`VendorId`),
  KEY `FK_VendorHallRatings_Users1` (`CustomerId`),
  KEY `FK_VendorHallRatings_VendorHalls` (`HallId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `VendorHallReviewMediaLinks`
CREATE TABLE `VendorHallReviewMediaLinks` (
  `VendorHallReviewId` bigint DEFAULT NULL,
  `MediaLink` text DEFAULT NULL,
  KEY `FK_VendorHallReviewMediaLinks_VendorHallReviews` (`VendorHallReviewId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `VendorHallReviews`
CREATE TABLE `VendorHallReviews` (
  `Id` bigint NOT NULL,
  `VendorId` bigint DEFAULT NULL,
  `HallId` bigint DEFAULT NULL,
  `CustomerId` bigint DEFAULT NULL,
  `ParentReviewId` bigint DEFAULT NULL,
  `Comment` text DEFAULT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `IsActive` bit(1) DEFAULT b'1',
  `IsDeleted` bit(1) DEFAULT b'1',
  PRIMARY KEY (`Id`),
  KEY `FK_VendorHallReviews_Users` (`VendorId`),
  KEY `FK_VendorHallReviews_Users1` (`CustomerId`),
  KEY `FK_VendorHallReviews_VendorHalls` (`HallId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `VendorHalls`
CREATE TABLE `VendorHalls` (
  `Id` bigint NOT NULL,
  `HallName` text DEFAULT NULL,
  `ContactInfo` varchar(50) DEFAULT NULL,
  `Capacity` int DEFAULT NULL,
  `HallRentalPrice` int DEFAULT NULL,
  `HallProfilePicture` text DEFAULT NULL,
  `FacebookLink` text DEFAULT NULL,
  `InstagramLink` text DEFAULT NULL,
  `WhatsappLink` text DEFAULT NULL,
  `GoogleMapsLink` text DEFAULT NULL,
  `Longitude` float DEFAULT NULL,
  `Latitude` float DEFAULT NULL,
  `City` int DEFAULT NULL,
  `Province` int DEFAULT NULL,
  `Country` int DEFAULT NULL,
  `VendorId` bigint DEFAULT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `ModifiedDate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IsActive` bit(1) DEFAULT b'1',
  `IsDeleted` bit(1) DEFAULT b'1',
  PRIMARY KEY (`Id`),
  KEY `FK_VendorHalls_City` (`City`),
  KEY `FK_VendorHalls_Country` (`Country`),
  KEY `FK_VendorHalls_Province` (`Province`),
  KEY `FK_VendorHalls_Users` (`VendorId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Add foreign key constraints
ALTER TABLE `CustomerVendorChats`
ADD CONSTRAINT `FK_CustomerVendorChats_Users` FOREIGN KEY (`SentFromId`) REFERENCES `Users` (`Id`),
ADD CONSTRAINT `FK_CustomerVendorChats_Users1` FOREIGN KEY (`SentToId`) REFERENCES `Users` (`Id`);

ALTER TABLE `HallAmenitites`
ADD CONSTRAINT `FK_HallAmenitites_Amenities` FOREIGN KEY (`AmenityId`) REFERENCES `Amenities` (`Id`),
ADD CONSTRAINT `FK_HallAmenitites_Users` FOREIGN KEY (`VendorId`) REFERENCES `Users` (`Id`),
ADD CONSTRAINT `FK_HallAmenitites_VendorHalls` FOREIGN KEY (`HallId`) REFERENCES `VendorHalls` (`Id`);

ALTER TABLE `HallBookings`
ADD CONSTRAINT `FK_HallBookings_BookingTime` FOREIGN KEY (`BookingTimeId`) REFERENCES `BookingTime` (`Id`),
ADD CONSTRAINT `FK_HallBookings_HallBookingStatus` FOREIGN KEY (`BookingStatus`) REFERENCES `HallBookingStatus` (`Id`),
ADD CONSTRAINT `FK_HallBookings_HallPackages` FOREIGN KEY (`HallPackageId`) REFERENCES `HallPackages` (`Id`),
ADD CONSTRAINT `FK_HallBookings_Users` FOREIGN KEY (`VendorId`) REFERENCES `Users` (`Id`),
ADD CONSTRAINT `FK_HallBookings_Users1` FOREIGN KEY (`CustomerId`) REFERENCES `Users` (`Id`),
ADD CONSTRAINT `FK_HallBookings_VendorHalls` FOREIGN KEY (`HallId`) REFERENCES `VendorHalls` (`Id`);

ALTER TABLE `HallMediaLinks`
ADD CONSTRAINT `FK_HallMediaLinks_HallsMediaType` FOREIGN KEY (`MediaType`) REFERENCES `HallsMediaType` (`Id`),
ADD CONSTRAINT `FK_HallMediaLinks_Users` FOREIGN KEY (`VendorId`) REFERENCES `Users` (`Id`),
ADD CONSTRAINT `FK_HallMediaLinks_VendorHalls` FOREIGN KEY (`HallId`) REFERENCES `VendorHalls` (`Id`);

ALTER TABLE `HallMenuPrice`
ADD CONSTRAINT `FK_HallMenuPrice_MenuCategory` FOREIGN KEY (`MenuCategoryId`) REFERENCES `MenuCategory` (`Id`),
ADD CONSTRAINT `FK_HallMenuPrice_MenuItems` FOREIGN KEY (`MenuItemId`) REFERENCES `MenuItems` (`Id`),
ADD CONSTRAINT `FK_HallMenuPrice_Users` FOREIGN KEY (`VendorId`) REFERENCES `Users` (`Id`),
ADD CONSTRAINT `FK_HallMenuPrice_VendorHalls` FOREIGN KEY (`HallId`) REFERENCES `VendorHalls` (`Id`);

ALTER TABLE `HallPackageComplementary`
ADD CONSTRAINT `FK_HallPackageComplementary_HallPackageComplementary` FOREIGN KEY (`HallPackagesId`) REFERENCES `HallPackages` (`Id`),
ADD CONSTRAINT `FK_HallPackageComplementary_MenuCategory` FOREIGN KEY (`MenuCategoryId`) REFERENCES `MenuCategory` (`Id`),
ADD CONSTRAINT `FK_HallPackageComplementary_MenuItems` FOREIGN KEY (`MenuItemId`) REFERENCES `MenuItems` (`Id`);

ALTER TABLE `HallPackageMenu`
ADD CONSTRAINT `FK_HallPackageMenu_HallPackages` FOREIGN KEY (`HallPackagesId`) REFERENCES `HallPackages` (`Id`),
ADD CONSTRAINT `FK_HallPackageMenu_MenuCategory` FOREIGN KEY (`MenuCategoryId`) REFERENCES `MenuCategory` (`Id`),
ADD CONSTRAINT `FK_HallPackageMenu_MenuItems` FOREIGN KEY (`MenuItemId`) REFERENCES `MenuItems` (`Id`);

ALTER TABLE `HallPackages`
ADD CONSTRAINT `FK_HallPackages_MenuPackages` FOREIGN KEY (`PackageId`) REFERENCES `MenuPackages` (`Id`),
ADD CONSTRAINT `FK_HallPackages_Users` FOREIGN KEY (`VendorId`) REFERENCES `Users` (`Id`),
ADD CONSTRAINT `FK_HallPackages_VendorHalls` FOREIGN KEY (`HallId`) REFERENCES `VendorHalls` (`Id`);

ALTER TABLE `MenuItems`
ADD CONSTRAINT `FK_MenuItems_MenuCategory` FOREIGN KEY (`MenuCategoryId`) REFERENCES `MenuCategory` (`Id`);

ALTER TABLE `UserRoles`
ADD CONSTRAINT `FK_Roles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `Roles` (`Id`),
ADD CONSTRAINT `FK_Users_UserId` FOREIGN KEY (`UserId`) REFERENCES `Users` (`Id`);

ALTER TABLE `VendorDetails`
ADD CONSTRAINT `FK_VendorDetails_Users` FOREIGN KEY (`UserId`) REFERENCES `Users` (`Id`),
ADD CONSTRAINT `FK_VendorDetails_VendorCategory` FOREIGN KEY (`CategoryId`) REFERENCES `VendorCategory` (`Id`);

ALTER TABLE `VendorHallRatings`
ADD CONSTRAINT `FK_VendorHallRatings_Users` FOREIGN KEY (`VendorId`) REFERENCES `Users` (`Id`),
ADD CONSTRAINT `FK_VendorHallRatings_Users1` FOREIGN KEY (`CustomerId`) REFERENCES `Users` (`Id`),
ADD CONSTRAINT `FK_VendorHallRatings_VendorHalls` FOREIGN KEY (`HallId`) REFERENCES `VendorHalls` (`Id`);

ALTER TABLE `VendorHallReviewMediaLinks`
ADD CONSTRAINT `FK_VendorHallReviewMediaLinks_VendorHallReviews` FOREIGN KEY (`VendorHallReviewId`) REFERENCES `VendorHallReviews` (`Id`);

ALTER TABLE `VendorHallReviews`
ADD CONSTRAINT `FK_VendorHallReviews_Users` FOREIGN KEY (`VendorId`) REFERENCES `Users` (`Id`),
ADD CONSTRAINT `FK_VendorHallReviews_Users1` FOREIGN KEY (`CustomerId`) REFERENCES `Users` (`Id`),
ADD CONSTRAINT `FK_VendorHallReviews_VendorHalls` FOREIGN KEY (`HallId`) REFERENCES `VendorHalls` (`Id`);

ALTER TABLE `VendorHalls`
ADD CONSTRAINT `FK_VendorHalls_City` FOREIGN KEY (`City`) REFERENCES `City` (`Id`),
ADD CONSTRAINT `FK_VendorHalls_Country` FOREIGN KEY (`Country`) REFERENCES `Country` (`Id`),
ADD CONSTRAINT `FK_VendorHalls_Province` FOREIGN KEY (`Province`) REFERENCES `Province` (`Id`),
ADD CONSTRAINT `FK_VendorHalls_Users` FOREIGN KEY (`VendorId`) REFERENCES `Users` (`Id`);