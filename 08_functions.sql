/* Purpose: functions.
Script Date: April 5th ,2019
Developped by Matthew, Sergei, Levar, Tony
 */
 
 -- 6. What is the average length of a loan?

if OBJECT_ID('employee.getNumberOfDaysFn', 'Fn') is not null
drop function employee.getNumberOfDaysFn
;
go


create function employee.getNumberOfDaysFn
(
@OutDate as datetime,
@DueDate as datetime
)
returns int
as 
begin
declare @Period as int
select @Period = abs(DATEDIFF(DAY, @OutDate, @DueDate ))
if (@Period is null)
begin
set @Period = 0
end
return @Period
end
;
go


select AVG(employee.getNumberOfDaysFn(OutDate, DueDate)) as 'Average length of a loan'
from employee.Loans
;
go

/*********USER DEFINED FUNCTION*********/

/* function employee.getFinesFN returns the status of a library users fines */

-- drop function if exsits
IF sysobjects(N'employee.FinesFN', N'FN') IS NOT NULL
    DROP FUNCTION employee.getFinesFN;
    go

create function employee.getFinesFN
      (
        @MemberID as int
      )
      return int
as
  begin
    declare @FineOwed as smallmoney
    select @FineOwed = ELH.FineAssessed
    from employee.LoanHistory as ELH
    where ELH.MemberID = @MemberID
      if (@FineOwed is null)
        begin
          set @FineOwed = 0
        end
    return @FineOwed
  end;
go

-- test
select employee.FinesFN(3);
go
