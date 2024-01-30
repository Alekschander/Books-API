var express = require("express");
var cors = require("cors");
var app = express();
const mysql = require("mysql");
const port = 3000;

app.use(cors());

const connection = mysql.createConnection({
    host: "localhost",//CHANGE ME!!!!!!!
    user: "root",//CHANGE ME!!!!!!!
    password: "", //CHANGE ME!!!!!!!
    database: "books_db"
  });

  connection.connect(function(err) {
    if (err) throw err;
    console.log("Connected!");
  });

  app.get("/api/books",(req,res)=>{ //everything saved in the books table

    connection.query("SELECT *  FROM b_book",(err,results)=>{
        if(err){
            res.status(500).json({ error: "Error fetching data" });
            return;
        }
        res.send(results);
    });  
  });

  app.get("/api/books/all",(req,res)=>{// all information on the books and its relations

    connection.query("select b_title,a_firstname,a_lastname,c_name from b_book inner join  a_author on b_author = a_id inner join c_category on b_category = c_name;",(err,results)=>{
        if(err){
            res.status(500).json({ error: "Error fetching data" });
            return;
        }
        res.send(results);
    });
  });

   app.get("/api/books/:attr/:title",async(req,res)=>{ // fetch any attribute from a book with or without the "b_" prefix

    connection.query("SELECT b_title,b_"+req.params.attr+" FROM b_book where b_title='"+req.params.title+"'",(err,results)=>{
        if(results)
        {
            res.send(results);
        }else{
            connection.query("SELECT b_title,"+req.params.attr+" FROM b_book where b_title='"+req.params.title+"'",  (errnew,resultsnew)=>{
                if(errnew) { res.status(500).json({ error: "Error fetching data" });}
                if(resultsnew){  res.send(resultsnew);}
            });
        }
    });
  });

  app.get("/api/authors/:afirst/:alast/totalpagecount",(req,res)=>{ // pagecount of all the books an author wrote 

    connection.query("select SUM(b_pages) as total_pages from a_author inner join b_book on b_author = a_id where a_firstname = '"+req.params.afirst+"' and a_lastname = '"+req.params.alast+"';",(err,results)=>{
        if(err){
            res.status(500).json({ error: "Error fetching data" });
            return;
        }
        res.send(results);
    });
  });

  app.get("/api/categories/avg/pagecount",(req,res)=>{ // average pagecount for each category 

    connection.query("SELECT c_name, AVG(b_pages) AS avg_pages FROM b_book INNER JOIN c_category ON b_category = c_name  GROUP BY c_name ORDER BY avg_pages DESC;  ",(err,results)=>{
        if(err){
            res.status(500).json({ error: "Error fetching data" });
            return;
        }
        res.send(results);
    });
  });

  app.get("/api/categories/avg/books",(req,res)=>{ // avarege book count from each category 
    connection.query("SELECT c_name, AVG(b_id) AS avg_books FROM b_book INNER JOIN c_category ON b_category = c_name  GROUP BY c_name ORDER BY avg_books DESC;  ",(err,results)=>{
        if(err){
            res.status(500).json({ error: "Error fetching data" });
            return;
        }
        res.send(results);
    });
  });

  app.get("/api/categories/stats",(req,res)=>{ // the number of books and pages each category has

    connection.query("SELECT c_name, COUNT(b_id) AS number_of_books, SUM(b_pages) AS total_pages FROM c_category LEFT JOIN b_book  ON c_name = b_category GROUP BY c_name ORDER BY number_of_books DESC, total_pages DESC;",(err,results)=>{
        if(err){
            res.status(500).json({ error: "Error fetching data" });
            return;
        }
        res.send(results);
    });
  });

  // Close the MySQL connection when the Node.js process terminates
process.on("SIGINT", () => {
    connection.end((err) => {
      if (err) {
        console.error("Error closing connection:", err);
        return;
      }
      console.log("MySQL connection closed");
      process.exit();
    });
  });

  app.listen(port, () => {
    console.log(`Example app listening on port ${port}`);
  });