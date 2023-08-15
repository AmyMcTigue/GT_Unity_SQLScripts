SELECT DISTINCT TOP(100) SOACCOUNT AS Account,
				SOTYPE AS ServiceOrder,
				SOSTATUS AS SOStatus, 
				SOLOGDATETIME AS RaisedDate
				FROM DBO.CCSERVICEORDER 

LEFT OUTER JOIN DBO.CONSUMER ON CACCT = SOACCOUNT 

WHERE SOTYPE = 'S1UKBOL|PREPAYREAD'
AND CSTATUSTYPE = '30'
AND SOSTATUS = 1

-- comment/ uncomment below line for SOs over 30 days (Change the -30 to change the number of days from today) 
AND SOLOGDATETIME < DATEADD(DAY, -30, GETDATE())

ORDER BY SOLOGDATETIME DESC

 --SOSTATUS = '0' - SO is new
 --SOSTATUS = '1' - SO is open 
 --SOSTATUS = '90' - SO is completed
 --SOSTATUS = '91' - SO is cancelled

 -- To find SO names uncomment run script below  
 -- SELECT * FROM CCSERVICEORDER_TYPE