create database library;

use library;

create table authors (
id int primary key auto_increment,
name varchar(100) not null
);

create table books (
id int primary key auto_increment,
isbn varchar(13),
title varchar(100) not null,
author_id int,
foreign key (author_id) references authors(id)
);

show databases;
show tables;
describe authors;
describe books;

alter table authors
add nationality varchar(50);

alter table books
ADD CONSTRAINT unique_isbn UNIQUE (isbn);

describe authors;
describe books;

alter table books
modify title varchar(150) not null,
add publsihed_year year not null,
add genre varchar(50) not null,
add copies_available int;

alter table books
modify copies_available int not null;

create table members (
id int primary key auto_increment,
first_name varchar(50) not null,
last_name varchar(50) not null,
email varchar(100) unique,
phone_number char(10),
join_date date not null,
membership_type varchar(50) not null
);

alter table members
modify email varchar(100) unique not null;

create table borrowings (
id int primary key auto_increment,
member_id int,
foreign key(member_id) references members(id),
book_id int,
foreign key(book_id) references books(id),
borrow_date date not null,
return_date date
);

alter table borrowings
modify member_id int not null,
modify book_id int not null;

alter table authors
modify nationality varchar(50) not null;

alter table books
modify author_id int not null,
modify isbn varchar(13) not null;

describe authors;
describe books;
describe members;
describe borrowings;

drop database library;