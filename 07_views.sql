/* Purpose: views.
Script Date: April 5th ,2019
Developped by Matthew, Sergei, Levar, Tony
 */

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
