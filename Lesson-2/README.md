# LESSON TWO: SQL COMMANDS (DML)
Welcome to the second lesson in the CSTutor SQL course! This lesson goes over DML, or **Database Manipulation Language**. This covers basic commands in SQL,
such as how to access data and how to update data.

## DATA AND VALUES
SQL, or **structured query language**, is a programming language which facilitates the ability to access and manipulate large sets of data. Data is stored in a *table* form, with *columns* of data, and *rows* of data entities.

For example, our database Restaurants stores information on dishes. In the Dish table, columns such as ‘Name’, ‘Category’, ‘Price’, etc, hold information on each dish. Each row of data is a different dish with a value for each column. An example row might be “Lasagna”, with the value in the Category column being “Dinner” and value in the Price column being 13.99.

| Name              | Category    | Price |
| ----------------- | ----------- | ----- |
| Lasagna           | Dinner      | 13.99 |
| Veggie Sandwich   | Lunch       | 9.99  |

The values in each column should be consistent. For example, a dish shouldn’t have a number under Category, or a sentence under Price. 

In order for the data to be consistent, we need to have a specific **data type** when entering values. The data types describe the type of data being entered.

Name, Category: Should be words. In SQL, we use text or varchar(#) to specify a “string” of words. For example, you might use varchar(255) to specify a string of max 255 characters.
Price: Should be a number, in this case a decimal, or “real” number.

**Numbers** can be integers or real:
- **Integer:** A whole number with no fractional part, positive or negative.
- - Examples: 0, -1, 123
- **Real:** A floating-point, or decimal number, positive or negative.
- - Examples: 0.0009, -3.50, 1.0

You can check the ref sheet for a list of data types with examples, or the sqlite documentation here: https://www.sqlite.org/datatype3.html.

#### Viewing Table Data

A database can contain one or several tables. To view all the tables in a database, you can use the `.tables` command in the sqlite3 interface. If we want to know all the columns in a specific table, we can use the `PRAGMA table_info(TableName)` command. This will give a list of columns as well as some info on the columns (more on that in the next section).

## ACCESSING DATA
If we want to access the data in a table, we need to use the `SELECT` operator in conjunction with the `FROM` operator. 
- **SELECT** dictates which *columns* to select
- **FROM** dictates which *table* to select the columns from.

The syntax is:

```
SELECT Column, [Column2, Column3, … ColumnN]
FROM Table;
```

This will return all the rows of the selected columns from the selected table. 

Note that you can select one, multiple, or all columns from a table. The * operator selects all columns from a table:

```
SELECT * FROM TABLE;
```
The above command will returns all rows and all columns from the table.

#### Filtering

To select only specific rows from a table, we can use a `WHERE` clause to dictate that we want to select only the rows where the specific condition is met.

The syntax is:

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

To see a full list of conditional operators, check the reference sheet.

## AGGREGATE FUNCTIONS

Aggregate functions return a single value from a table, usually a calculated value from a column in the table. The syntax is: `FUNCTIONNAME(ColumnToCalculate)`, where FUNCTIONNAME is the name of the function (see reference sheet for a full list) and ColumnToCalculate is passed as an argument to the function.

For example, if you wanted to find the maximum value in a column titled Price, you would use the MAX function passing the column Price as an argument:

```
SELECT MAX(Price)
FROM Dish;
```

The COUNT function returns the total number of rows returned. For example, if you had 25 rows in the Dish table, the command

```
SELECT COUNT(*)
FROM Dish;
```

would return a single value, 25. If you put a column value as an argument, it would return the number of **non-null values** in the table for that column. 

If you wanted to count the number of Vegetarian dishes in the table, you could use the count function with a where clause:

```
SELECT COUNT(*)
FROM Dish
WHERE Vegetarian = TRUE;
```

This will return the number of rows returned by the where clause, which is all the dishes that are categorized as vegetarian.

## ORDER BY & LIMIT

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

We might also want to limit the results returned. For example, if we wanted to find the top 5 cheapest dishes available, we could use the `LIMIT` clause, which limits the number of rows returned:

```
SELECT * FROM Dish
ORDER BY Price
LIMIT 5;
```

This orders the dishes by Price in ascending order, then returns only 5 results, which are the top 5 lowest priced dishes.

## INSERTING & DELETING
#### Insertion
Before inserting data into a table, we need to know the columns of our table. We can use the `PRAGMA table_info(TableName)` command to return a list of a table’s columns and the data types. We can use this when entering the data to ensure we are repsecting the data type integrity. 

For example, the Dish table has 5 columns: Id (INTEGER), Name (VARCHAR(255)), Category VARCHAR(255), Vegetarian (BOOLEAN), and Price (REAL).

To add a new row, we need to insert values into each of these columns, except ID, which auto increments (more on that in the DDL lesson).

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

#### Deleting
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

--> Note that omitting the WHERE clause entirely will ***delete every row in the table!***

We could also make sure we are deleting the right now by checking the Id with a SELECT statement

```
SELECT Id FROM Dish
WHERE Name LIKE 'Sandwich';
```

This will return the Id of all the rows containing the word sandwich in the name. If there is more than 1 row, this means all these rows will be deleted if we used this in a `WHERE` clause with `DELETE`. 
Instead, we can find the ID of the correct row and delete that:

```
SELECT Id FROM Dish
WHERE Name LIKE 'Grilled Veggie Sandwich'; 
```
→ Returns 26

```
DELETE FROM Dish
WHERE Id = 26;
```

Since Id is a unique value, this will only delete one row, with the matching Id.

## UPDATING

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






