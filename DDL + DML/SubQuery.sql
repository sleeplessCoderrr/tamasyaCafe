USE TamasyaCafe

SELECT * 
FROM customer

 --COMMON SUBQUERY
 --====================
/* Use common subquerry when your inner select query return a single value */
--1 With AVG => return single value
SELECT CustomerId AS [ID], CustomerName as [Name]
FROM customer
WHERE CustomerPoint > (
	SELECT AVG(CustomerPoint)
	FROM customer);

--2 With Like => String case
SELECT *
FROM customer
WHERE CustomerPoint > (
	SELECT CustomerPoint
	FROM customer
	WHERE CustomerName LIKE '%Aoki');



--SUBQUERY WITH IN, ALL, ANY/SOME 
 --====================
--1 IN => Take multiple data from inner query
/*IN => Dipakai saat hanya ingin outer menampilkan data yang sama dengan yang ada di inner queery*/
SELECT CustomerId AS [ID], CustomerName AS [Name]
FROM customer
WHERE CustomerName IN (
    SELECT CustomerName
    FROM customer
    WHERE CustomerPoint > 600);

SELECT CustomerName, OrderDate
FROM customer ct
JOIN orders od ON od.CustomerId = ct.CustomerId
WHERE CustomerName IN(
	SELECT CustomerName
	FROM customer ct
	JOIN orders od ON od.CustomerId = ct.CustomerId
	JOIN coffe cf ON cf.BeverageId = od.BeverageId
	WHERE cf.BeverageName LIKE 'Americano');


