.header on
.mode csv

SELECT Member.memberid, firstname, lastname, nickname,
       address, zipcode, city, strftime('%d.%m.%Y', birthday) as birthday,
       mail, phonenr,  status, function
FROM Member
LEFT OUTER JOIN Address USING (memberid)
LEFT OUTER JOIN EMail   USING (memberid)
LEFT OUTER JOIN Phone   USING (memberid)
WHERE (Address.isprimary = 1 OR Address.memberid IS NULL)
  AND (EMail.isprimary = 1 OR EMail.memberid IS NULL)
  AND (Phone.isprimary = 1 OR Phone.memberid IS NULL);
