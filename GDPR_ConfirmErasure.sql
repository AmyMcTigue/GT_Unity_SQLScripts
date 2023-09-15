-- Description: Query used to see the phase 1 erasure has completed on the tables 

SELECT * FROM ACCOUNTS
FULL JOIN CUSTOMERROLE ON CUSR_ACCTNO = ACCTNO 
FULL JOIN CUSTOMER ON CUS_SEQNO = CUSR_CUSTOMER

WHERE ACCTNO IN ('3084272',
'6149989',
'2592667')

-- Description: Query used to find eligible accounts for erasure
-- Must be over 6 years after finalled date with no outstanding actions on account 

SELECT acc.ACCTNO,con.CSTATUSTYPE,con.CONSUMERNO,con.CDFINAL,con.CCRITICALCODE, acc.ACPAYMETHOD ,acc.ACNAME FROM ACCOUNTS acc 
INNER JOIN CONSUMER con ON con.CACCT = acc.ACCTNO
WHERE con.CSTATUSTYPE = '40'
and exists
(
SELECT top 1 *
FROM [Gen_PreProd].[dbo].[ACCOUNTS] acct
INNER JOIN [Gen_PreProd].[dbo].[CONSUMER] cons ON cons.CACCT = acct.ACCTNO
INNER JOIN [Gen_PreProd].[dbo].[CUSTOMERROLE] crol on crol.CUSR_ACCTNO=acct.ACCTNO
INNER JOIN [Gen_PreProd].[dbo].[CUSTOMER] cust ON crol.CUSR_CUSTOMER=cust.CUS_SEQNO
WHERE cons.CDFINAL <= DATEADD(year,-6,GETDATE()) -- consumer ended 6 years ago
AND CSTATUSTYPE = '40' -- FOR FINALLED ACCOUNTS
AND acc.ACCTNO=acct.ACCTNO
)