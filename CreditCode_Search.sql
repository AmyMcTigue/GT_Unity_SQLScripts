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

	WHERE CSTATUSTYPE = '30'
	AND LR$CREDIT$CODE = 'RPC'
	AND ACRETAILER = 'OVO' -- ADD FOR RETAILER PAYM-OVO & PAYG-BST


	 
	-- PSR Comms codes 
	-- LPT - Large Print
  	-- BNW - Black & White
    -- AUD - Audio
    -- BRA - Braille
	-- RPC - Repayment Customer 
	-- BCD - Boost Customer Debt 

