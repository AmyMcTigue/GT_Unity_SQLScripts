SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SELECT
    LINE
FROM (
    SELECT
        ORD = 1,
        LINE = 'HDR,CLASS,INSTALL,UPDDAHISTORY,CALLMETHOD'
	UNION SELECT
        ORD = 2,
        LINE = 'COL,CLASSVALUE,Charge Class'
	UNION SELECT
        ORD = 3,
		LINE = 'DET,' + CONVERT(VARCHAR, I.INSTALL) + ',DOM' -- Change to 'DOM' For PAYM/ 'PAYG' for PAYG
		FROM ACCOUNTS A
		INNER JOIN CONSUMER C ON C.CACCT = A.ACCTNO
		INNER JOIN INSTALL I ON I.INSTALL = C.CINSTALL
		OUTER APPLY 
			(
			SELECT TOP 1 * FROM EMS_CON_CONTRACT ECC
			JOIN EMS_CON_PLAN ECP ON ECP.ECPLAN_KEY = ECC.CCON_PLANID1
			WHERE ECC.CCON_CONSUMER = C.CONSUMERNO
			AND ECC.CCON_ACTIVE != 'C'
			ORDER BY ECC.CCON_STARTDATE DESC
			) CURR
		WHERE A.ACCTNO IN ('6032862') --insert account number here
		AND C.CSTATUSTYPE < 40
		AND I.ICHGCLASS = 'DOM'
	)
LINES
ORDER BY
    ORD