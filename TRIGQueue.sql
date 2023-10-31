-- Query used to see everything in the trigqueue 

SELECT * FROM TRIGQUEUE

ORDER BY TQ$SYSTIME DESC

-- To see list of all categories in trigqueue
--SELECT DISTINCT TQ$CATEGORYNAME AS CategoryTypes FROM TRIGQUEUE

