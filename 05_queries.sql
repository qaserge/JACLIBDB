/* Purpose: queries.
Script Date: April 5th ,2019
Developped by Matthew, Sergei, Levar, Tony
 */

use JAClib
 ;
 go

 select *
 from customer.Faculty		-- inital check of table data
 ;
 go

 select *
 from customer.Members		-- inital check of table data
 ;
 go

 select *
 from customer.Reservations		-- inital check of table data
 ;
 go

 select *
 from customer.Students			-- inital check of table data
 ;
 go

 select *
 from employee.Copies			-- inital check of table data
 ;
 go

 select *
 from employee.LoanHistory		-- inital check of table data
 ;
 go

 select *
 from employee.Loans			-- inital check of table data
 ;
 go

 select *
 from material.Authors			-- inital check of table data
 ;
 go

 select *
 from material.Items			-- inital check of table data
 ;
 go

 select *
 from material.Publishers			-- inital check of table data
 ;
 go

 select *
 from material.Titles				-- inital check of table data
 ;
 go

 
 /*1. Create a mailing list of Library members that includes 
 the members full names and complete address information.  
 */

select Concat(M.FirstName, ISNULL(M.MiddleName, ' '), M.LastName) as 'Full Name', 
S.Address, S.City, S.Province, S.PostalCode
from customer.Members as M
inner join customer.Students as S
on M.MemberID = S.MemberID 
;
go



 /*2. Write and execute a query on the title, item, and copy tables that returns 
 the isbn, copy_no, on_loan, title, translation, and cover, and values for rows 
 in the copy table with an ISBN of 1 (one), 500 (five hundred), or 1000 (thousand).  
 Order the result by isbn column. */
 select MI.ISBN , EC.CopyID as 'copy_no', MI.Loanable as 'on_loan', MT.Title, MI.Language, MI.Cover
from [material].[Titles] as MT
inner join [material].[Items] as MI
on MT.TitleID = MI.TitleID
inner join [employee].[Copies] as EC
on EC.ItemID = MI.ItemID
order by MI.ISBN asc
;
go

 
 /*3. Write and execute a query to retrieve the members full name and member_no from 
 the member table and the isbn and log_date values from the reservation table for 
 members 250, 341, 1675. Order the results by member_no. You should show information for these members,
 even if they have no books or reserve.  
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
  title, and loan information of a copy on loan that is overdue (due_date < current date).   */\



/*11. Generating Usage Reports  seven questions are listed at the end of this document to 
generate summary information for librarians. */
