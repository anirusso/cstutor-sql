# LECTURE ONE: SETTING UP YOUR ENVIRONMENT
Description: This lesson goes over the basics of setting up your environment, from basic command-line commands to setting up an sqlite database in both bash and Python.

## BASIC TERMINAL COMMANDS
The Terminal can be accessed:
- On MacOS: cmd + spacebar; search ‘Terminal’
- Linux: Search and select the Terminal 
- Windows: Using a terminal emulation program like cygwin or configuring settings to run a Windows Subsystem for Linux

The terminal will show a prompt, like `username@host-name:~/currentDir` (Replace username with your username, hostname with your computer name, and currentDir with the current directory you are in).

### Directories
**Directory:** A location on your computer, typically a folder (such as Documents or Downloads). From the command line you can access all directions within your computer.

**Working directory:** The directly you are currently in. 

<ins>Commands:</ins>

`pwd` Output the current working directly

`cd [directory]` Change current directory to the specified directory
- For example, if you are in the Documents folder, and you want to access a folder within the Documents folder titled cstutor-sql, you can type `cd cstutor-sql`. When you print the working directory again, it should list an absolute path ending with `/Documents/cstutor-sql`.

### Directory Structure

**Absolute path:** A filepath starting from your root folder.
- The root folder is specified by /. For example, `cd /` will take you to the root folder.

**Relative path:** A filepath starting from your current directory.
- The home folder is where you start when you open your terminal and is specified by “~”. You can go to your home directory by typing `cd ~` or just `cd` with no argument.

<ins>Commands</ins>

`cd ..` Change directory to the parent directory, ie, to the folder in which your current folder resides. For example, if you want to exit the cstutor-sql and return to the Documents folder.

`mkdir [directory-name]` Create a new directory with the specified directory-name

### Listing

`ls` List all the files and directories within your current directory

`ls [directory]` List all the files and directories within the specified directory



**Options:** You can specify optional flags to use in conjunction with commands to alter the command. 

Example:
- `ls -l` The **-l** option is short for **longform**, which outputs all files and directories in long form with more information.

- `ls -a` Outputs all files and directories including parent directories and hidden files and folders. 

### Deleting

`rm [filename]` Delete the specified file

`rm -r [directory]` Delete the specified directory
- Be careful when deleting a folder as it will delete all the contents within, including all directories. This is what the -r option means: recursively delete.

### Files

`touch [filename]` Create a new file in the current directory. You can edit this file in a regular text editor, or within the terminal by using the **nano text editor**. 

`nano [filename]` A command-line text editor which can be used to create and edit files within the command line.

### Output

`echo [output]` Output any arguments to standard output (the command line output)

`echo "text_to_output" > filename` Replace the text inside the specified file with “text_to_output”. 

`echo "text_to_output" >> filename` Add text to the end of the file instead of overwriting.

`cat filename` Output the text inside the file to standard output
- To show just the first five lines, you can use the `head -5` command with the filename.
- To show the last three lines, you can use `tail -3`.
- These can be customized with any number.


### OPTIONAL EXERCISES:
1. Create a folder in your current working directory titled sql-course
2. Enter the newly created folder and list the contents within
3. Create a file inside the directory called myfile.txt
4. Add a line inside the file.
5. Add another line after the first line.
6. Output the first 2 lines of the file.
7. Delete the file.
8. Go back to the previous directory
9. Delete the newly created directory (being careful to delete the right folder) 

Answers:
```
mkdir sql-course

cd sql-course
ls

touch myfile.txt

echo "line 1" > myfile.txt

echo "line 2" >> myfile.txt

head -2 myfile.txt

rm myfile.txt

cd ..

rm -r sql-course
```

## CREATING A DATABASE
Now that we have the basics of getting around the terminal, we can set up the SQLite3 environment we’ll be working in.

To start, download the git folder and access the directory. You can create a workspace within the git folder to practice with the database in the data directory. 

### Command Line for SQLite3
To use SQLite3, we’ll need to download it:
- MacOS: SQLite3 should come pre-installed with MacOS.
- Linux: On the terminal, use the command: `sudo apt install sqlite3`
- Windows: Download the sqlite3 package from the website: https://www.sqlite.org/download.html

To create a database to work with, use the command `sqlite3 DatabaseName.db`. You can call your database whatever you want, but make sure it ends with the .db file extension.

Your terminal should change to the SQLite3 interactive terminal. From here, we can use SQL commands directly, or we can read the commands from an SQL file. To read from an SQL file, we can use the command `.read filename.sql`.

### SQLite in Python

`import sqlite3 as sq` Import sqlite3 library

`connection = sq.connect("name.db")` Connect to database (or create new database)

`cursor = connection.cursor()` Create cursor to access database

`cursor.execute(command)` Execute command

`rows = cursor.fetchall()` Access rows returned by query

`row = cursor.fetchone()` Access single row returned by query

Example: Gets all results from tablename (variable holding the name of the table) and iterates through the rows, printing them

```
cursor.execute("SELECT * FROM " + tablename)
rows = self.cur.fetchall()
for row in rows:
    print(row)
```

### OPTIONAL EXERCISES:
1. Download the git folder and, in the main folder (with the README.md file), create a new directory called workspace
2. Enter workspace and print the working directory.
3. From the workspace folder inside the main cstutor-sql folder, create a database called Practice.db
4. Read an SQL file in the data folder (in a folder one directory up) called Restaurant.sql

Answers:

```
cd ./cstutor-sql
mkdir workspace

cd workspace
pwd

sqlite3 Practice.db

.read ../data/Restaurant.sql

```

