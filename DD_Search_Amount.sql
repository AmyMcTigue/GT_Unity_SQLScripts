-- Description: Used for finding accounts for generating the two variants of the direct debit letter 

SELECT DISTINCT
    LPTRAN.LPT$LEDGER AS Account,
    LPTRAN_ARC.LPT$AMOUNT/100 AS ArchiveAmount,
    LPTRAN.LPT$AMOUNT/100 AS CurrentAmount,
    LETDATE AS letterDate,
	LPTRAN_ARC.LPT$DUEDATE AS ArchiveDate
FROM
    LPTRAN_ARC
    
JOIN LPTRAN ON LPTRAN_ARC.LPT$LEDGER = LPTRAN.LPT$LEDGER
JOIN CONSUMER ON LPTRAN.LPT$LEDGER = CACCT
JOIN LET_FORMATDATAARC ON CACCT = LETID_ACC
WHERE
    CSTATUSTYPE = '30'
    AND LETCODE_CODE = 'XMLBCDD'
    AND LETDATE BETWEEN '2022-09-20' AND '2023-09-21'
    AND LPTRAN_ARC.LPT$AMOUNT/100 > LPTRAN.LPT$AMOUNT/100 -- Archived <= Current for decrease/ Archived >= Current for increase

ORDER BY ArchiveDate DESC