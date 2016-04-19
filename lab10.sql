
/*Kwame T. Darko */

/* Question #1 */

create or replace function  PreReqsFor(int, refcursor) returns refcursor as $$
declare
   course_num int       := $1;
   resultset   REFCURSOR := $2;
begin
   open resultset for 

	Select * 
	From courses c
	Where c.num in (
	Select prereqnum 
	From prerequisites p
	Where p.coursenum = course_num ) ;

   return resultset;
end;
$$ 
language plpgsql;

select PreReqsFor(499, 'results');
fetch all from results;




/* Question #2 */
create or replace function  ImPreReqsFor(int, refcursor) returns refcursor as 
$$
declare
   course_num int       := $1;
   resultset   REFCURSOR := $2;
begin
   open resultset for 

	Select * 
From courses c
Where c.num in (
	Select coursenum 
	From prerequisites p
	Where p.prereqnum = course_num ) ;

   return resultset;
end;
$$ 
language plpgsql;

select ImPreReqsFor(221, 'results');
fetch all from results;
    
