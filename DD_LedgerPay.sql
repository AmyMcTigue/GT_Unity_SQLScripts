-- Query used to select customers from LEDGERPAY for ADDACs file creation 

SELECT * FROM LEDGERPAY

LEFT JOIN CONSUMER ON CACCT = LP$LEDGER 
WHERE LP$STATUS = '50'
--10 = Validation Pending
--50 = Active
--20 = Error (only available if the a contract exist & all manual and variable future payments are cancelled)
AND CSTATUSTYPE = '30'
AND LP$INSTRUCTION$REF IS NOT NULL

ORDER BY LP$EFFDATE DESC
