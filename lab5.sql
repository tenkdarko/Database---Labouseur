/* KWAME TENKORANG DARKO
		LAB 5 */


-- 1. Show the cities of agents booking an order for a customer whose id is 'c002'. Use joins; no subqueries
	SELECT DISTINCT a.city
	FROM Orders o, Agents a
	WHERE o.cid = 'c002'
	AND a.aid = o.aid;

/* 2. Show the ids of products ordered through any agent who makes at least one order for a customer in 
	Dallas, sorted by pid from highest to lowest. Use joins; no subqueries. */
	SELECT DISTINCT o.pid
	FROM orders o, customers c
	WHERE c.city = 'Dallas'
	AND o.cid = c.cid
	ORDER BY o.pid DESC; 

-- 3. Show the names of customers who have never placed an order. Use a subquery.
	SELECT c.name
	FROM customers c
	WHERE c.cid NOT IN 
		(
		SELECT DISTINCT o.cid
		FROM orders o
		);


-- 4. Show the names of customers who have never placed an order. Use an outer join.
	SELECT c.name
	FROM customers c
	LEFT OUTER JOIN orders o
	on c.cid = o.cid
	WHERE o.cid IS NULL;

/* 5. Show the names of customers who placed at least one order through an agent in their own city, 
along with those agent(s') names. */
	SELECT DISTINCT c.name as Customer_name, a.name as Agent_name
	FROM customers c, agents a, orders o
	WHERE c.city = a.city
	AND c.cid = o.cid
	AND a.aid = o.aid;

/* 6. Show the names of customers and agents living in the same city, along with the name of the shared city,
 regardless of whether or not the customer has ever placed an order with that agent. */
 	SELECT DISTINCT c.name as Customer_name, a.name as Agent_name, c.city as City
	FROM customers c, agents a
	WHERE c.city = a.city;


/* 7. Show the name and city of customers who live in the city that makes the fewest different kinds of products.
(Hint: Use count and group by on the Products table.) */
	SELECT c.name, c.city
	FROM customers c
	WHERE c.city IN 
		(
		SELECT p.city
		FROM products p
		GROUP BY p.city
		ORDER BY count(*) asc
		LIMIT 1
		);