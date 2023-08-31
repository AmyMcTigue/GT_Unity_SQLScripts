-- Description: Script used for stored proedures monitoring the FUSA actions on database 
-- Stored procedures written by and managed by Simon Smart DBA 

EXEC sp_autoRunManagerMonitor

EXEC sp_componentsExecutionMonitor

EXEC sp_deletedDataTimeframeMonitor

EXEC sp_deletedFileVolumesMonitor

EXEC sp_deletedTableVolumesMonitor

EXEC sp_runtimeMonitor

-- Query used to see all stored procedures in the master database
-- SELECT * FROM sys.procedures WHERE type = 'P' AND is_ms_shipped = 0

-- Query used to see the definition of a stored procedure
-- EXEC sp_helptext 'sp_deletedFileVolumesMonitor'

