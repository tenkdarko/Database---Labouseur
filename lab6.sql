/* 1. Display the name and city of customers who live in any city that makes the most different kinds of products.
 (There are two cities that make the most different products. Return the name and city of customers from either
  one of those.) */

  SELECT c.name, c.city
FROM customers c,
(
Select max(citycounts) as cmax, cityname
FROM (Select count(*) as citycounts,
 p.city as cityname
FROM products p
Group by (cityname)) as innerc
Group by cityname
Order by cmax desc
limit 2
) as ctable
WHERE cityname = c.city;


/*. Display	the	names	of	products	whose	priceUSD	is	strictly	above	the	average	priceUSD,	
in	reverse-alphabetical	order.	*/

Select p.name
From products p
where priceUSD > (
select avg(priceUSD)
from products) order by p.name desc;


/*Display the customer name, pid ordered, and the total for all orders, sorted by total from high to low.*/
SELECT DISTINCT c.name , totalsum, pid
FROM customers c, (
SELECT o.cid as ordercid, sum(o.totalUSD) as totalsum, o.pid
FROM orders o 
GROUP BY o.cid, o.pid ) as innert 
WHERE ordercid = c.cid
ORDER BY totalsum desc;
 
/*Display all customer names (in alphabetical order) and their total ordered, and nothing more.
 Use coalesce to avoid showing NULLs.*/
SELECT DISTINCT c.name , coalesce(totalsum, 0)
FROM customers c, (
SELECT o.cid as ordercid, sum(o.totalUSD) as totalsum
FROM orders o 
GROUP BY o.cid) as innert 
WHERE ordercid=c.cid
 ORDER BY c.name asc;


/*Display the names of all customers who bought products from agents based in Tokyo along with the names of the 
products they ordered, and the names of the agents who sold it to them. */

SELECT c.name, p.name, a.name
FROM customers c, agents a, products p, orders o
WHERE o.cid = c.cid
AND
o.aid = a.aid
AND
p.pid = o.pid
AND a.city = 'Tokyo';


/*What’s the difference between a LEFT OUTER JOIN and a RIGHT OUTER JOIN? Give example queries in SQL to 
demonstrate. (Feel free to use the CAP2 database t make your points here.)
 	a. The difference between a left and right outer join is which table values get displayed
 if there is not a match found. For example, the left side on the "on" predicate of the join
 will display ALL the results of the left table wheather a match was found or not. Vice versa
 for the right table.*/


