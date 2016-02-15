/* KWAME TENKORANG DARKO
	LAB 4 */


-- 1. Get the cities of agents booking an order for a customer whose cid is 'c002'.
Select Agents.city
From Agents
WHERE Agents.aid IN (
	Select aid
	From Orders
	Where cid = 'c002'
);

/* 2. Get the ids of products ordered through any agent who takes at least one order 
from a customer in Dallas, sorted by pid from highest to lowest. 
(This is not the same as asking for ids of products ordered by customers in Dallas.) */
SELECT DISTINCT Orders.pid 
FROM Orders
WHERE Orders.aid IN(
	Select DISTINCT Orders.aid
	FROM Orders
	Where orders.cid IN(
		Select cid 
		FROM Customers
		Where city = 'Dallas')
) ORDER BY Orders.pid;


-- 3. Get the ids and names of customers who did not place an order through agent a01.
SELECT Customers.cid, Customers.name
FROM Customers
WHERE Customers.cid NOT IN ( 
	SELECT DISTINCT Orders.cid 
	FROM Orders
	WHERE Orders.aid = 'a01'
	);

-- 4. Get the ids of customers who ordered both product p01 and p07.
SELECT DISTINCT Orders.cid
FROM Orders
WHERE Orders.pid = 'p01' AND CID IN( 
	SELECT cid 
	FROM Orders
	WHERE pid = 'p07'
	);

/* 5. Get the ids of products not ordered by any customers who placed any order through agent a07 in 
pid order from highest to lowest. */


/* 6. Get the name, discounts, and city for all customers who place orders through agents in London or 
New York. */
SELECT Customers.name, Customers.city, Customers.discount
FROM Customers
WHERE Customers.cid IN (
	SELECT DISTINCT Orders.cid
	FROM Orders
	WHERE Orders.aid IN (
		SELECT Agents.aid
		FROM Agents
		Where Agents.city = 'London' OR
		Agents.city = 'New York')
);

-- 7. Get all customers who have the same discount as that of any customers in Dallas or London
SELECT Customers.cid
FROM Customers
WHERE discount IN (
	SELECT discount
	FROM Customers
	WHERE Customers.city = 'Dallas' OR Customers.city = 'London'
);

/* Tell me about check constraints: 
What are they? What are they good for? 
	a) A check constraint is an SQL query that is used to check the values being
	entered into a record. If the value does not satisfy the condition that the check constraint
	approves of, the record will not be added into the table. Check constraints are good
	for validating user inputs before adding their records into your tbale.
What’s the advantage of putting that sort of thing inside the database? 
	a) Because a Check constraint ensures that a condition is met, an advantage would be for example
	using it to check the vlaue of an input. For example, if you did not want records of users above 
	the age of 50 a check contraint can be used with the age column. 

Make up some examples of good uses of check 
constraints and some examples of bad uses of check constraints. Explain the differences in your 
examples and argue your case.

	a)Good Use
		CREATE TABLE users(
			id int,
			f_name text,
			l_name text,
			age int,
			CHECK (age < 50) 
		);

	b)Bad Use
		CREATE TABLE users(
			id int,
			f_name text,
			l_name text,
			age int,
			CHECK (f_name < 50) 
		);

The first example "a" is a good example of how to use check contraints.
In the second example "b" we are using a text column datatype(f_name) for
a Check contraint. This is a bad way to use it.

*/

	


