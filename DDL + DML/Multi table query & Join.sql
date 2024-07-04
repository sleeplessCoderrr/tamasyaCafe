use TamasyaCafe

SELECT * FROM orders
SELECT * FROM customer

--Multi Table Query
SELECT *
FROM orders, customer
WHERE orders.CustomerId = customer.CustomerId

--Inner Join
SELECT CustomerName, BeverageId
FROM orders INNER JOIN customer
ON orders.CustomerId = customer.CustomerId

--Left Join
SELECT CustomerName, OrderDate
FROM customer LEFT JOIN orders
ON customer.CustomerId = orders.CustomerId

--Right Join
SELECT * from coffe
select * from orders

SELECT CustomerId, BeverageName
FROM orders RIGHT JOIN coffe
ON orders.BeverageId = coffe.BeverageId

--FULL Join
SELECT *
FROM orders FULL JOIN coffe
ON orders.BeverageId = coffe.BeverageId

--Multi Join 
SELECT OrderId, BeverageName, CustomerName
FROM orders JOIN coffe
ON orders.BeverageId = coffe.BeverageId
JOIN customer
ON orders.CustomerId = customer.CustomerId

