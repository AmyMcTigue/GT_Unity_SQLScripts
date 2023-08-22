SELECT Distinct CACCT AS Account,
                CONSUMERNO AS consumer,
                CINSTALL AS INSTALL,
                ICP_IDENT AS MPXN,
                ICHGCLASS AS PaymentType,
                ILBILLTYPE AS BillType, 
                SEQNO AS BillSeq
                FROM CONSUMER
    LEFT OUTER JOIN INSTALL ON CINSTALL = INSTALL
    LEFT OUTER JOIN EMS_BILLSEQ ON SEQNO = IBILLSEQ 

WHERE ICHGCLASS = 'DOM' -- DOM = PAYM / PAYG = PAYG 
AND IUTILITYTYPE = 'E' -- E = Electricity / G = Gas
--AND ILBILLTYPE = 'S' -- F = Final / I = Interim / S = Scheduled / NULL = PAYG or No bill produced
AND CSTATUSTYPE = '30' -- 30 = Active / 40 = Inactive
AND SEQNO = '400099' -- Bill Sequence codes can be found here > http://gt-preprod:8081/#BILL.SEQUENCE.PARAM??114915540


