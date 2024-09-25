use library;

SET SQL_SAFE_UPDATES = 0;


-- nomor 1
insert into authors (name, nationality)
values ("Tere Liye","Indonesia"),("J.K. Rowling","British"), ("Andrea hinata", "");

insert into books (isbn, title, author_ID, publsihed_year, genre, copies_available)
values (7040289780375, "Ayah", (select id from authors where name = "Andrea Hinata"), 2015,"Fiction", 15),
(9780375704025, "Bumi", (select id from authors where name = "Tere Liye"), 2014,"Fantasy", 5),
(8310371703024, "Bulan", (select id from authors where name = "Tere Liye"), 2015,"Fantasy", 3),
(9780747532699, "Harry Potter and the Philosopher's stone", (select id from authors where name = "J.K. Rowling"), 1997,"", 10),
(7210301703022, "The Running Grave", (select id from authors where name = "J.K. Rowling"), 2016,"Fiction", 11); 

insert into members (first_name, last_name, email, phone_number, join_date, membership_type)
values ("John", "Doe", "John.doe@example.com", null, "2023-04-29", ""),
("Alice", "Johnson", "alice.johnson@example.com", 1231231231, "2023-05-01", "Standar"),
("Bob", "Williams", "bob.williams@example.com", 3213214321, "2023-06-20", "Premium");
-- values ((substring_index("John Doe", " ",1)), (substring_index("John Doe", " ",-1)), "John.doe@example.com", null, "2023-04-29", "");

insert into borrowings (member_id, book_id, borrow_date, return_date)
values ((select id from members where first_name = "John" and last_name = "Doe"), (select id from books where title = "Harry Potter and the Philosopher's Stone"), "2023-07-10", "2023-07-25"),
((select id from members where first_name = "Bob" and last_name = "Williams"), (select id from books where title = "Ayah"), "2023-08-01", null),
((select id from members where first_name = "Alice" and last_name = "Johnson"), (select id from books where title = "The Running Grave"), "2023-09-06", "2023-09-09"),
((select id from members where first_name = "Alice" and last_name = "Johnson"), (select id from books where title = "Bulan"), "2023-09-08", null),
((select id from members where first_name = "Bob" and last_name = "Williams"), (select id from books where title = "Bumi"), "2023-09-10", null);


-- nomor 2
update books
set copies_available = copies_available - 1
where id in (select id from borrowings where return_date is null);

-- where id = 1 or id = 2 or id = 3;

-- UPDATE books b
-- JOIN borrowings bo ON b.id = bo.book_id
-- SET b.copies_available = b.copies_available - 1
-- WHERE bo.return_date IS NULL;

-- nomor 3

update members
set membership_type = "standar"
where id in (select member_id from borrowings where return_date is null) and membership_type = "premium";

update members
set membership_type = ""
where id in (select member_id from borrowings where return_date is null) and membership_type = "standar";
 

select * from authors;
select * from books;
select * from members;
select * from borrowings;

describe borrowings;
describe members;
describe books;
describe authors;