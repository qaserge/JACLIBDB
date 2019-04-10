/* Purpose: stored procedures.
Script Date: April 5th ,2019
Developped by Matthew, Sergei, Levar, Tony
 */

-- 1. How many loans did the library do last year?

create procedure employee.getNumOfLoansInLastYear 
as
begin 
select count(LH.OutDate) as 'loans in the last year'
from [employee].[LoanHistory] as LH
where year(LH.OutDate) = YEAR(getdate())
end
;
go
                              
-- 2. What percentage of the membership borrowed at least one book?
create procedure employee.getPercMemBorr 
as
begin
select CAST( (count(distinct LH.MemberID) * 100) / (count(M.MemberID)) AS NUMERIC(10, 2) ) as 'Percentage %'
from customer.Members as M
left outer join employee.LoanHistory as LH
on LH.MemberID = M.MemberID
end
;
go
                                                    
-- 3. What was the greatest number of books borrowed by any one individual?
SELECT MAX(CM.C) as 'greatest number of books borrowed by any one individual'
  FROM (SELECT COUNT(ItemID) AS C
          FROM employee.LoanHistory
  group by MemberID) as CM
  ;
  go
