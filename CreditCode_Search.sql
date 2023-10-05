-- Description: Query used for finding accounts with a specific credit code 

SELECT Distinct CACCT AS Account,
                CONSUMERNO AS consumer,
                CINSTALL AS INSTALL,
                ICP_IDENT AS MPXN,
                INETWCONN AS GSP,
                IUTILITYTYPE AS UTILITY
                FROM CONSUMER
	LEFT OUTER JOIN INSTALL ON CINSTALL = INSTALL
	LEFT OUTER JOIN CUSTOMERROLE rol ON rol.CUSR_ACCTNO = CACCT
	LEFT OUTER JOIN ACCOUNTS ON ACCTNO = CACCT
    LEFT OUTER JOIN LEDGER#CREDT$CODE ON ledgerid = CACCT
	LEFT OUTER JOIN LEDGERPAY ON LP$LEDGER = ledgerid

	WHERE CSTATUSTYPE = '30'
	AND LR$CREDIT$CODE = 'RPC'
	AND ACRETAILER = 'OVO' -- ADD FOR RETAILER PAYM-OVO & PAYG-BST
	AND LP$METHOD = 'F' -- Only used for ovo/paym customers

	-- PSR Comms codes 
	-- LPT - Large Print
  	-- BNW - Black & White
    -- AUD - Audio
    -- BRA - Braille
	-- RPC - Repayment Customer 
	-- BCD - Boost Customer Debt 

-- To see all Credit codes in use on accounts use script below 
-- SELECT DISTINCT LR$CREDIT$CODE FROM LEDGER#CREDT$CODE
-- ORDER BY LR$CREDIT$CODE ASC

