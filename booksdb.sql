-- database-#############################################
drop database if exists books_db;
create database books_db;
use books_db;
-- switch autocommit off
set autocommit=0;
-- tables-#################################################
-- table a_author
create table a_author(
     a_id int not null,
     a_lastname varchar(100) not null,
     a_firstname varchar(100) not null,
     primary key(a_id)
);

-- table b_book
create table b_book(
     b_id int not null auto_increment ,
     b_title varchar(100) not null,
     b_pages int not null,
     b_category varchar(100),
     b_author int,
     primary key(b_id)
)auto_increment=1;

-- table c_category
create table c_category(
     c_name varchar(100) not null,
     primary key(c_name)
);






-- insert statements-#################################################
-- table a_author
insert into a_author(a_id, a_firstname, a_lastname) values
    (8, 'Agatha', 'Christie'),
    (9, 'Stephen', 'King'),
    (10, 'Virginia', 'Woolf'),
    (11, 'Charles', 'Dickens'),
    (12, 'Margaret', 'Atwood'),
    (13, 'Gabriel Garcia', 'Marquez'),
    (14, 'Haruki', 'Murakami'),
    (15, 'Herman', 'Melville'),
    (16, 'Leo', 'Tolstoy'),
    (17, 'Jane', 'Austen'),
    (18, 'William', 'Shakespeare'),
    (19, 'George', 'Eliot'),
    (20, 'Fyodor', 'Dostoevsky'),
    (21, 'Ernest', 'Hemingway'),
    (22, 'H.G.', 'Wells'),
    (23, 'Edgar Allan', 'Poe'),
    (24, 'Oscar', 'Wilde'),
    (25, 'Emily', 'Bronte'),
    (26, 'Kurt', 'Vonnegut'),
    (27, 'James', 'Joyce'),
    (28, 'D.H.', 'Lawrence'),
    (29, 'Nathaniel', 'Hawthorne'),
    (30, 'Franz', 'Kafka'),
    (31, 'J.D.', 'Salinger'),
    (32, 'H.P.', 'Lovecraft'),
    (33, 'Ray', 'Bradbury'),
    (34, 'John', 'Steinbeck'),
    (35, 'Arthur', 'Conan Doyle');
        
-- table b_book
insert into b_book(b_title, b_pages, b_author, b_category) values
    ('Pride and Prejudice', 432, 17, 'Romance'),
    ('Hamlet', 210, 18, 'Drama'),
    ('Middlemarch', 800, 19, 'Classic'),
    ('Crime and Punishment', 670, 20, 'Classic'),
    ('The Old Man and the Sea', 127, 21, 'Classic'),
    ('The Time Machine', 118, 22, 'Science Fiction'),
    ('The Raven', 64, 23, 'Poetry'),
    ('The Picture of Dorian Gray', 320, 24, 'Classic'),
    ('Wuthering Heights', 416, 25, 'Romance'),
    ('Slaughterhouse-Five', 275, 26, 'Science Fiction'),
    ('Ulysses', 730, 27, 'Classic'),
    ('Lady Chatterley’s Lover', 364, 28, 'Romance'),
    ('The Scarlet Letter', 256, 29, 'Drama'),
    ('The Metamorphosis', 201, 30, 'Classic'),
    ('The Catcher in the Rye', 214, 31, 'Young Adult'),
    ('The Call of Cthulhu', 43, 32, 'Horror'),
    ('Fahrenheit 451', 158, 33, 'Science Fiction'),
    ('The Grapes of Wrath', 464, 34, 'Classic'),
    ('The Adventures of Sherlock Holmes', 307, 35, 'Mystery');
        
-- table c_category
insert into c_category(c_name) values
	('Classic'),
    ('Romance'),
    ('Drama'),
    ('Philosophy'),
    ('Memoir'),
    ('Biography'),
    ('Self-Help'),
    ('Business'),
    ('Health'),
    ('Travel'),
    ('Cooking'),
    ('Art'),
    ('Poetry'),
    ('Children’s Literature'),
    ('Young Adult'),
    ('Graphic Novel'),
    ('Science Fiction'),
    ('Crime Fiction'),
    ('Non-Fiction'),
    ('Satire'),
    ('Horror'),
    ('Mystery'),
    ('Fantasy');        
-- foreign keys-#################################################
alter table b_book
add foreign key (b_category) references c_category(c_name) on delete restrict on update restrict,
add foreign key (b_author) references a_author(a_id) on delete restrict on update restrict;
-- commit all changes
commit;