-- comments are made like this in SQL
-- this SQL script covers all the different commands we have utilised in option A uptill now


-- Last updated 22 Sept. 2024

-- Creating a database

DROP DATABASE LibInfo; -- used to kill a database / table
DROP TABLE Authors;


CREATE DATABASE LibInfo;
use LibInfo;

CREATE TABLE Authors (
    AuthorID INT NOT NULL auto_increment,
    A_Name VARCHAR(100) NOT NULL,
    Birthdate DATE,  
    Nationality VARCHAR(50), -- the number inside the varchar corresponds to the number of characters used to store the value 
    IsActive BOOLEAN,
    PRIMARY KEY (AuthorID)
);

CREATE TABLE Books ( -- create is a DDL (database definition language)
BookID INT NOT NULL auto_increment,
Title VARCHAR(200) NOT NULL,
Genre ENUM('Fiction', 'Non-Fiction', 'Poetry', 'Science Fiction', 'Fantasy', 'Biography') NOT NULL, -- if values other than the ones mentioned here are used, we would receive an error
PublishedYear INT CHECK (PublishedYear > 0), -- this is an example of validation 
Price DECIMAL(10, 2), -- this means that the decimal is represented by 10 digits and 2 places for the decimal
AuthorID INT,
PRIMARY KEY (BooKID),
FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);


-- inserting values into the table; notice how the ID columns are auto increment --> we only need to add values for the other columsn
-- if you want to add values for all the columns, use --> INSERT INTO AUTHORS VALUES (...);
INSERT INTO Authors (A_Name, Birthdate, Nationality, IsActive) VALUES
('J.K. Rowling', '1965-07-31', 'British', TRUE),
('George R.R. Martin', '1948-09-20', 'American', TRUE),
('Agatha Christie', '1890-09-15', 'British', FALSE),
('Mark Twain', '1835-11-30', 'American', FALSE),
('Maya Angelou', '1928-04-04', 'American', TRUE);


INSERT INTO Books (Title, Genre, PublishedYear, Price, AuthorID) VALUES
('Harry Potter and the Sorcerer\'s Stone', 'Fiction', 1997, 19.99, 1),
('A Game of Thrones', 'Fantasy', 1996, 29.99, 2),
('Murder on the Orient Express', 'Fiction', 1934, 14.99, 3),  -- Changed 'Mystery' to 'Fiction'
('The Adventures of Tom Sawyer', 'Fiction', 1876, 12.99, 4),
('I Know Why the Caged Bird Sings', 'Non-Fiction', 1969, 16.99, 5);  -- Changed 'Biography' to 'Non-Fiction' (if this was not done, we would receive an error)



-- there are two main kinds of functions in SQL -->
-- --> query functions: retrive value from a table(s) in a database
-- --> update functions: change the value of the database

SELECT * FROM Authors; -- select all columns
SELECT Title, Genre FROM Books; -- select only the columns mentioned

-- UPDATE COMMAND --> the update command change the value of already existing data
-- --> if a WHERE clause is added, only the specific row(s) are changed, else all rows are changed for that column


UPDATE Authors SET A_name = "M. Twain" WHERE AuthorID = 4;

-- Duplicating a database


CREATE TABLE IF NOT EXISTS dup_Authors LIKE AUTHORS; -- IF NOT EXISTS only make the command happen if the TABLE / DATABASE doesn't exist
INSERT INTO dup_Authors VALUES (1, 'A. Bhat', '1989-01-23', 'Indian', 0);
SELECT * FROM dup_Authors;

-- deleting all values in a table

TRUNCATE TABLE dup_Authors;
SELECT * FROM dup_Authors; -- now this table is empty

-- altering a table --> we can modify an existing table

ALTER TABLE dup_authors ADD A_Bio VARCHAR (255) NOT NULL;
SELECT * FROM dup_Authors; -- this would add a new column in the dup_Authors table

-- Changing the column name
ALTER TABLE dup_authors RENAME COLUMN A_Bio TO AuthorBio;
SELECT * FROM dup_Authors;
DROP TABLE dup_Authors;

-- Change the table name
ALTER TABLE Authors RENAME TO AuthorInfo;
SELECT * FROM AuthorInfo;

-- Using ALIAS + Relating two tables using foregin key

SELECT a.A_name, b.Title FROM Books as B, AuthorInfo as A WHERE (a.AuthorID = b.AuthorID); -- display the author name and its title

-- Deleting a tuple from a table + complex query + COMMIT + RollBACK

COMMIT;

DELETE FROM Books WHERE AuthorID IN (SELECT AuthorID FROM AuthorInfo WHERE A_name = 'Maya Angelou');
SELECT * FROM Books; -- Maya's book is gone 


ROLLBACK; 
SELECT * FROM Books; -- rollback reverts whatever was done between the last commit and the rollback statement

SAVEPOINT sep_22_2024;
RELEASE SAVEPOINT sep_22_2024; -- create a savepoint + delete a savepoint

-- Joins: A join SQL is an operation performed to establish a connection between two or more database tables based on MATCHING columns

SELECT * FROM AuthorInfo INNER JOIN Books on AuthorInfo.AuthorID = Books.AuthorID; -- Join the two tables if the COLUMNS MATCH and in this case they do MATCH

-- to demonstrate the process of the outer joins, some values would have to be removed from the table

UPDATE Books SET Title = 'Harry Potter and the Chamber of Secrets' WHERE BookID = 4;
UPDATE Books SET  AuthorID = 1 WHERE BookID = 4;
UPDATE Books SET Genre = 'Fantasy' WHERE BookID = 4;
UPDATE Books SET Price = 20.99 WHERE BookID = 4;
UPDATE Books SET PublishedYear = 1998 WHERE BookID = 4;
SELECT * FROM Books;

-- Left join: returns all records from the left table along with the matching records from the right table
SELECT AuthorInfo.AuthorID, AuthorInfo.A_Name, Books.Title, Books.PublishedYear
FROM AuthorInfo
LEFT JOIN Books ON AuthorInfo.AuthorID = Books.AuthorID;

-- This should gimme all the columns from the LEFT TBABLE along with teh matching records from the left table

SELECT AuthorInfo.AuthorID, AuthorInfo.A_Name, Books.Title, Books.PublishedYear
FROM AuthorInfo
RIGHT JOIN Books ON AuthorInfo.AuthorID = Books.AuthorID;

-- FUll outer join --> give output from both the tables
SELECT AuthorInfo.AuthorID, AuthorInfo.A_Name, Books.Title, Books.PublishedYear
FROM AuthorInfo
JOIN Books ON AuthorInfo.AuthorID = Books.AuthorID;

-- More complex selections


SELECT A_name FROM AuthorInfo WHERE A_name LIKE "J%"; -- the % symbol is a wild card character --> can have any number of any characters after this
SELECT Birthdate FROM AuthorInfo WHERE A_Name LIKE "M_______";-- the number of dashes SPECIFIES the random characters that can follow



-- OPERATORS FOR QUERYING
-- =: Equal to
-- <>: Not equal to
-- <: Less than
-- >: Greater than
-- <=: Less than or equal to
-- >=: Greater than or equal to


-- +: Addition
-- -: Subtraction
-- *: Multiplication
-- /: Division
-- %: Modulus (remainder)



-- LIKE: Pattern matching (e.g., %, _ for wildcards).
-- CONCAT(): Concatenates strings.
-- SUBSTRING(): Extracts a substring.
-- TRIM(): Removes spaces.


-- IN: Checks if a value exists in a set of values.
-- BETWEEN: Checks if a value falls within a specified range.

-- AND 
-- OR 
-- NOT

