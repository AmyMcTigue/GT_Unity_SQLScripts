-- Description: Queries used for searching the database for specific information
-- Used for GENU-1395 

SELECT * FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME LIKE '%fusa%'; 

SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME LIKE '%fusa%'
ORDER BY TABLE_NAME;

EXEC sp_spaceused [FMMESSAGEHDR_FUSA] ;
EXEC sp_spaceused [DAMETHISTORY_FUSA] ;
EXEC sp_spaceused [MRI_CONDITION_FUSA] ;
EXEC sp_spaceused [MRI_INSTALL_FUSA] ;
EXEC sp_spaceused [LET_FORMATDATA_FUSA] ;
EXEC sp_spaceused [LET_FORMATDATA_ERROR_FUSA] ;
EXEC sp_spaceused [LET_FORMATDATAARC_FUSA] ;
EXEC sp_spaceused [EMS_MEMO_FUSA] ;
EXEC sp_spaceused [DAHISTORY_FUSA] ;
EXEC sp_spaceused [FUSA_Expected] ;
EXEC sp_spaceused [GBREGHIST_FUSA] ;
EXEC sp_spaceused [GBBILLREG_FUSA] ;
EXEC sp_spaceused [GDSGBHEADER_FUSA] ;
EXEC sp_spaceused [FMTRANSIN_FUSA] ;
EXEC sp_spaceused [FMTRANS_FUSA] ;
EXEC sp_spaceused [FUSA_Deletion_Hierarchy] ;
EXEC sp_spaceused [DOCBHEADER_FUSA] ;
EXEC sp_spaceused [FUSA_Deletion_Category] ;
EXEC sp_spaceused [GBHEADER_FUSA] ;
EXEC sp_spaceused [FUSA_Deletion_Entity] ;
EXEC sp_spaceused [FMTRANSHDR_FUSA] ;
EXEC sp_spaceused [DOCBDATA_FUSA] ;
EXEC sp_spaceused [FUSA_Run] ;
EXEC sp_spaceused [FMTRANSDATAIN_FUSA] ;
EXEC sp_spaceused [DAHISTORY_GENU1198_FUSA] ;
EXEC sp_spaceused [FMFILEHDR_FUSA] ;
EXEC sp_spaceused [FUSA_Run_Entity] ;
EXEC sp_spaceused [FMFILERAW_FUSA] ;
EXEC sp_spaceused [DAMETHISTORY_GENU1156_FUSA] ;
EXEC sp_spaceused [FMFILERAWHIST1_FUSA] ;
EXEC sp_spaceused [GBINVOICE#REGISTERS_FUSA] ;
EXEC sp_spaceused [FUSA_File_Directory] ;
EXEC sp_spaceused [TRIAL_INVOICE#REGISTERS_FUSA] ;
EXEC sp_spaceused [GDSGBREGISTER_FUSA] ;
EXEC sp_spaceused [GBECONSUMP_FUSA] ;
EXEC sp_spaceused [GBREGISTER_FUSA] ;
EXEC sp_spaceused [DAREGHISTORY_FUSA] ;
EXEC sp_spaceused [FUSA_Job_Run] ;

-- Query used for comparing the data between the Preprod DB and the FUSA DB
SELECT

	COUNT(PPDB.GBR$SEQNO) AS GTPPDB, 
	COUNT(FDB.GBR$SEQNO) AS FUSADB

FROM [Gen_PreProd].dbo.GBREGHIST_FUSA AS PPDB

FULL JOIN
	[FUSA_Automation_Preprod].dbo.GBREGHIST_FUSA AS FDB 
	ON PPDB.GBR$SEQNO = FDB.GBR$SEQNO

--WHERE PPDB.GBR$SEQNO IS NULL 

SELECT

	COUNT(PPDB.GBR$SEQNO) AS GTPPDB, 
	COUNT(FDB.GBR$SEQNO) AS FUSADB

FROM [Gen_PreProd].dbo.GBREGHIST_FUSA AS PPDB

FULL JOIN
	[FUSA_Automation_Preprod].dbo.GBREGHIST_FUSA AS FDB 
	ON PPDB.GBR$SEQNO = FDB.GBR$SEQNO

WHERE PPDB.GBR$SEQNO IS NULL 

