# LECTURE TWO: DDL
Description: This lesson goes over the basics of SQL, including data types and data modeling to create a schema, and goes over the basics of Data Definition Language.

## DATA AND VALUES

SQL, or structured query language, is a programming language which facilitates the ability to access and manipulate large sets of data. Data is stored in a table form, with columns of data, and rows of data entities.

For example, a table named Orders might hold values for each order:
- Each separate order is a **data entity**
- Columns would hold information on the entity, such as the orderId, the total, the date, etc.
- Rows would hold the information on a single entity, ie, a single order placed.

| OrderId             | Company   | Date | Total |
| ------------------- | -------- | ----- | ----- |
| 100 | Logistics Inc. | 2021-01-01 | 123.45 |
| 101 | ShippingJoy | 2021-01-02 | 500.50 |
| 110 | MovCo | 2021-01-03 | 60.00 |

The values in each column should be consistent. For example, an order shouldn’t have a decimal number under Company, or text under Total. 

In order for the data to be consistent, we need to have a specific **data type** when entering values. The data types describe the type of value of data being entered.

**Numbers:** can be integers or decimal:
- **Integer:** A whole number with no fractional part, positive or negative.
- - Examples: 0, -1, 123
- **Real:** A floating-point, or decimal number, positive or negative.
- - Examples: 0.0009, -3.50, 1.0

**Text:** a string of characters
- **varchar(num):** specifies a string of num characters
- - Examples: varchar(255) is a string of 255 characters
- **Text:** In SQLite, the value is a variable-length text string, stored using the database encoding

**Boolean:** True or False values
- **TRUE** can be specified using the text TRUE or the value 1
- **FALSE** can be specified using the text FALSE or the value 0

**Datetime:** SQLite does not have a specific format for dates. 
- A text such as `("YYYY-MM-DD HH:MM:SS.SSS")` can be used and formatted using datetime functions (more on those in further section).

**NULL:** If a cell of data is left blank, the value of that cell will be NULL. This means that the data for that particular column and row intersection is missing.

You can check the ref sheet for a list of data types with examples, or the sqlite documentation here: https://www.sqlite.org/datatype3.html.


## DATA MODELLING

Database management is the process of identifying real-world entities, attributes, and relationships, and forming these values into a database management system.

For example, in a Movie system, you might identify an entity as a Movie, with attributes such as Title, ReleaseDate, Director. 

We would then identify how these attributes and entities should be represented: the Movie schema would be represented as a table, with the Title being text, ReleaseDate being a datetime, RunningTime being an int or float, etc.

In a tabular data schema:
- Entities: table
- Attributes: columns
- Instances: rows

When defining a database, there are two kinds of language used:
- **DDL (Data definition Language)** represents the schema: commands for setting up schema of data (creating a database or table, deleting or altering structure of a table or column)
- **DML (Data Manipulation Language)** represents instance of data: commands to manipulate data, also called “query language” (selecting data, adding data, deleting data)

### ACID Properties

**Transaction:** A group one or more operations (DDL, DML) into a single unit of work.

Example:

```
BEGIN TRANSACTION
INSERT Movie
INSERT Movie’s Director IF NOT EXIST
INSERT Movie’s distributor Company IF NOT EXIST
END TRANSACTION
```

Transactions must adhere to certain properties known as **ACID properties**

**Atomicity:** All or nothing execution of transaction
- Does entire transaction, or else whole transaction undone; rollback of partial transaction changes

**Consistency:** Respect constraints or expectations among data instances 
- Example: All Movies Must Have at Least One Director constraint → you cannot enter a movie into the table if the director is not included

**Isolation:** Transactions appear to be executed as if no other transaction is executing at the same time (sequentially)
- Even if done in parallel, should appear as though executed sequentially

**Durability:** Once a transaction has committed, it’s effect must never be lost
- Example: function exception, program crash, system crash (files may not be durable, ie file deleted or corrupted on hard drive)

### Entities

**Entity:** An entity in a database is a thing, place, person or object that is independent of another, in which you can store data about.
- Example: The movie ‘The Birds’ in a movie table, or the order number ‘1001’ in a table of orders.

**Entity set:** A set of entities of the same type that share the same properties
- Example: The set of movies {‘The Birds’, ‘Apocalypse Now’, ‘Psycho’}

**Attributes:** Properties of entities in an entity set
- Example: Movies might have the properties ‘Title’, ‘Running time’, ‘Release date’

**Key:** An attribute or a set of attributes which uniquely identify an entity in entity set
- Example: an orderId, or a title in a movie. If there multiple movies with the same name, the set of attributes {Title, ReleaseDate} might suffice.
- The key must be unique and the key cannot be NULL

Now that we understand these properties, we can construct a table with the appropriate entities and attributes.


## SQL FILE
We can use a **.sql** file to store SQL commands needed to build a database schema. To start, create a new file, using a preferred text editor or the command line, and make sure the file is saved with the extension .sql. 

To create a database, use the `sqlite3 databasename.db` command on the command line. Then, to read your sql file, use the `.read filename.sql` command inside the interactive terminal. This will read the sql commands in the file and run the commands within the database.

A database can contain one or several tables. To view all the tables in a database, you can use the `.tables` command inside the sqlite3 terminal, after running `sqlite3 databasename.db`. If we want to know all the columns in a specific table, we can use the `PRAGMA table_info(TableName)` command. 

### Comments
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

**SYNTAX:** 
```
CREATE TABLE TableName (
  ColumnName Datatype,
  ColumnName2 Datatype,
  [...]
);
```

For example, to create a new table called Order, with 3 columns pertaining to the Id of the order, the name on the order, and the total cost, we could use:


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
- **Total** will be the total cost of the order, so it will be a double precision value, or decimal value, using REAL.

### Primary Key

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

Note that by convention, the constraint naming follows the syntax: `Constraint_Column1Name_Column2Name`

### Unique Values

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

Like the Primary key, we can use constraint to set multiple columns to be unique:

```
CREATE TABLE TableName (
  Column1 DataType, 
  Column2 DataType, …
  CONSTRAINT UK_Column1_Column2 UNIQUE (Column1, Column2)
);
```

If we want to ensure that every row in a column has a value, ie, there are no NULL values, we can use `NOT NULL`:

```
CREATE TABLE IF NOT EXISTS TableName (
  ColumnName1 DataType NOT NULL, …
);
```

## ALTERING & DELETING A TABLE

We can use the `ALTER TABLE TableName` command to make changes to a table we already created. After typing the above command, we can add the alteration we want to make.

### Altering
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

### Deleting
Delete every row in a table, leaving the table intact but empty: `TRUNCATE TABLE TableName`
- The table will still exist and can be altered and added to.

Delete the table itself: `DROP TABLE TableName`
- The table will be dropped and can no longer be altered or added to
