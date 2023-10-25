SELECT * FROM LEDGERPAY

WHERE LP$STATUS = '50'
--10 = Validation Pending
--50 = Active
--20 = Error (only available if the a contract exist & all manual and variable future payments are cancelled)
AND LP$METHOD = 'F'
AND LP$FIRSTPAYSENT IS NOT NULL -- Customer has made a payment 
AND LP$CANCELDATE IS NULL -- Customer has not cancelled any payment 

ORDER BY LP$LASTPAYSENT DESC