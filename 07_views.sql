/* Purpose: views.
Script Date: April 5th ,2019
Developped by Matthew, Sergei, Levar, Tony
 */
 
 /* 4. Create a view and save it as adultwideView that queries the member and adult tables.  
Lists the name & address for all adults. */
create view adultwideView
as
	select Concat(M.FirstName, ISNULL(M.MiddleName, ' '), M.LastName) as 'Full Name', 
F.Address, F.City, F.Province, F.PostalCode
from customer.Members as M
	inner join customer.Faculty as F
	on M.MemberID = F.MemberID 
;
go

select *
from adultwideView
;
go



/*5. Create a view and save it as ChildwideView that queries the member, adult,
 and juvenile tables.  Lists the name & address for the juveniles. */
 create view ChildwideView
 as
 select concat(M.FirstName, ISNULL(M.MiddleName, ' '), M.LastName) as 'Full Name', 
  S.Address, S.City, S.Province,S.PostalCode
 from customer.Members as M
	inner join customer.Students as S
	on M.MemberID = S.MemberID
;
go

select *
from ChildwideView
;
go


/*6. Create a view and save it as and CopywideView that queries the copy, title and item tables. 
 Lists complete information about each copy. 
 */
 create view CopywideView
 as
	select I.ItemID,I.TitleID,I.PublisherID,I.Language,I.ISBN ,I.Cover,I.Loanable,
	C.CopyID,C.OnLoan,T.AuthorID,T.Title,T.Genre,T.Summary
	from material.Titles as T
	inner join employee.Copies as C
	on T.TitleID = C.TitleID
	inner join material.Items as I
	on T.TitleID = I.TitleID
;
go

select *
from CopywideView
;
go


/*7. Create a view and save it as LoanableView that queries CopywideView (3-table join). 
 Lists complete information about each copy marked as loanable (loanable = 'Y'). */

 create view LoanableView
 as
	select *
	from CopywideView
	where Loanable = 1
;
go

select *
from LoanableView
;
go


/*8. Create a view and save it as OnshelfView that queries CopywideView (3-table join). 
Lists complete information about each copy that is not currently on loan (on_loan ='N'). */

create view OnshelfView
as 
	select  ItemID,TitleID,PublisherID,Language,ISBN ,Cover,Loanable,
	CopyID,OnLoan,AuthorID,Title,Genre,Summary
	from CopywideView
	where OnLoan =0
;
go

select *
from OnshelfView
;
go


/*9. Create a view and save it as OnloanView that queries the loan, title, and member tables. 
Lists the member, title, and loan information of a copy that is currently on loan. 
 */



/*10. Create a view and save it as OverdueView that queries OnloanView (3-table join.) Lists the member,
  title, and loan information of a copy on loan that is overdue (due_date < current date).   */
  
 /*********** EXTRA ***********/

 /*FacultyView, that return the ID, first and last name of faculty*/
 if OBJECT_ID('customer.FacultyView', 'V') is not null
   drop view customer.FacultyView;
 go

 create view customer.FacultyView
 as
   SELECT
   C.FacultyID as 'Faculty ID',
   concat_ws(FirstName, LastName) as 'Faculty Full Name'
   from customer.Faculty as C;
 go

-- test
 select *
 from customer.FacultyView;
 go

 /*StudentView, that return the ID, Student Number, first and last name of students*/
 if OBJECT_ID('customer.StudentView', 'V') is not null
   drop view customer.StudentView;
 go

 create view customer.StudentView
 as
   SELECT
   C.StudentID as 'Student ID',
   C.StudentNumber as 'Student Number',
   concat_ws(FirstName, LastName) as 'Student Full Name'
   from customer.Students as C;
 go

-- test
 select *
 from customer.StudentView;
 go
