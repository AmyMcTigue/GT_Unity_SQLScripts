-- To find customers with greener add on with transaction code 

	SELECT * FROM DEBT
	WHERE DTYPE = 'AO_OSM' 

-- To find customers with greener add on without transaction code 

    SELECT * FROM ACCOUNTS_SITE#ADDON
    JOIN CONSUMER ON CONSUMER.CACCT = ACCOUNTS_SITE#ADDON.ACCTNO

    WHERE ACS$ADD$ADDON = 'AO_OVOSMART' 
    -- for accounts with no add on ACS$ADD$NXTCHGDATE IS NULL
    AND ACS$ADD$NXTCHGDATE IS NULL
    AND CSTATUSTYPE = 30