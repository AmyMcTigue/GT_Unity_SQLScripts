select
row_number () over (partition by l.LETCODE_CODE order by l.LETDATE desc) as RowNumber
,l.LETID_ACC AccountID
,l.LETSEQ LetterID
,l.LETCODE_CODE LetterCode
,lc.LCDESC LetterName
,l.LETDATE SentDate
,case when l.LETEMAIL is null then 'Posted' else 'Emailed' end as DeliveryMethod
,'http://http://gt-preprod:8081/image/'+LTRIM(RTRIM(STR(LETDOCBHEADER)+'/L'+LTRIM(RTRIM(STR(LETSEQ)+'.pdf')))) AS Production_url --adjust this link to switch between prod/preprod
from
LET_FORMATDATAARC l
inner join [dbo].[LET_CODE] lc on l.LETCODE_CODE = lc.LCCODE
inner join dbo.ACCOUNTS a on l.LETID_ACC = a.ACCTNO
where
LCCODE = 'DCC|PREPAY.TARIFF' -- i.e. 'PCAP|CHANGE'
and l.LETDATE between '2010-01-01' and '2022-10-01'
and isnull(a.ACPAYMETHOD,'x') <> 'P'
and a.ACRETAILER = 'OVO'
and l.letemail is null

-- To see full list of letter codes run script below 
-- SELECT * FROM LET_CODE
