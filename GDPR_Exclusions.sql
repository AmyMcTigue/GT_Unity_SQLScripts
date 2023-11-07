-- Description: Series of scripts used to locate accounts with potential GDPR exclusions 
-- To search prod databases change the [Gen_PreProd] to [genprod]

-- Test one - Customer or account having at least one active consumer
-- * Test two - Customer or account having at least one Pending Gain

SELECT acc.ACCTNO,con.CSTATUSTYPE,con.CONSUMERNO,con.CDFINAL,con.CCRITICALCODE, acc.ACPAYMETHOD ,acc.ACNAME FROM ACCOUNTS acc 
INNER JOIN CONSUMER con ON con.CACCT = acc.ACCTNO
WHERE con.CSTATUSTYPE !=40
AND lower(acc.ACNAME) NOT LIKE '%occupier%'
and exists
(
SELECT top 1 *
FROM [Gen_PreProd].[dbo].[ACCOUNTS] acct
INNER JOIN [Gen_PreProd].[dbo].[CONSUMER] cons ON cons.CACCT = acct.ACCTNO
INNER JOIN [Gen_PreProd].[dbo].[LEDGER#CREDT$CODE] led ON led.ledgerid  = cons.CACCT
INNER JOIN [Gen_PreProd].[dbo].[CUSTOMERROLE] crol on crol.CUSR_ACCTNO=acct.ACCTNO
INNER JOIN [Gen_PreProd].[dbo].[CUSTOMER] cust ON crol.CUSR_CUSTOMER=cust.CUS_SEQNO
WHERE cons.CDFINAL <= DATEADD(year,-6,GETDATE()) -- consumer ended 6 years ago
AND CSTATUSTYPE= '40' -- FOR FINALLED ACCOUNTS
--AND CSTATUSTYPE= '20' -- * FOR PENDING ACCOUNTS
AND acc.ACCTNO=acct.ACCTNO
--AND LR$CREDIT$CODE = 'UOCC' -- ADD FOR UNKNOWN  OCCUPIER ACCOUNT ON PREPROD 
)

-- Test 3 - At least one active occupier account/consumer on vacant occupier account

SELECT acc.ACCTNO,con.CSTATUSTYPE,con.CONSUMERNO,con.CDFINAL,con.CCRITICALCODE, acc.ACPAYMETHOD,acc.ACNAME FROM ACCOUNTS acc
INNER JOIN CONSUMER con ON con.CACCT = acc.ACCTNO
WHERE con.CSTATUSTYPE !=40
AND lower(acc.ACNAME) LIKE '%occupier%'
and exists
(
SELECT top 1 *
FROM [Gen_PreProd].[dbo].[ACCOUNTS] acct
INNER JOIN [Gen_PreProd].[dbo].[CONSUMER] cons ON cons.CACCT = acct.ACCTNO
INNER JOIN [Gen_PreProd].[dbo].[CUSTOMERROLE] crol on crol.CUSR_ACCTNO=acct.ACCTNO
INNER JOIN [Gen_PreProd].[dbo].[CUSTOMER] cust ON crol.CUSR_CUSTOMER=cust.CUS_SEQNO
WHERE cons.CDFINAL <= DATEADD(year,-6,GETDATE()) -- consumer ended 6 years ago
AND CSTATUSTYPE= '40'
AND acc.ACCTNO=acct.ACCTNO
)

-- Test 4 - excluded as above senarios should cover At least one Incomplete COT

--Test 5 - Legal/Dispute case is pending

SELECT acct.ACCTNO,acct.ACNAME,cons.CSTATUSTYPE,cons.CONSUMERNO,cons.CDFINAL,cons.CCRITICALCODE, acct.ACPAYMETHOD
FROM [Gen_PreProd].[dbo].[ACCOUNTS] acct
INNER JOIN [Gen_PreProd].[dbo].[CONSUMER] cons ON cons.CACCT = acct.ACCTNO
INNER JOIN [Gen_PreProd].[dbo].[CUSTOMERROLE] crol on crol.CUSR_ACCTNO=acct.ACCTNO
INNER JOIN [Gen_PreProd].[dbo].[CUSTOMER] cust ON crol.CUSR_CUSTOMER=cust.CUS_SEQNO
WHERE cons.CDFINAL <= DATEADD(year,-6,GETDATE()) -- consumer ended 6 years ago
AND CSTATUSTYPE= '40'
AND exists
(
SELECT top 1* from [Gen_PreProd].[dbo].[ARGMASTER] ARM where ARM.ARG_LEDGER = acct.ACCTNO
AND ARM.ARG_STATUS in (1,2,3) --Active,Future,broken
AND ARM.ARG_TYPE=0 --Dispute
)

-- Test 6 - excluded as open complaints not available on GT - should be an external document 

--Test 7 - Active Payment arrangement

SELECT acct.ACCTNO,acct.ACNAME,cons.CSTATUSTYPE,cons.CONSUMERNO,cons.CDFINAL,cons.CCRITICALCODE, acct.ACPAYMETHOD
FROM [Gen_PreProd].[dbo].[ACCOUNTS] acct
INNER JOIN [Gen_PreProd].[dbo].[CONSUMER] cons ON cons.CACCT = acct.ACCTNO
INNER JOIN [Gen_PreProd].[dbo].[CUSTOMERROLE] crol on crol.CUSR_ACCTNO=acct.ACCTNO
INNER JOIN [Gen_PreProd].[dbo].[CUSTOMER] cust ON crol.CUSR_CUSTOMER=cust.CUS_SEQNO
WHERE cons.CDFINAL <= DATEADD(year,-6,GETDATE()) -- consumer ended 6 years ago
AND CSTATUSTYPE= '40'
AND exists
(
SELECT top 1* from [Gen_PreProd].[dbo].[ARGMASTER] ARM where ARM.ARG_LEDGER = acct.ACCTNO
AND ARM.ARG_STATUS in (1,2,3) --Active,Future,broken
AND ARM.ARG_TYPE in (1,2,3,4,5)
)

-- Test 8 - Direct debit is still active.

SELECT acct.ACCTNO,acct.ACNAME,cons.CSTATUSTYPE,cons.CONSUMERNO,cons.CDFINAL,cons.CCRITICALCODE, acct.ACPAYMETHOD
FROM [genprod].[dbo].[ACCOUNTS] acct
INNER JOIN [genprod].[dbo].[CONSUMER] cons ON cons.CACCT = acct.ACCTNO
INNER JOIN [genprod].[dbo].[CUSTOMERROLE] crol on crol.CUSR_ACCTNO=acct.ACCTNO
INNER JOIN [genprod].[dbo].[CUSTOMER] cust ON crol.CUSR_CUSTOMER=cust.CUS_SEQNO
WHERE cons.CDFINAL <= DATEADD(year,-6,GETDATE()) -- consumer ended 6 years ago
AND CSTATUSTYPE= '40'
AND exists
(
SELECT top 1* from [genprod].[dbo].[LEDGERPAY] LPY where LPY.LP$LEDGER = acct.ACCTNO
AND LPY.LP$STATUS = '50' --Active Direct Debit
)

-- Test 9 - Accounts ended but Final bill not Generated or Incomplete

SELECT acct.ACCTNO,acct.ACNAME,cons.CSTATUSTYPE,cons.CONSUMERNO,cons.CDFINAL,cons.CCRITICALCODE, acct.ACPAYMETHOD
 FROM [Gen_PreProd].[dbo].[ACCOUNTS] acct
 INNER JOIN [Gen_PreProd].[dbo].[CONSUMER] cons ON cons.CACCT = acct.ACCTNO
 INNER JOIN [Gen_PreProd].[dbo].[CUSTOMERROLE] crol on crol.CUSR_ACCTNO=acct.ACCTNO
 INNER JOIN [Gen_PreProd].[dbo].[CUSTOMER] cust ON crol.CUSR_CUSTOMER=cust.CUS_SEQNO
 WHERE cons.CDFINAL <= DATEADD(year,-6,GETDATE()) -- consumer ended 6 years ago
 AND CSTATUSTYPE= '40'
 AND not exists
(
SELECT top 1* from [Gen_PreProd].[dbo].[GBSTATEMENT] Gbs where gbs.gbstype = 'F'and GBS.GBSACCOUNT =acct.ACCTNO
)
and not exists
(
SELECT top 1* FROM [Gen_PreProd].[dbo].[ACCOUNTS] acc
INNER JOIN [Gen_PreProd].[dbo].[CONSUMER] con ON con.CACCT = acc.ACCTNO
WHERE con.CSTATUSTYPE !=40
and acc.ACCTNO =acct.ACCTNO
)

-- Test 10 - Refund pending

SELECT acct.ACCTNO,acct.ACNAME,cons.CSTATUSTYPE,cons.CONSUMERNO,cons.CDFINAL,cons.CCRITICALCODE, acct.ACPAYMETHOD,led.LR$BAL
FROM [Gen_PreProd].[dbo].[ACCOUNTS] acct
INNER JOIN [Gen_PreProd].[dbo].[CONSUMER] cons ON cons.CACCT = acct.ACCTNO
INNER JOIN [Gen_PreProd].[dbo].[CUSTOMERROLE] crol on crol.CUSR_ACCTNO=acct.ACCTNO
INNER JOIN [Gen_PreProd].[dbo].[CUSTOMER] cust ON crol.CUSR_CUSTOMER=cust.CUS_SEQNO
INNER JOIN [Gen_PreProd].[dbo].[LEDGER] led on led.LEDGERID = acct.ACCTNO
WHERE cons.CDFINAL <= DATEADD(year,-6,GETDATE()) -- consumer ended 6 years ago
AND CSTATUSTYPE= '40'
AND led.LR$BAL < 0

-- Test 11 - Write off pending 

SELECT acct.ACCTNO,acct.ACNAME,cons.CSTATUSTYPE,cons.CONSUMERNO,cons.CDFINAL,cons.CCRITICALCODE, acct.ACPAYMETHOD,led.LR$BAL
FROM [Gen_PreProd].[dbo].[ACCOUNTS] acct
INNER JOIN [Gen_PreProd].[dbo].[CONSUMER] cons ON cons.CACCT = acct.ACCTNO
INNER JOIN [Gen_PreProd].[dbo].[CUSTOMERROLE] crol on crol.CUSR_ACCTNO=acct.ACCTNO
INNER JOIN [Gen_PreProd].[dbo].[CUSTOMER] cust ON crol.CUSR_CUSTOMER=cust.CUS_SEQNO
INNER JOIN [Gen_PreProd].[dbo].[LEDGER] led on led.LEDGERID = acct.ACCTNO
WHERE cons.CDFINAL <= DATEADD(year,-6,GETDATE()) -- consumer ended 6 years ago
AND CSTATUSTYPE= '40'
AND led.LR$BAL > 0

-- Test 13 - Customer never billed (Unbilled)

SELECT acct.ACCTNO,acct.ACNAME,cons.CSTATUSTYPE,cons.CONSUMERNO,cons.CDFINAL,cons.CCRITICALCODE, acct.ACPAYMETHOD
FROM [Gen_PreProd].[dbo].[ACCOUNTS] acct
INNER JOIN [Gen_PreProd].[dbo].[CONSUMER] cons ON cons.CACCT = acct.ACCTNO
INNER JOIN [Gen_PreProd].[dbo].[CUSTOMERROLE] crol on crol.CUSR_ACCTNO=acct.ACCTNO
INNER JOIN [Gen_PreProd].[dbo].[CUSTOMER] cust ON crol.CUSR_CUSTOMER=cust.CUS_SEQNO
WHERE cons.CDFINAL <= DATEADD(year,-6,GETDATE()) -- consumer ended 6 years ago
AND CSTATUSTYPE= '40'
AND not exists
(
SELECT top 1* from [Gen_PreProd].[dbo].[GBSTATEMENT] Gbs where GBS.GBSACCOUNT =acct.ACCTNO
--gbs.gbstype = 'F'
)