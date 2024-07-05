USE TamasyaCafe

SELECT * 
FROM customer

 --COMMON SUBQUERY
 --===================================================================================================
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
 --===================================================================================================
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

--2 ALL => Inner will return many data and the outer need to pass all the value test
/*ALL => dipakai saat semua data di outer ingin melewati melebihi data yang diselect di inner misal pakai comparator point,
maka semua point yang dikeluarkan oleh outer sudah pasti ada diatas/dibawah dari ALL nilai point di inner*/
SELECT CustomerName, BeverageId
FROM customer ct
JOIN orders od ON od.CustomerId = ct.CustomerId
WHERE CustomerPoint > ALL (
    SELECT CustomerPoint
    FROM customer
	WHERE CustomerId LIKE 'T%');

--3 ANY/SOME => Similar with ALL but the outer data only need to surpass at minimum one inner data test value
/*ANY/SOME => dipakai mirip seperti all, tapi bedanya ketika data di outer bisa memenuhi salah satu data dari 
sekian data di inner sudah pasti data tersebut dapat lolos*/
SELECT CustomerName, BeverageId
FROM customer ct
JOIN orders od ON od.CustomerId = ct.CustomerId
WHERE CustomerPoint > SOME (
    SELECT CustomerPoint
    FROM customer
	WHERE CustomerId LIKE 'T%');