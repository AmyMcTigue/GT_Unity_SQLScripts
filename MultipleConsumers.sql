
-- Description: This query will return all accounts that have more than one consumer with a gas or electric utility type. 

SELECT
		A.ACCTNO as ACCTNO
		--,C.CONSUMERNO
		--,i.INSTALL
		--,i.IUTILITYTYPE
		--,count(*)
		,sum(case when  IUTILITYTYPE = 'G' then 1 else 0 end) NumberOfGasConsumers
		,sum(case when  IUTILITYTYPE = 'E' then 1 else 0 end) NumberOfElecConsumers
	FROM
		ACCOUNTS A
		inner join CONSUMER C ON A.ACCTNO = C.CACCT
		inner join INSTALL i ON CINSTALL = INSTALL
		OUTER APPLY (SELECT TOP 1 *
			FROM EMS_CON_CONTRACT
			WHERE CONSUMERNO = CCON_CONSUMER
			ORDER BY CACCT DESC) con
		

	WHERE C.CSTATUSTYPE < 40
		AND con.CCON_PLANID1 LIKE '%_27' 
	GROUP BY A.ACCTNO
	having
		sum(case when  IUTILITYTYPE = 'G' then 1 else 0 end) > 1 or
		sum(case when  IUTILITYTYPE = 'E' then 1 else 0 end) > 1