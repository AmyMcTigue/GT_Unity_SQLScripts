SELECT Distinct CACCT AS Account,
                                CONSUMERNO AS consumer,
                                CINSTALL AS INSTALL,
                                ICP_IDENT AS MPXN,
                                INETWCONN AS GSP,
                                IUTILITYTYPE AS UTILITY,
                                con.CCON_PLANID1 AS "CONTRACT",
                                con.CCON_SEQ
                                FROM CONSUMER
	LEFT OUTER JOIN INSTALL ON CINSTALL = INSTALL
	LEFT OUTER JOIN CUSTOMERROLE rol ON rol.CUSR_ACCTNO = CACCT
	LEFT OUTER JOIN CUSTOMERROLE#COMM cm ON cm.CUSR_SEQNO = rol.CUSR_SEQNO
	LEFT OUTER JOIN CCSERVICEORDER ON SOACCOUNT = CACCT
	OUTER APPLY (SELECT TOP 1 *
			FROM EMS_CON_CONTRACT
			WHERE CONSUMERNO = CCON_CONSUMER
			ORDER BY CCON_SEQ DESC) con
where CUSR_COMM$CHANNEL = '1' -- postal -- '2' - Email comms 
AND CSTATUSTYPE = '30' AND
IUTILITYTYPE = 'E' AND
con.CCON_PLANID1 LIKE 'OE_E_%_R_1_27' 
AND SOSTATUS = '91' -- SOSTATUS: 91 SOs closed

--SUFFIXES;
--OVO (OE) Warmer: 01
--OVO (OE) Warmer P2-P1: 02
--Boost (PA) and OVO (OE) Variable: 17
--Boost (PA) and OVO (OE) Variable P2-P1: 19 
--OVO (OE) Fixed : 27
--OVO (OE) Fixed 1YR : 32
--OVO (OE) Better: 11
--OVO (OE) Retention: 30