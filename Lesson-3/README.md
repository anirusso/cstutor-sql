# LESSON THREE: SQL COMMANDS (DDL)

## SQL FILE

So far, we’ve been using the SQLite3 interactive terminal to write commands. But we can use a file to store commands and read it into the terminal instead. This will make it easier when building a database later on.

To start, create a new file, using a preferred text editor or the command line, and make sure the file is stored with the extension .sql. For example, the Restaurant.sql file we used the .read command on is a sql file containing a series of commands that are run when the file is read.

#### Comments
A comment is used in an SQL file to mark human-readable and computer-ignored lines. A line of code which is “commented out” will not be evaluated and is there solely for the benefit of a person reading it.
You can use comments in your SQL file by typing `--` followed by the comment. For example, 

```--this is a comment``` 

will comment out the line starting from the dashes to the end of the line.

Typing:

```
/*
Commented out
*/
```

will comment out multiple lines from the first `/*` to the ending `*/`

## CREATING A TABLE

To create a new table within a database, we can use the command `CREATE TABLE TableName (...);`, passing in the parenthesis the data types and names of each column we want in our table.

For example, to create a new table called Order, with 3 columns pertaining to the Id of the order, the name on the order, and the total price, we could use:

```
CREATE TABLE Order (
  OrderId INT,
  Name VARCHAR(255),
  Total REAL
);
```

Note the datatypes of each column:
- **Id** will hold the integer id of each order, from 1 – n orders, so we use INT.
- **Name** holds the name on the order, a String value, so we use VARCHAR(255).
- **Total** will be the total price of the order, so it will be a double precision value, or decimal value, using REAL.

#### Primary Key

The Id value of the column will uniquely identify each row. We can set this value to auto-increment instead of setting it manually each time using the following command:
```
ColumnName1 INT PRIMARY KEY AUTOINCREMENT
```

This will automatically set the first row to 1, the next row to 2, and so on. No values will be duplicated.

If we want to add multiple columns to the primary key, we can use the `CONSTRAINT` keyword after we create the columns:

```
CREATE TABLE TableName (
  Column1 DataType, 
  Column2 DataType, …
  CONSTRAINT PK_Name PRIMARY KEY (Column1, Column2)
);
```
This will create a primary key from the value of both Column1 & Column2 together. 

#### Unique Values

If we want to make sure that the table we are creating does not already exist, we can use `IF NOT EXISTS` before the table name when creating a table:

```
CREATE TABLE IF NOT EXISTS Order ( …
```

To create a unique value for a column, we can use the `UNIQUE` keyword after the datatype when creating a column:

```
CREATE TABLE IF NOT EXISTS TableName (
  ColumnName1 DataType UNIQUE, …
);
```

This will ensure that every value entered for this column is unique. If the value is not unique, the RDBMS will return an error.

If we want to ensure that every row in a column has a value, ie, there are no NULL values, we can use `NOT NULL`:

```
CREATE TABLE IF NOT EXISTS TableName (
  ColumnName1 DataType NOT NULL, …
);
```

# ALTERING & DELETING A TABLE

We can use the `ALTER TABLE TableName` command to make changes to a table we already created. After typing the above command, we can add the alteration we want to make.

Alterations:
- Add a new column: `ADD COLUMN ColumnName DataType`
- Delete a column: `DROP COLUMN ColumnName`
- Rename a column: `RENAME COLUMN OldName TO NewName`
- Rename a table: `RENAME TO NewTableName`

Note that when adding a new column, all previous rows will set the value of the new column to NULL. If we want the new column to be non-null, that is, we want to set a constraint that every row should have a value for this column, we can set a **default value**:

```
ALTER TABLE TableName
ADD COLUMN ColumnName DataType
NOT NULL
DEFAULT DefaultValue;
```

We can also set the default value when creating a new column. This will set the column value to DefaultValue for every row which does not explicitly set the value when adding a row. 

#### Deleting
To delete every row in a table, we can use the `TRUNCATE TABLE TableName` command. The table will still exist and can be altered and added to.

To delete the table itself, we can use the `DROP TABLE TableName` command. The table will be dropped and can no longer be altered or added to.

# JOINING TABLES

Sometimes, we want to join data from one table to another. Let’s look at the Restaurant table in our database:

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
```

This command will return *every row of Dish matched with every row from Restaurant*. This multiple pairing is known as a **Cartesian Join**.

For example, if we have a table T1 and a second table T2, as follows:

|T1   | T2 |
|-----| ---|
|1		| A  |
|2		| B  |
|3		| C  |

A cartesian join will produce:

#### T1 x T2
| T1|T2 |
| - | - |
| 1 | A |
| 1 | B |
| 1 | C |
| 2 | A |
| 2 | B |
| 2 | C |
| 3 | A |
| 3 | B |
| 3 | C |

The result set is not very meaningful for our purposes. Instead, we want to join tables which are connected by a foreign key or another connected value.

If we want to join the Dish and Restaurant table, we could connect them by the Id column of Dish and BestSellerId of Restaurant in a `WHERE` clause.

```
SELECT *
FROM Restaurant, Dish
WHERE Restaurant.BestSellerId = Dish.Id;
```

The result set is a meaningful connection showing the columns of Restaurant matched with the columns of Dish, where the Id of Dish is included in the list of BestDishId’s.

### INNER JOIN

We can accomplish the same result by using an **inner join**, which joins two tables on a condition:

```
SELECT * FROM Restaurant
INNER JOIN Dish ON Restaurant.BestSellerId = Dish.Id;
```

The result set will be the same: The restaurants with a BestSellerId will be matched with the rows of a dish with the matching Id.

### LEFT JOIN

If we want to return all the values from one table, plus only the matching values from another, we can use a **left join**:

```
SELECT * FROM Restaurant
LEFT JOIN Dish ON Restaurant.BestSellerId = Dish.Id;
```

This will return all restaurants, including those without a value in the BestSellerId column. It will include only those dishes with a matching Id in the BestSellerId column, and for those restaurants without, the values will be null.

If we want to return only a selected column, instead of all the columns, we could specify that:

```
SELECT Name FROM Restaurant
LEFT JOIN Dish ON Restaurant.BestSellerId = Dish.Id;
```

The above command creates a problem: Trying to return the Name column is ambiguous as both tables have a Name column; which one do we want?

We can specify the table we want the columns of by using the dot operator:

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

#### Using an Alias

Typing out the names of each table can be cumbersome. Instead, we can use an alias, which is temporary renaming of a table to be returned. Note that this does not change the table name itself, only a temporary value when a table is returned. The `AS` keyword specifies an alias:

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

