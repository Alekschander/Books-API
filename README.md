# Fetch information about Books!

In this project I've programmed an API where you can fetch ambiguous data from a database filled with information about books.


# SQL/Database

The database consists of 3 Tables: **b_book**, **a_author** and **c_category**. 
(Insert are statements included)
In the Javascript/API part of this project select statements are being queried.

# Javascript/API

The API creates a connection to the database and queries it.

*/api/books* 
*/api/books/all*  All the information about each book like  its category and Author 
*/api/books/:attr/:title* Query any attribute of a book
*/api/authors/:afirst/:alast/totalpagecount* How many Pages an Author wrote
*/api/categories/avg/pagecount* Average pagecount of each category
*/api/categories/avg/books*  Average number of books for each category
*/api/categories/stats* Number of books and pages of each category

# How to setup

1. Run the `booksdb.sql` file 
2. Open terminal
	2.1 Change to designated directory
3. Run this command: `node index.js`
