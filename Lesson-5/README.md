# LECTURE FIVE: SQL FUNCTIONS
Description: Let’s look at some of the built-in SQL functions for working with data, such as math and datetime functions, and functional programming aspects including IF statements and CASE.

## MATH FUNCTIONS

SQLite provides several built-in math functions for working with and computing numbers:

`round(x[, y])` rounds a floating-point value x up to y decimal places. If y is omitted, it is assumed to be 0. 

`mod(x, y)` returns the remainder after dividing x by y, similar to the '%' operator, but works for non-integer arguments.

`pow(x, y)` / `power(x, y)` computes the value of x raised to the power of y.

`sqrt(x)` returns the square root of x, or NULL if x is negative.

`trunc(x)` truncates x, returning only the integer portion.

`floor(x)` returns the first representable integer value less than or equal to x.

`ceil(X)` / `ceiling(X)` returns the first representable integer value greater than or equal to x.

`abs(x)` Returns absolute value of numeric argument x

You can view a full list of SQLite math functions in the documentation: https://www.sqlite.org/lang_mathfunc.html

## DATE FUNCTIONS

SQLite does not have a specific Date type like other SQL database systems. For example, SQL Server and other database systems have functions such as `YEAR(date)`, `MONTH(date)` and `DAY(date)`, which can extract the year, month, or day from a given date.

However, SQLite does provide several functions to make working with strings as dates easier:

`date(time-value, modifier, ...)` Returns the date as text in the format ‘YYYY-MM-DD’

`time(time-value, modifier, ...)` Returns time as text in the format ‘HH:MM:SS’

`datetime(time-value, modifier, ...)` Returns the date and time as text in the format: ‘YYYY-MM-DD HH:MM:SS’

`julianday(time-value, modifier, ...)` Returns the Julian day - the fractional number of days since noon in Greenwich on November 24, 4714 B.C.

`unixepoch(time-value, modifier, ...)` Returns a unix timestamp - the number of seconds since 1970-01-01 00:00:00 UTC. 

`strftime(format, time-value, modifier, ...)` Returns the date formatted according to the format string specified as the first argument. The following is a complete list of valid strftime() substitutions:

- `%d`		day of month: 00
- `%f`		fractional seconds: SS.SSS
- `%H`		hour: 00-24
- `%j`		day of year: 001-366
- `%J`		Julian day number (fractional)
- `%m`		month: 01-12
- `%M`		minute: 00-59
- `%s`		seconds since 1970-01-01
- `%S`		seconds: 00-59
- `%w`		day of week 0-6 with Sunday==0
- `%W`		week of year: 00-53
- `%Y`		year: 0000-9999

`timediff(time-value1, time-value2)` Returns a string that describes the amount of time that must be added to time-value2 in order to reach time-value1. The format is: (+|-)YYYY-MM-DD HH:MM:SS.SSS

**Note:** In all functions other than timediff(), the time-value (and all modifiers) may be omitted, in which case a time value of 'now' is assumed, which returns the current time.

### Time Values

The following formats are accepted as time values:
1. YYYY-MM-DD
2. YYYY-MM-DD HH:MM
3. YYYY-MM-DD HH:MM:SS
4. YYYY-MM-DD HH:MM:SS.SSS
5. YYYY-MM-DDTHH:MM
6. YYYY-MM-DDTHH:MM:SS
7. YYYY-MM-DDTHH:MM:SS.SSS
8. HH:MM
9. HH:MM:SS
10. HH:MM:SS.SSS
11. now
12. DDDDDDDDDD

For values 5-7, T is a literal character separating the time and date, for example, as: `2013-10-07T08:23:19.120Z`

For values 8-10 which specify only a time, the date of 2000-01-01 is used.

Value 11, `now`, returns the current date as UTC.

Value 12 is the Julian day number expressed as an integer or floating point value.

### Modifiers

Other than timediff(), SQLite datetime functions can take modifiers as an argument after the time value argument. This is used to modify the value passed as a time value, and each modifier is applied from left to right. 

A non-exhaustive list of modifiers are:
- ` x days` / `x day` Add x days to date
- ` x hours` / `x hour` Add x hours to date
- ` x minutes` / `x minute` Add x minutes to date
- ` x seconds` / `x second` Add x seconds to date
- ` x months` / `x month` Add x months to date
- ` x years` / `x year` Add x years to date
- `HH:MM` Add HH hours and MM minutes to date
- `HH:MM:SS` Add HH hours, MM minutes and SS seconds to date
- `±YYYY-MM-DD` Add/subtract the YYYY-MM-DD from time value
- `±YYYY-MM-DD HH:MM` Add/subtract the YYYY-MM-DD and HH:MM from time value
- `±YYYY-MM-DD HH:MM:SS` Add/subtract the YYYY-MM-DD and HH:MM:SS from time value
- `start of month` Shift the date backwards to the beginning of the subject month
- `start of year` Shift the date backwards to the beginning of the subject year
- `start of day` Shift the date backwards to the beginning of the subject day.
- `weekday x` Advances the date to the next date where the weekday number is x (Sunday is 0, Monday is 1), and if it is already that day, leaves it as it is

Note that the first 8 commands can take an optional positive sign (+) or negative sign (-) before the `x` amount of time to either add or subtract that amount. For commands 9 - 11, the sign is mandatory.

### Examples

Get the current date: `SELECT date();`

Compute last day of current month: `SELECT date('now','start of month','+1 month','-1 day');`

Compute the current unix timestamp: `SELECT strftime('%s');`

You can view a full list of SQLite datetime functions in the documentation: https://www.sqlite.org/lang_datefunc.html


## OTHER FUNCTIONS

`changes()` returns  the number of database rows that were changed or inserted or deleted by the most recently completed INSERT, DELETE, or UPDATE statement

`total_changes()` returns the number of row changes caused by INSERT, UPDATE or DELETE statements since the current database connection was opened.

`ifnull(x, y)` returns a copy of its first non-NULL argument, or NULL if both arguments are NULL.

`length(x)` returns the number of characters in a string value x

`random()` returns a pseudo-random integer between -9223372036854775808 and +9223372036854775807.

`typeof(x)` returns a string that indicates the datatype of the expression X: "null", "integer", "real", "text", or "blob".

You can view a full list of SQLite scalar functions in the documentation: https://www.sqlite.org/lang_corefunc.html


## IF STATEMENTS

SQLite does not have an IF keyword as some other SQL databases do. Instead, there are two options.

### CASE
A `CASE` expression serves a role similar to IF-THEN-ELSE in other programming languages. The syntax is:

```
CASE expression
  WHEN value_1 THEN result_1
  WHEN value_2 THEN result_2
  ...
  [ ELSE result_else ] 
END
```

The CASE clause compares the expression to the values in the WHEN clause. If expression=value_1, result_1 will be returned. If expression=value_2, then result_2 will be returned. If no match is found, the result in the ELSE block will be returned. The statement ends with the END keyword.

Example:
```
SELECT SupplierName,
  CASE Country
    WHEN 'USA' THEN 'DOMESTIC'
    ELSE 'INTERNATIONAL'
  END Locale
FROM Suppliers;
```

The example above checks the value of the Country column in the Suppliers table. If the value in that column is equal to ‘USA’, then Domestic is returned, and if it’s not equal, then International is returned. These values are returned under the column ‘Locale’ along with the Supplier Name.

#### Boolean Comparisons

The CASE above can only check for equality between two expressions. If we wanted to do other forms of comparison, we could use the boolean comparison CASE:

```
CASE
  WHEN bool_expression_1 THEN result_1
  WHEN bool_expression_2 THEN result_2
  [ ELSE result_else ] 
END
```

This CASE expression evaluates the Boolean expressions in the WHEN clause and returns the corresponding result for the first expression which evaluates to true.

Both CASE expressions use lazy, or short-circuit, evaluation. It will return the result and stop evaluating other conditions as soon as it finds a match.

Example:

```
SELECT ProductName, price,
  CASE
    WHEN price < 20 THEN "cheap"
		WHEN price < 50 THEN "affordable"
		ELSE "expensive"
		END Category
FROM products;
```

The query above sorts the Price column from the Product table into 3 categories, and returns it as a column named Category.


### IIF() FUNCTION

`iif(check, x, y)` returns the value of x if ‘check’ is true, or y if ‘check’ if false.

It would be logically equivalent to 

```
CASE 
  WHEN check THEN y 
  ELSE z
END
```
