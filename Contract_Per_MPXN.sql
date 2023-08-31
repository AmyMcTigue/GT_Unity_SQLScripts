-- Description: This query will return the contract details for the given MPXN
-- Note: ICP_IDENT is a nonvarchar field - search with strings not integers

SELECT Distinct CACCT AS Account,
                CONSUMERNO AS consumer,
                ICP_IDENT AS MPXN,
                INETWCONN AS GSP,
                IUTILITYTYPE AS UTILITY,
                con.CCON_PLANID1 AS "CONTRACT",
                con.CCON_SEQ
                FROM CONSUMER
    LEFT OUTER JOIN INSTALL ON CINSTALL = INSTALL
	LEFT OUTER JOIN CUSTOMERROLE rol ON rol.CUSR_ACCTNO = CACCT
	LEFT OUTER JOIN CUSTOMERROLE#COMM cm ON cm.CUSR_SEQNO = rol.CUSR_SEQNO
    OUTER APPLY (SELECT TOP 1 * FROM EMS_CON_CONTRACT
			WHERE CONSUMERNO = CCON_CONSUMER
			ORDER BY CCON_SEQ DESC) con
            
WHERE ICP_IDENT IN ('1417814000005',
'1417841690006',
'1417911550000',
'1418481490002',
'1418705200008')