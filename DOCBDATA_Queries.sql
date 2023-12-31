-- Queries used for GENU-1330 - Testing for Process HK.DOCBDATA

-- Total count of records in DOCBDATA table
SELECT COUNT(DOCBD$DATAID) AS DOCBDATARecords FROM DOCBDATA

-- Total count of records over 6 months old in DOCBHEADER table
SELECT COUNT(DOCBH$SEQNO) AS DOCBHEADERRecords FROM DOCBHEADER
WHERE DOCBH$SYSDATETIME <= DATEADD(DAY, -180, GETDATE())

-- Total count of records over 6 months old in DOCHEADER table with corresponding records in DOCBDATA table
SELECT COUNT(DOCBD$DATAID) AS recordsOver6Months FROM DOCBHEADER
JOIN DOCBDATA ON DOCBD$DATAID = DOCBH$DATAID
WHERE DOCBH$SYSDATETIME <= DATEADD(DAY, -180, GETDATE())

--Table that holds the next run date descriptions and information 
--SELECT * FROM EMSNEXTDATE

-- Find accounts with DOCBDATA records
SELECT TOP(100) LETID_ACC AS AccountNumber,
                CSTATUSTYPE AS AccountStatus,
                DOCBD$DATAID AS DOCBDATAid,
                DOCBH$SEQNO AS DOCBHEADERid,
                LETCODE_CODE AS LetterType, 
                DOCBH$FILENAME AS LetterFileName, 
                DOCBH$SYSDATETIME AS DOCBHEADERDate,
                LETDATE AS LetterDate,
                DOCBH$PURGEDATE AS DOCBHEADERPurgeDate,
                DOCBD$DATA AS DOCBDATARecords
                FROM DOCBHEADER
INNER JOIN DOCBDATA ON DOCBD$DATAID = DOCBH$DATAID
INNER JOIN LET_FORMATDATAARC ON LETDOCBHEADER = DOCBH$SEQNO
INNER JOIN CONSUMER ON CACCT = LETID_ACC
WHERE 
        LETID_ACC= '8574509'
        --AND DOCBH$SYSDATETIME <= DATEADD(DAY, -180, GETDATE()) -- Date over 6 months old
ORDER BY DOCBH$SYSDATETIME DESC
