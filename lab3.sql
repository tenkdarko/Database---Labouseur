Tenkorang Darko

Lab 3: Getting Started with SQL Queries

List the ordno and dollars of all orders.

	SELECT ordno , dollars 
	FROM orders;

List the name and city of agents named Smith. 
	SELECT name , city 
	FROM agents 
	WHERE name='Smith';


List the pid, name, and price USD of products with quantity more than 200,000. 
	SELECT pid, name, priceusd 
	FROM products 
	WHERE quantity > 200000;


List the names and cities of customers in Dallas. 
	SELECT name, city 
	FROM customers 
	WHERE city = 'Dallas';


List the names of agents not in New York and not in Tokyo.
	SELECT name, city 
	FROM agents 
	WHERE city <> 'New York' 
	AND city <> 'Tokyo';

List all data for products not in Dallas or Duluth that cost US$1 or more. 
	SELECT * FROM products 
	WHERE city <> 'Dallas' 
	AND city <> 'Duluth' 
	AND priceusd >= 1;

List all data for orders in January or May.
	SELECT * FROM orders 
	WHERE mon = 'jan' 
	OR mon = 'may'; 

List all data for orders in February more than us$500. 
	SELECT * 
	FROM orders 
	WHERE mon = 'feb' 
	AND dollars > 500;

9. List all orders from the customer whose cid is C005.
	SELECT * 
	FROM orders 
	WHERE cid='C005'; 