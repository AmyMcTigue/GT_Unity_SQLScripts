-- Description: This script is used to pull the tariff rates for the specified date
-- Used for Variable Price Change Tariff Testing

SELECT distinct CRAT$CODE AS TariffCode, 
				CRAT$DATE AS DateEffective, 
				CRAT$RATE/1000000 AS TariffRate
				FROM TARRATE

WHERE CRAT$DATE = '2023-10-01'

AND (CRAT$CODE LIKE 'PA_E_F_%_1_0_17' -- PAYG R1 Fixed Rate
    OR CRAT$CODE LIKE 'PA_E_U_%_1_1_17' -- PAYG R1 unit Rate
    OR CRAT$CODE LIKE 'PA_E_F_%_2_0_17' -- PAYG R2 Fixed Rate
    OR CRAT$CODE LIKE 'PA_E_U_%_2_1_17' -- PAYG R2 Unit Rate Day
    OR CRAT$CODE LIKE 'PA_E_U_%_2_2_17' -- PAYG R2 Unit Rate Night 
    OR CRAT$CODE LIKE 'PA_E_F_%_1_0_DCC' -- PAYG R1 Fixed Rate DCC
    OR CRAT$CODE LIKE 'PA_E_U_%_1_1_DCC' -- PAYG R1 unit Rate DCC
    OR CRAT$CODE LIKE 'PA_E_F_%_2_0_DCC' -- PAYG R2 Fixed Rate DCC
    OR CRAT$CODE LIKE 'PA_E_U_%_2_1_DCC' -- PAYG R2 unit Rate DCC Day 
    OR CRAT$CODE LIKE 'PA_E_U_%_2_2_DCC' -- PAYG R2 unit Rate DCC Night
    OR CRAT$CODE LIKE 'PA_E_F_%_2_0_19' -- PAYG R2 Fixed Rate P2 > P1
    OR CRAT$CODE LIKE 'PA_E_U_%_2_1_19' -- PAYG R2 unit Rate P2 > P1 Day
    OR CRAT$CODE LIKE 'PA_E_U_%_2_2_19' -- PAYG R2 unit Rate P2 > P1 Night
    OR CRAT$CODE LIKE 'PA_G_F_%_1_1_DCC' -- PAYG gas Fixed Rate DCC
    OR CRAT$CODE LIKE 'PA_G_U_%_1_1_DCC' -- PAYG gas unit Rate DCC
    OR CRAT$CODE LIKE 'PA_G_F_%_1_1_17' -- PAYG gas Fixed Rate 
    OR CRAT$CODE LIKE 'PA_G_U_%_1_1_17' -- PAYG gas unit Rate 

    OR CRAT$CODE LIKE 'OE_G_F_%_1_1_17' -- PAYM gas Fixed Rate 
    OR CRAT$CODE LIKE 'OE_G_U_%_1_1_17' -- PAYM gas unit Rate 
    OR CRAT$CODE LIKE 'OE_E_F_%_1_0_17' -- PAYM R1 Fixed Rate 
    OR CRAT$CODE LIKE 'OE_E_U_%_1_1_17' -- PAYM R1 unit Rate 
    OR CRAT$CODE LIKE 'OE_E_F_%_2_0_17' -- PAYM R2 Fixed Rate 
    OR CRAT$CODE LIKE 'OE_E_U_%_2_1_17' -- PAYM R2 unit Rate Day
    OR CRAT$CODE LIKE 'OE_E_U_%_2_2_17' -- PAYM R2 unit Rate Night 
    OR CRAT$CODE LIKE 'OE_G_F_%_1_1_01' -- PAYM gas Fixed Rate WHD
    OR CRAT$CODE LIKE 'OE_G_U_%_1_1_01' -- PAYM gas unit Rate WHD
    OR CRAT$CODE LIKE 'OE_E_F_%_1_0_01' -- PAYM R1 Fixed Rate WHD
    OR CRAT$CODE LIKE 'OE_E_U_%_1_1_01' -- PAYM R1 unit Rate WHD
    OR CRAT$CODE LIKE 'OE_E_F_%_2_0_01' -- PAYM R2 Fixed Rate WHD
    OR CRAT$CODE LIKE 'OE_E_U_%_2_1_01' -- PAYM R2 unit Rate Day WHD
    OR CRAT$CODE LIKE 'OE_E_U_%_2_2_01' -- PAYM R2 unit Rate Night WHD
    OR CRAT$CODE LIKE 'OE_E_F_%_2_0_19' -- PAYM R2 Fixed Rate P2 > P1
    OR CRAT$CODE LIKE 'OE_E_U_%_2_1_19' -- PAYM R2 unit Rate P2 > P1 Day
    OR CRAT$CODE LIKE 'OE_E_U_%_2_2_19' -- PAYM R2 unit Rate P2 > P1 Night
)

ORDER BY CRAT$CODE DESC
