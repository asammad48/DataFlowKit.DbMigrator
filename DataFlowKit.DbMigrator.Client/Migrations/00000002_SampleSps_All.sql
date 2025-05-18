/*
============================================================
 File        : 00000002_SampleSps_All.sql
 Purpose     : DDL
 Author      : Unknown
 Created On  : 2025-05-18
 Environment : All
============================================================
*/
CREATE PROCEDURE GetHallDetailsById(IN hallId BIGINT)
BEGIN
    SELECT 
        vh.Id,
        vh.HallName,
        vh.Capacity,
        vh.HallRentalPrice,
        c.Name AS City,
        p.Name AS Province,
        co.Name AS Country
    FROM 
        VendorHalls vh
    JOIN 
        City c ON vh.City = c.Id
    JOIN 
        Province p ON vh.Province = p.Id
    JOIN 
        Country co ON vh.Country = co.Id
    WHERE 
        vh.Id = hallId
        AND vh.IsActive = 1
        AND vh.IsDeleted = 0;
END;

CREATE PROCEDURE GetHallBookingDetails(
    IN hallId BIGINT,
    IN vendorId BIGINT,
    IN fromDate DATE,
    IN toDate DATE,
    IN bookingStatus INT -- Nullable parameter
)
BEGIN
    -- First result set: Hall basic info
    SELECT 
        vh.Id,
        vh.HallName,
        vh.Capacity,
        vh.HallRentalPrice
    FROM 
        VendorHalls vh
    WHERE 
        vh.Id = hallId
        AND vh.VendorId = vendorId
        AND vh.IsActive = 1
        AND vh.IsDeleted = 0;
    
    -- Second result set: Bookings for the hall
    SELECT 
        hb.Id AS BookingId,
        hb.BookingDate,
        bt.Name AS BookingTime,
        hbs.Name AS BookingStatus,
        u.FirstName AS CustomerFirstName,
        u.LastName AS CustomerLastName,
        hb.TotalBookingPrice
    FROM 
        HallBookings hb
    JOIN 
        BookingTime bt ON hb.BookingTimeId = bt.Id
    JOIN 
        HallBookingStatus hbs ON hb.BookingStatus = hbs.Id
    JOIN 
        Users u ON hb.CustomerId = u.Id
    WHERE 
        hb.HallId = hallId
        AND hb.VendorId = vendorId
        AND (hb.BookingDate BETWEEN fromDate AND toDate)
        AND (bookingStatus IS NULL OR hb.BookingStatus = bookingStatus)
        AND hb.IsActive = 1
        AND hb.IsDeleted = 0
    ORDER BY 
        hb.BookingDate, bt.FromTime;
    
    -- Third result set: Hall amenities
    SELECT 
        a.Name AS AmenityName,
        a.Description,
        a.IconLink
    FROM 
        HallAmenitites ha
    JOIN 
        Amenities a ON ha.AmenityId = a.Id
    WHERE 
        ha.HallId = hallId
        AND ha.IsActive = 1
        AND ha.IsDeleted = 0;
END;

CREATE PROCEDURE BulkInsertHallAmenities(
    IN hallId BIGINT,
    IN vendorId BIGINT,
    IN amenityIds TEXT -- Simulating table-valued parameter with comma-separated values
)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE amenityId INT;
    DECLARE commaPos INT;
    DECLARE amenityList TEXT;
    
    -- Create temporary table to hold the parsed IDs
    DROP TEMPORARY TABLE IF EXISTS temp_amenity_ids;
    CREATE TEMPORARY TABLE temp_amenity_ids (id INT);
    
    -- Parse the comma-separated string
    SET amenityList = amenityIds;
    
    WHILE LENGTH(amenityList) > 0 DO
        SET commaPos = LOCATE(',', amenityList);
        IF commaPos = 0 THEN
            SET amenityId = CAST(amenityList AS UNSIGNED);
            INSERT INTO temp_amenity_ids VALUES (amenityId);
            SET amenityList = '';
        ELSE
            SET amenityId = CAST(SUBSTRING(amenityList, 1, commaPos-1) AS UNSIGNED);
            INSERT INTO temp_amenity_ids VALUES (amenityId);
            SET amenityList = SUBSTRING(amenityList, commaPos+1);
        END IF;
    END WHILE;
    
    -- Insert into HallAmenitites
    INSERT INTO HallAmenitites (VendorId, HallId, AmenityId, CreatedDate, ModifiedDate, IsActive, IsDeleted)
    SELECT 
        vendorId,
        hallId,
        id,
        NOW(),
        NOW(),
        1,
        0
    FROM 
        temp_amenity_ids
    WHERE 
        id IN (SELECT Id FROM Amenities);
    
    -- Return the inserted records
    SELECT 
        ha.Id,
        a.Name AS AmenityName,
        a.Description
    FROM 
        HallAmenitites ha
    JOIN 
        Amenities a ON ha.AmenityId = a.Id
    WHERE 
        ha.HallId = hallId
        AND ha.VendorId = vendorId
        AND ha.IsActive = 1
        AND ha.IsDeleted = 0;
    
    -- Clean up
    DROP TEMPORARY TABLE IF EXISTS temp_amenity_ids;
END;


CREATE PROCEDURE SearchHalls(
    IN cityId INT, -- Nullable
    IN provinceId INT, -- Nullable
    IN minCapacity INT, -- Nullable
    IN maxPrice DECIMAL(10,2), -- Nullable
    IN amenities TEXT, -- Nullable comma-separated list of amenity IDs
    IN bookingDate DATE, -- Nullable
    IN bookingTimeId INT -- Nullable
)
BEGIN
    -- Main hall search query
    SELECT 
        vh.Id,
        vh.HallName,
        vh.Capacity,
        vh.HallRentalPrice,
        vh.HallProfilePicture,
        c.Name AS City,
        p.Name AS Province,
        co.Name AS Country,
        (
            SELECT AVG(Stars) 
            FROM VendorHallRatings 
            WHERE HallId = vh.Id AND IsActive = 1 AND IsDeleted = 0
        ) AS AverageRating
    FROM 
        VendorHalls vh
    JOIN 
        City c ON vh.City = c.Id
    JOIN 
        Province p ON vh.Province = p.Id
    JOIN 
        Country co ON vh.Country = co.Id
    WHERE 
        (cityId IS NULL OR vh.City = cityId)
        AND (provinceId IS NULL OR vh.Province = provinceId)
        AND (minCapacity IS NULL OR vh.Capacity >= minCapacity)
        AND (maxPrice IS NULL OR vh.HallRentalPrice <= maxPrice)
        AND vh.IsActive = 1
        AND vh.IsDeleted = 0;
    
    -- Availability check if date/time parameters are provided
    IF bookingDate IS NOT NULL THEN
        SELECT 
            hb.HallId,
            COUNT(*) AS BookedSlots
        FROM 
            HallBookings hb
        JOIN 
            HallBookingStatus hbs ON hb.BookingStatus = hbs.Id
        WHERE 
            hb.BookingDate = bookingDate
            AND (bookingTimeId IS NULL OR hb.BookingTimeId = bookingTimeId)
            AND hbs.Name != 'Cancelled' -- Assuming 'Cancelled' is a status
            AND hb.IsActive = 1
            AND hb.IsDeleted = 0
        GROUP BY 
            hb.HallId;
    END IF;
    
    -- Amenities information if amenities parameter is provided
    IF amenities IS NOT NULL AND amenities != '' THEN
        SELECT 
            ha.HallId,
            GROUP_CONCAT(a.Name SEPARATOR ', ') AS AmenityList
        FROM 
            HallAmenitites ha
        JOIN 
            Amenities a ON ha.AmenityId = a.Id
        WHERE 
            FIND_IN_SET(ha.AmenityId, amenities)
            AND ha.IsActive = 1
            AND ha.IsDeleted = 0
        GROUP BY 
            ha.HallId;
    END IF;
END;