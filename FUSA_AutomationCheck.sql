-- Description: A number of queries to check the automation is running correctly 
-- Run on FUSA_Automation_Preprod Database 

-- Check the last run of the orchestration script 
SELECT TOP(1) * FROM FUSA_Job_Run ORDER BY 1 DESC;

-- Used to see the steps that have been run in the orchestration script
SELECT * FROM DBO.SchedulerRecords 
WHERE Component_Started_DateTime >= DATEADD(DAY, -1, GETDATE()) -- To see the last 24 hours
ORDER BY Component_Started_DateTime DESC

-- Used to see the records to be deleted 
SELECT * FROM FUSA_Run_Entity
WHERE Started_DateTime >= DATEADD(DAY, -1, GETDATE())  -- To see the last 24 hours
ORDER BY Started_DateTime DESC

-- Used to see all runs of the scripts 
--SELECT * FROM FUSA_Run
--WHERE RUN_ID in (732, 733,734,735, 736)

-- Used to see exceptions for failed runs 
SELECT * FROM FUSA_Failed_Entity_Run
ORDER BY Errored_Datetime DESC

--Check the current parameters set in the orchestration script
SELECT * FROM FUSA_Parameters

-- Update Cut off date for deletion 
--Exec ops.usp_BeInControl_SetParams @paramKey = 'CUT_OFF_DATE', @paramValue = '2017-10-17'-- in for format of 'YYYY-MM-DD'

-- Reset the cut off date to default 
--EXEC ops.usp_BeInControl_ResetCutOffDate