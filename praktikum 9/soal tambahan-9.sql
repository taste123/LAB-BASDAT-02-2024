use library;

SET SQL_SAFE_UPDATES = 0;


-- nomor 1
start transaction;
insert into authors (name, nationality)
values ("Gabriel Garcia Marquez","Colombian"),("Haruki Murakami",""), ("George Orwell", "British"), ("J.K. Rowling", "British");

insert into books (isbn, title, author_ID, publsihed_year, genre, copies_available)
values (7040289780000, "Norwegian Wood", (select id from authors where name = "Haruki Murakami"), 1987,"Romance", 12),
(9780375704000, "1984", (select id from authors where name = "George Orwell"), 1949,"Dystopian", 3),
(978074753200, "Harry Potter and the Philosopher's Stone", 11, 1997,"", 2),
(7210301703000, "The Running Grave", 11, 2016,"Fiction", 20);

insert into members (first_name, last_name, email, phone_number, join_date, membership_type)
values ("Ethan", "Collins", "ethan@example.com", null, "2024-03-24", ""),
("Sofia", "Rivera", "rivera@example.com", 0001231231, "2024-04-05", "Standar"),
("Williams", "", "williams123@example.com", 3213214456, "2023-04-06", "Premium");

insert into borrowings (member_id, book_id, borrow_date, return_date)
values ((select id from members where first_name = "Ethan" and last_name = "Collins"), 35, "2024-07-10", "2024-07-25"),
((select id from members where first_name = "Ethan" and last_name = "Collins"), 38, "2024-08-01", null),
((select id from members where first_name = "Williams" and last_name = ""), 37, "2024-09-06", "2024-09-09"),
((select id from members where first_name = "Sofia" and last_name = "Rivera"), 35, "2024-09-08", null),
((select id from members where first_name = "Williams" and last_name = ""), 36, "2024-09-10", null);

commit;
rollback;

select * from authors;
select * from books;
select * from members;
select * from borrowings;