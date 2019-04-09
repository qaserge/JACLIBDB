/* Purpose: functions.
Script Date: April 5th ,2019
Developped by Matthew, Sergei, Levar, Tony
 */

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
