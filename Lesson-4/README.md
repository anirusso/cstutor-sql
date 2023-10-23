# LECTURE FOUR: ADVANCED SQL
Description: This lesson goes over some more advanced aspects of SQL, including joining multiple tables by foreign keys, subqueries, and CTEs

## JOIN

In a relational database management system, several tables exist within a single database. In many cases these tables hold relations to one another; for example, you might need to check the Customer information in a Customer table, to know where to ship the order from an Order table.

Let’s take a look at our Restaurant table:

```
SELECT * FROM Restaurant;
```

This gives us a list of restaurants, their location, and BestSellerId. BestSellerId is a **foreign key** connecting the Restaurant table to the Dish table. 

A foreign key is a column (or multiple columns) that connect one table with the primary key of another table. In our example, BestSellerId links the primary key from the Dish table to a column indicating the best selling dish in a restaurant.


### CARTESIAN JOIN

We can connect the two tables by selecting them in the `FROM` clause:

```
SELECT *
FROM Dish, Restaurant
SELECT * FROM Dish
ORDER BY Price
LIMIT 5;
```

This command will return *every row of Dish matched with every row from Restaurant*. This multiple pairing is known as a **Cartesian Join**.

For example, if we have a table T1 and a second table T2, as follows:

| T1 |
| -- | 
| 1  |
| 2  |
| 3  |

| T2 |
|----|
| A  |
| B  |
| C  |

A cartesian join will produce:

| T1 | T2 |
| -- | -- |
| 1  | A  |
| 1  | B  |
| 1  | C  |
| 2  | A  |
| 2  | B  |
| 2  | C  |
| 3  | A  |
| 3  | B  |
| 3  | C  |

The result set is a combination of every value in T1 with every value in T2. Not very meaningful, and as a table can have many rows and columns, the result can be large and unwieldy. 

Instead, we want to join tables which have a natural connection to each other, which can be specified by a foreign key or another connected value.

In our Restaurant example, we could connect the Dish & Restaurant table by the Id column of Dish, which corresponds to the BestSellerId of Restaurant, in a `WHERE` clause.

```
SELECT *
FROM Restaurant, Dish
WHERE Restaurant.BestSellerId = Dish.Id;
```

The result set is a meaningful connection showing the columns of Restaurant matched with the columns of Dish, where the Id of Dish is included in the list of BestDishId’s.

### INNER JOIN

Because connecting two or more tables together is such a pivotal part of relational database management, SQL comes equipped with several types of joins to facilitate the process.

Syntax:
```
SELECT [...] FROM Table1
INNER JOIN Table2
ON Table1.key = Table2.key;
```

In our Restaurant example, we used the equivalency operator in a WHERE clause. We can accomplish the same result by using an  `INNER JOIN`, which joins two tables along with the keyword `ON`, which specifies a condition to join on:

```
SELECT * FROM Restaurant
INNER JOIN Dish 
ON Restaurant.BestSellerId = Dish.Id;
```

The result set will be the same: The restaurants with a BestSellerId will be matched with the rows of a dish with the matching Id.

Note that the shorthand for `INNER JOIN` is `JOIN`, so the results are the same as:

```
SELECT * FROM Restaurant
JOIN Dish 
ON Restaurant.BestSellerId = Dish.Id;
```

### LEFT JOIN

If we want to return all the rows from one table, but only the values which match from another, we can use a `LEFT JOIN`.

Syntax:
```
SELECT * FROM LeftTable
LEFT JOIN RightTable
ON LeftTable.key = LeftTable.key;
```
This will return all the rows in the left table (the original table in the FROM clause), plus matching rows from the right table (the joined table).

```
SELECT * FROM Restaurant
LEFT JOIN Dish 
ON Restaurant.BestSellerId = Dish.Id;
```

In this example, all restaurants, including those without a value in the BestSellerId column, will show in the result set. It will include only those dishes with a matching Id in the BestSellerId column, and for those restaurants without, the values will be null.

#### Right Join & Outer Join
Note that while Right Join (and Outer Joins) are a part of most SQL database systems, it is not implemented in SQLite and cannot be used (although there are workarounds).

### Dot Operator & Alias
If we want to return only a selected column, instead of all the columns, we could specify that:

```
SELECT Name 
FROM Restaurant
LEFT JOIN Dish ON Restaurant.BestSellerId = Dish.Id;
```

The above command creates a problem: Trying to return the Name column is ambiguous as we have selected from two tables, and both tables have a Name column; which one do we want?

We can specify the table we want the columns of by using the dot operator.

Syntax:
```
SELECT Table1.Column1, Table2.Column2
FROM Table1, Table2;
```

For example, if we only want the name of the Restaurant and the name of the best dish, we could use:

```
SELECT Restaurant.Name, Dish.Name
FROM Restaurant
INNER JOIN Dish ON Restaurant.BestSellerId = Dish.Id;
```

Typing out the names of each table can be cumbersome. Instead, we can use an alias, which is temporary renaming of a table to be returned. Note that this does not change the table name itself, only a temporary value when a table is returned. 

The `AS` keyword specifies an alias:

```
SELECT *
FROM Table AS Alias;
```

For example, we can call our Restaurant table R, our Dish table D, and use the alias within the SQL query:

```
SELECT R.Name AS Place, D.Name
FROM Restaurant AS R
INNER JOIN Dish AS D ON R.BestSellerId = D.Id;
```

Note that the AS keyword is good for readability, but not required You can also omit it:

```
SELECT *
FROM Table Alias;
```

### CONDITIONAL JOIN

You can set multiple conditions when joining tables using the `AND` keyword. For example, if you only wanted specific matching rows returned, not just every matching row.

Syntax:
```
SELECT [...] FROM Table1
JOIN Table2
ON Table1.key = Table2.key
AND condition;
```

As an example, let’s only select the restaurants where the average rating is higher than 4:

```
SELECT R.Name, D.Name
FROM Restaurant R
INNER JOIN Dish D 
ON R.BestSellerId = D.Id
AND R.Rating > 4;
```

We can add another clause for filtering the price of the dish as well:

```
SELECT R.Name, D.Name
FROM Restaurant R
INNER JOIN Dish D 
ON R.BestSellerId = D.Id
AND R.Rating > 4
AND D.Price < 15
```

### MULTIPLE TABLE JOIN

You can join more than just two tables in a JOIN. Assuming there are keys within each table connecting a table to at least one other table, you can return several:

```
SELECT *
FROM Table1 AS T1
JOIN Table2 AS T2 
  ON T1.FK = T2.PK;
JOIN Table3 AS T3
  ON T2.FK = T3.PK;
```

You can imagine three tables: An Order Table, a Product Table, and a Customer Table.

Suppose Order has the following columns:

| OrderId | ProductId | CustomerId | OrderDate | Total |
| - | - | - | -| - |

Product has the following:

| ProductId | Name | Price |
| - | - | - |

And Customer has the following:

| CustomerId | Name | Address |
| - | - | - |

And you wanted to get the name of the Customers who ordered a pear. The following query should solve the problem:

```
SELECT C.Name
FROM Customer C
JOIN Order O
ON O.CustomerId = C.CustomerId
JOIN Product P
ON P.ProductId = O.ProductId
 AND ProductName = “pear”
```

Let’s go over this long query bit by bit:
- First, we want to select the name of the customer from the Customer table
- We need to connect Customer & Product, but there are no connecting keys between the two tables.
- Instead, we can join Customer and Orders by the `CustomerId` key both tables have
- Now we join Products by connecting it by the `ProductId` key in both Orders & Products
- Finally, we only want the names of the customers who ordered pears. So, we set the condition to only join the rows in Products where the ProductName is equal to “pear”

### SELF JOIN

A self join is a regular join, but the table is joined with itself.

Syntax:
```
SELECT *
FROM Table1 AS T1
JOIN Table1 AS T2
ON condition;
```

There are a few reasons to do this; you might need to find similarities in a single table. For example, if you wanted a list of vendors in the same city in a Vendor table, you could use the query:

```
SELECT A.VendorName AS Vendor1, B.VendorName AS Vendor2, A.City
FROM Vendors A
JOIN Vendors B
ON A.VendorId != B.VendorId
AND A.City = B.City 
ORDER BY A.City;
```

## SUBQUERIES

We’ve seen how the results of a SELECT query is a view; a temporary table which shows us results but cannot update or change the original queried table. We can also query these temporary tables as we would any other SQL table.

Subqueries are SELECT statements placed inside parenthesis. Their return value is then used in another query. They can be used in WHERE clauses, with INSERT, with lists, or in the FROM clause.

### WHERE

Syntax: `WHERE [columns] [operator] (subquery)`

These can be useful when we need to use the results of an aggregate function in a WHERE statement, but cannot use it directly.

For example, if we wanted to find the oldest movie in a Movie table, we couldn’t use:

```
SELECT *
FROM Movie
WHERE ReleaseDate = MIN(ReleaseDate)
```

Because the aggregate function cannot be applied directly on the WHERE clause. Instead, we could get the result in a subquery, and then compare that subquery to our table to find the Movie where the ReleaseDate is equal to the subquery’s return value.

```
SELECT *
FROM Movie
WHERE ReleaseDate = (SELECT MIN(ReleaseDate) FROM Movie)
```

Subqueries can include anything a regular query can, including conditions, ordering, grouping, etc.

```
SELECT *
FROM Movie
WHERE ReleaseDate = 1963
AND RunningTime =  (
SELECT MAX(RunningTime) 
FROM Movie 
WHERE ReleaseDate = 1963
)
```

A query can also have multiple subqueries:

```
SELECT *
FROM Movie
WHERE ReleaseDate = (SELECT MIN(ReleaseDate) FROM Movie) 
AND RunningTime = (SELECT MAX(RunningTime) FROM Movie)
```

But note the number of times the `FROM` keyword is used: in a large table, querying the table many times can be inefficient. A shorthand for this could be:

```
SELECT *
FROM Movie WHERE (ReleaseDate, RunningTime) = (
SELECT MIN(ReleaseDate), MAX(RunningTime) FROM Movie
)
```

In this example, our subquery goes through the Movie table only once, returning two columns. Those columns are then compared to the two columns in parenthesis in the WHERE clause.

### INSERT

Subqueries can be used to do bulk inserts.

Syntax: `INSERT INTO TableName(col1, col2, …) (subquery);`

Note that the numbers of columns must match in both tables, as well as the data type constraints. As we’ve seen, we can omit the list of columns when inserting and every column will be filled with the value from the subquery. The order is assumed when the column list is omitted.

Example:
```
INSERT INTO OldMovie
(SELECT * FROM Movie WHERE ReleaseDate < 1968)
```

This will add all columns, plus rows where ReleaseDate column value is less than 1968 into the OldMovie table 

### IN

A subquery can be used as a list to check whether a column’s value matches the value returned by the subquery.

Syntax: `WHERE [columns] [NOT] IN (subquery)`

Example: 
```
SELECT * 
FROM Movie
WHERE Id IN (SELECT BestMovieId FROM Director)
```

First, the subquery returns a list of BestMovieId’s from the Director table. Then the Movie table is queried and a list of Movies with matching ids is returned.

### ANY & ALL

A subquery can be used with the keywords `ANY` or `ALL`, along with a conditional operator, to perform a comparison between a column value and the values returned by the subquery.

Syntax: `WHERE column [operator] ANY/ALL (subquery)`

The operator could be equality (`=` and `!=`), greater than/less than (`>` and `<`), greater than or equal to (`>=`) and less than or equal to (`<=`)

The operator will evaluate to TRUE based on the criteria:
- **ANY:** The operator will evaluate true if it is satisfied by one or more values in the subquery.
-**ALL:** The operator will evaluate to true if it is satisfied by ALL values in the subquery.

Example:
```
SELECT * FROM Director
WHERE MovieCount > ALL (SELECT MovieCount
FROM Director
WHERE PlaceOfBirth = 'USA'
)
```
In the example, the subquery returns a list of all movies directed by American directors. These values are then compared to the rest of the values in the Director table, and those which have a higher MovieCount than all values in the subquery will be returned.

### EXISTS

Syntax: `WHERE [NOT] EXISTS (subquery)`

The condition is true if there is at least one row in the subquery, and is used to test for the existence of any record in a subquery.

### FROM

Syntax:
```
SELECT Columns
FROM Tables, (subquery1) AS S1, (subquery2) AS S2, …
WHERE condition
```

Note:
- Each subquery is assumed to be a Table.
- Subquery can have multiple rows and columns.
- Subquery must be used with an alias (AS)

#### Using Join

```
SELECT Columns
FROM Table
JOIN (subquery) AS Alias [ON condition]
WHERE [condition]
```

### CORRELATED SUBQUERY

A correlated subquery (aka synchronized subquery) is a subquery that uses columns of tables from the outer query.

Example: Subquery finds Avg RunningTime from table M2 using M1’s ReleaseDate

```
SELECT *
FROM Movie AS M1
WHERE RunningTime > (SELECT AVG(RunningTime)
FROM Movie AS M2
WHERE M2.ReleaseDate = M1.ReleaseDate
)
```

The correlated subquery is evaluated once for each row processed by the outer query, therefore it is not very efficient.

Uses for correlated subquery: Update a count for a column, for example TotalMovieCount at the end of the year instead of gradual update.

```
UPDATE Director AS D SET MovieCount = (
SELECT COUNT(*)
FROM MovieDirector AS MD
WHERE MD.DirectorId = D.Id
)
```

## COMMON TABLE EXPRESSIONS

A **Common Table Expression** (CTE), like a subquery, temporarily stores the result of a query to be referenced within another query. Whereas a subquery can only be used once within a query, a CTE can be used many times, but note that unlike a subquery, it cannot be used in a WHERE clause with IN/EXISTS.

Syntax: `WITH cte AS (query)`

CTES are placed at the beginning of a query, before the SELECT and FROM clauses. We can also use multiple CTEs in a single query, like so:

```
WITH
   cte1 AS (query),
   cte2 AS (query)
SELECT * FROM cte1
WHERE cte1.column = cte2.column;
```

In the example above, we created 2 CTEs and returned all rows where cte1 had a matching key value in cte2. Note that the `WITH` clause is written once and each CTE is separated by a comma.

We can also rename selected columns from the CTE. For example, the following CTE returns two columns from the Sales table:

```
WITH sales_cte (id, num_orders)
AS
(
    SELECT SalesPersonID, COUNT(*)
    FROM Sales
    WHERE SalesPersonID IS NOT NULL
    GROUP BY SalesPersonID
)
SELECT AVG(num_orders) AS "Average Sales Per Person"
FROM sales_cte;
```

The id column is not used, and the count total of sales is renamed to num_orders. We then use that value of num_orders to calculate the average and return it as "Average Sales Per Person"
