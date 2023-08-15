--Run on FUSA_Automation_Preprod Database 

SELECT TOP(1) * FROM FUSA_Job_Run ORDER BY 1 DESC;

SELECT * FROM DBO.SchedulerRecords 
ORDER BY Component_Started_DateTime DESC

SELECT * FROM FUSA_Run_Entity
ORDER BY Started_DateTime DESC

--SELECT * FROM FUSA_Run
--WHERE RUN_ID in (732, 733,734,735, 736)

SELECT * FROM FUSA_Failed_Entity_Run