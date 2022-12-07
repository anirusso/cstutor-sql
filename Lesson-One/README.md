# LESSON ONE: GETTING STARTED
Welcome to the first lesson in the CSTutor SQL course! This lesson goes over the basics: setting up your environment, getting used to using the Terminal, and starting up a SQLite Database.

## BASIC TERMINAL COMMANDS
The Terminal can be accessed:
- On MacOS: cmd + spacebar; search ‘Terminal’
- Linux: Search and select the Terminal 
- Windows: Using a terminal emulation program like cygwin or configuring settings to run a Windows Subsystem for Linux

The terminal should show a prompt, like `username@host-name:~/currentDir` (Replace username with your username, hostname with your computer name, and currentDir with the current directory you are in).

#### Directories
A directory is a folder on your computer. From the terminal, you can navigate to and access all the directories on your computer. To see which directory you are currently in, you can type the command: `pwd`. This will output the **working directory**, or the directory you are currently in.

To access a different directory, you can use the `cd` command, plus the directory you want to go into.

For example, if you are in the Documents folder, and you want to access a folder within the Documents folder titled cstutor-sql, you can type `cd cstutor-sql`. When you print the working directory again, it should list an absolute path ending with `/Documents/cstutor-sql`.

**Absolute path:** A filepath starting from your root folder.
- The root folder is specified by “/”. For example, `cd /` will take you to the root folder.

**Relative path:** A filepath starting from your current directory.
- The home folder is where you start when you open your terminal and is specified by “~”. You can go to your home directory by typing `cd ~` or just `cd` with no argument.

To go up in the directory path, you can type `cd ..`  as a command. The two dots, “..”, is an argument meaning the parent folder. For example, if you want to exit the cstutor-sql and return to the Documents folder.

To see the files and directories in the current directory, you can use the `ls` command. **Options** are optional flags you can use in conjunction with commands to alter the command. For example, you can use the `-l` option with ls to output the files and directories in long form with extra information by typing: `ls -l`.

To create a directory, you can use the `mkdir` command, plus the directory name you want to create. To delete a directory, use `rm -r directory-name`, replacing directory-name with the name of the directory you want to delete. Be careful when deleting a folder as it will delete all the contents within, including all directories. This is what the -r option means: recursively delete.

#### Files
To create a new file in the current directory, type `touch` plus the name of the file you want to create. You can edit this file in a regular text editor, or within the terminal by using the **nano text editor**. To edit a file using nano, type nano plus the name of the file you want to edit or create.

The `echo` command is used to output any arguments given to it. You can use it to output text into a file using `echo "text_to_output" > filename`. This will replace the text inside the file with “text_to_output”. To append (add to the end) instead of overwriting, you can use the `>>` operator. To display the text inside the file, you can use `cat filename`. To show just the first five lines, you can use the `head -5` command with the filename. To show the last three lines, you can use `tail -3`. These can be customized with any number.

To delete a file, you can use `rm filename`. You do not need the `-r` option to delete a file.

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

## SETTING UP YOUR ENVIRONMENT
Now that we have the basics of getting around the terminal, we can set up the SQLite3 environment we’ll be working in.

To start, download the git folder and access the directory. You can create a workspace within the git folder to practice with the database in the data directory. 

### EXERCISES:
1. Download the git folder and, in the main folder (with the README.md file), create a new directory called workspace
2. Enter workspace and print the working directory.

Answers:
```
cd ./cstutor-sql
mkdir workspace

cd workspace
pwd
```

## COMMAND LINE FOR SQLITE3
To use SQLite3, we’ll need to download it:
- MacOS: SQLite3 should come pre-installed with MacOS.
- Linux: On the terminal, use the command: sudo apt install sqlite3
- Windows: Download the sqlite3 package from the website: https://www.sqlite.org/download.html

To create a database to work with, use the command `sqlite3 DatabaseName.db`. You can call your database whatever you want, but make sure it ends with the .db file extension.

Your terminal should change to the SQLite3 interactive terminal. From here, we can use SQL commands directly, or we can read the commands from an SQL file. To read from an SQL file, we can use the command `.read filename.sql`.

### EXERCISES
1. From the workspace folder inside the main cstutor-sql folder, create a database called Practice
2. Read an SQL file in the data folder (in a folder one directory up) called Restaurant.sql

Answers:
```
sqlite3 Practice.db

.read ../data/Restaurant.sql
```
