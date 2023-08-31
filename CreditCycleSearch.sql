-- Description: This script is used to see what stage an installation is at in the credit cycle for vacant credit cycle

SELECT * FROM CONSUMER WHERE CINSTALL = '123586' 

SELECT * FROM CREDITLIST 
WHERE CREDINSTALL = '123586'