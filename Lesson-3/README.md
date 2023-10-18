# LECTURE THREE: DML
Description: This lesson goes over DML, data manipulation language. With the database and tables created, we learn how to add entities, update them, and select them.

## SELECT

If we want to access the data in a table, we need to use the `SELECT` operator in conjunction with the `FROM` operator. 
- **SELECT** dictates which *columns* to select
- **FROM** dictates which *table* to select the columns from.

The result is given to us as a view, ie, a snapshot of the rows and columns of the table we are selecting from.

Syntax: `SELECT Column, [Column2, Column3, … ColumnN] FROM Table;`

This will return every row of the selected columns from the selected table.

Note that you can select one, multiple, or all columns from a table. The `*` operator selects **all columns** from a table:

```
SELECT * FROM TABLE;
```

#### Distinct
To get a list of all the values of a column, without duplicate results, we can use the `DISTINCT` keyword

Syntax: `SELECT DISTINCT Column FROM TABLE;`

This will return all the values inside the column. If a value is repeated in the column, it will be returned only once, giving us all the different values within that column. 

For example, if we were to query the Orders table using 

```
SELECT DISTINCT Country
FROM Orders;
```

This would return a list of every country under the Country column in the Orders table

#### Alias

To rename the column in the view returned by the select statement we can use the `AS` keyword. 

Syntax: `SELECT Column AS Alias`

Note that we are not changing anything in the table itself. We are only changing the view returned by the select statement that we are looking at.

We can use the AS keyword for multiple columns:

```
SELECT
 COL1 As A,
 COL2 As B,
 COL3 As C
FROM Table
```

## WHERE Clause

To select only specific rows from a table, we can use a `WHERE` clause to dictate that we want to select only the rows where the specific condition is met.

Syntax:
```
SELECT Column, [Column2, Column3, … ColumnN]
FROM Table
WHERE condition;
```

For example, to select the Name of all dishes where the Price is under $10, we can use:

```
SELECT Name
FROM Dish
WHERE Price < 10.00;
```

To see a full list of conditional operators, check the attached reference sheet.

## AGGREGATE FUNCTIONS

Aggregate functions return a single value from a table, usually a calculated value from a column in the table. The syntax is: `FUNCTIONNAME(ColumnToCalculate)`, where *FUNCTIONNAME* is the name of the function (see reference sheet for a full list) and *ColumnToCalculate* is a value, typically a column, passed as an argument to the function.

For example, if you wanted to find the maximum value in a column titled Cost, you would use the MAX function passing the column Cost as an argument:

```
SELECT MAX(Cost)
FROM Orders;
```

The view returned would be a single column and row. The column name would be 'MAX(Cost)' and the value in the single row would be the highest value in the Cost column.

The COUNT function returns the total number of rows returned. For example, if you had 25 rows in the Order table, the command

```
SELECT COUNT(*)
FROM Orders;
```

would return a single value, 25. If you put a column value as an argument, it would return the number of rows with **non-null values** in the table for that column. 

If you wanted to count the number of Vegetarian dishes in the Dish table, you could use the count function with a where clause:

```
SELECT COUNT(*)
FROM Dish
WHERE Vegetarian = TRUE;
```

This will return the number of rows returned by the where clause, which is all the dishes that are categorized as vegetarian.

## GROUP BY & ORDER BY

### GROUP BY & HAVING

Syntax:
```
SELECT [cols] FROM Table
GROUP BY [column]
```

**Group by** is used to aggregate the data to get insights from it. By grouping by a column, the view returns a single row for each distinct value in that column.

For example, `GROUP BY Country` would return a single row for each individual value in the Country column. The other columns would be populated by the data in the first row for each value in that column with the matching country.

Group by is best used with aggregation functions. There are three phases when you group data:
- Dataset is split into chunks of rows 
- An aggregate function is computed on each chunk of rows, returning a single value for each chunk.
- Each resulting output is combined into a new view, with the aggregate values displayed for each chunk.

Going back to the Country example, we could find the total number of Orders in each country by combining `GROUP BY` with the aggregate function `COUNT`

```
SELECT Country, COUNT(OrderId)
FROM Orders
GROUP BY Country;
```

This will return a new view with 2 columns: the name of the country, and the number of orders in each country.

#### HAVING 

Group by can be accompanied by the `HAVING` keyword to get even more specific views of data. Like WHERE, the HAVING clause filters the rows of a table, but only within each of the chunks of rows defined by the GROUP BY statement.

Syntax: `GROUP BY [Column] HAVING [condition]`

For example, what if we wanted to get the number of orders in each country, but only those countries that have ordered more than $1000 worth of goods?

```
SELECT Country, COUNT(OrderId), SUM(Total)
FROM Orders
GROUP BY Country
HAVING SUM(Total) > 1000;
```

First, the GROUP BY keyword returns chunks of rows grouped by the Country column; all rows with the same country are grouped together. Then the HAVING clause is applied. It calculates the sum of the Total column, and if the condition is met, then those rows are aggregated and returned. 

Similarly, we can limit the output to only countries that have ordered more than 10 items:

```
SELECT Country, COUNT(OrderId)
FROM Orders
GROUP BY Country
HAVING COUNT(OrderId) > 10;
```

### ORDER BY & LIMIT

Sometimes we want to retrieve sorted data, that is, data which has been organized either from its maximum value to its minimum value (**descending**), or from its minimum value to its maximum value (**ascending**).

To do this, we can retrieve our data using the `ORDER BY` clause. This will retrieve the data (but not alter the data itself within the database), in sorted order.

For example, if we wanted to see a list of all the Dishes from the lowest priced dish to the highest, we could use 

```
SELECT * FROM Dish
ORDER BY Price ASC;
```

Note that the Order By clause, by default, puts the results in ascending order. Therefore, we don’t need to include the ASC keyword after Price. 

In order to view the highest price dish to the lowest priced dish, we could use the `DESC` keyword instead:

```
SELECT * FROM Dish
ORDER BY Price DESC;
```

#### Limit
We might also want to limit the results returned. For example, if we wanted to find the top 5 cheapest dishes available, we could use the `LIMIT` clause, which limits the number of rows returned:

```
SELECT * FROM Dish
ORDER BY Price
LIMIT 5;
```

This orders the dishes by Price in ascending order, then returns only 5 results, which are the top 5 lowest priced dishes.

#### Offset

What if we wanted to skip some rows in the view that is returned? The `OFFSET` keyword is used to offset the rows returned by n amount: `OFFSET 5` will skip the first 5 results and return the 6th and so on.

To get the order with the 3rd highest total, we could use:

```
SELECT OrderId
FROM Orders
ORDER BY Total DESC
LIMIT 1
OFFSET 2
```

This arranges all the orders in the table by their total, descending. Only 1 row is returned, but the result skips the first 2, so only the 3rd highest total is returned.

### Order of Commands

In SQL, commands must be written in a certain order, or errors will be returned. The correct order is:

```
	SELECT [DISTINCT] Columns			
	FROM Tables 					
	[WHERE condition] 					
	[GROUP BY Columns] 			
	[HAVING condition] 					
	[ORDER BY Columns [ASC | DESC]] 		
	[LIMIT # [OFFSET #]]			
```

## INSERTING, DELETING, UPDATING
### Insertion

Before inserting data into a table, we need to know the columns of our table. We can use the `PRAGMA table_info(TableName)` command to return a list of a table’s columns and the data types. We can use this when entering the data to ensure we are respecting the data type integrity. 

For example, the Dish table has 5 columns: Id (INTEGER), Name (VARCHAR(255)), Category VARCHAR(255), Vegetarian (BOOLEAN), and Price (REAL).

To add a new row, we need to insert values into each of these columns, except ID, which auto increments.

The syntax for inserting is: 

```
INSERT INTO Table (Column1, Column2, …, ColumnN) 
VALUES (Column1Value, Column2Value, …, ColumnNValue);
```

For our table, we want to insert values for every column except Id, so we can use:

```
INSERT INTO Dish (Name, Category, Vegetarian, Price) 
VALUES ("Grilled Veggie Sandwich", "Lunch", TRUE, 9.99);
```

This creates a new dish, named Grilled Veggie Sandwich, with the Category Lunch, Vegetarian value TRUE, and a Price of 9.99.

### Deleting
To delete a single row, we want to specify the row using a unique value. For example, to delete the Grilled Veggie sandwich, we would use:

```
DELETE FROM Dish
WHERE Name LIKE 'Grilled Veggie Sandwich';
```

This will delete the row with the matching name. But if we used:

```
DELETE FROM Dish
WHERE Name LIKE 'Sandwich';
```

this would delete all the rows where the Name column contains the word 'Sandwich'. 

Note that omitting the WHERE clause entirely will ***delete every row in the table!***

We could also make sure we are deleting the right now by checking the Id with a SELECT statement. First, the select statement gets the Id of all rows containing the characters ‘sandwich’:

```
SELECT Id FROM Dish
WHERE Name LIKE 'Sandwich';
```

This will return the Id of all the rows containing the word sandwich in the name. If there is more than 1 row, this means all of these rows will be deleted if we use this in a `WHERE` clause with `DELETE`. 

Instead, we can find the ID of the correct row:

```
SELECT Id FROM Dish
WHERE Name LIKE 'Grilled Veggie Sandwich'; 
```
→ Returns 26

And delete that row:

```
DELETE FROM Dish
WHERE Id = 26;
```

Since Id is a unique value, this will only delete one row, with the matching Id.

### Updating

What if we want to change values in a row? We can use the `UPDATE` command to change the value in a column.

The syntax is:

```
UPDATE Table
SET col1 = val1, col2 = val2, …
[WHERE condition];
```

Like the `DELETE` command, the `WHERE` condition specifies which rows to be altered. If it is omitted, all the values for every row will be updated in that column.

For example, the following:

```
UPDATE Dish
SET Name = "Veggie Sandwich";
```

will change the name of every Dish in the table to "Veggie Sandwich"!

Like the DELETE command, we would want to specify which rows to be updated in the WHERE cluase:

```
UPDATE Dish
SET Name = "Veggie Sandwich"
WHERE Id = 26;
```
