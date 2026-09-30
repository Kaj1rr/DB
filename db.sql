CREATE TABLE readers (
    reader_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20)  NOT NULL UNIQUE
);

CREATE TABLE books (
    isbn  VARCHAR(20) PRIMARY KEY,
    title  VARCHAR(200) NOT NULL,
    publish_year INT CHECK (publish_year BETWEEN 1000 AND 2100)
);

CREATE TABLE authors (
    author_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL
);

CREATE TABLE book_authors (
    isbn VARCHAR(20) NOT NULL,
    author_id INT  NOT NULL,
    PRIMARY KEY (isbn, author_id),
    FOREIGN KEY (isbn)  REFERENCES books(isbn) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE CASCADE
);


CREATE TABLE loans (
    loan_id  SERIAL PRIMARY KEY,
    reader_id  INT NOT NULL,
    isbn   VARCHAR(20) NOT NULL,
    loan_date  DATE NOT NULL,
    due_date DATE NOT NULL,
    actual_return_date DATE,
    FOREIGN KEY (reader_id) REFERENCES readers(reader_id),
    FOREIGN KEY (isbn)  REFERENCES books(isbn),
    CHECK (due_date >= loan_date),
    CHECK (actual_return_date IS NULL OR actual_return_date >= loan_date)
);


INSERT INTO readers (full_name, phone) VALUES
('Анна Петрова','+7-900-111-22-33'),
('Иван Соколов', '+7-900-222-33-44'),
('Мария Ким', '+7-900-333-44-55'),
('Олег Васильев','+7-900-444-55-66');


INSERT INTO books (isbn, title, publish_year) VALUES
('978-5-17-118366-8', 'Мастер и Маргарита', 1967),
('978-5-389-06256-6', 'Преступление и наказание', 1866),
('978-5-04-116716-3', 'Война и мир', 1869),
('978-5-699-12014-7', 'Золотой теленок',1931),
('978-5-389-03713-7', 'Пикник на обочине',1972);


INSERT INTO authors (full_name) VALUES
('Михаил Булгаков'), 
('Федор Достоевский'), 
('Лев Толстой'),
('Илья Ильф'), 
('Евгений Петров'),
('Аркадий Стругацкий'), 
('Борис Стругацкий');


INSERT INTO book_authors (isbn, author_id) VALUES
('978-5-17-118366-8', 1),
('978-5-389-06256-6', 2),
('978-5-04-116716-3', 3),
('978-5-699-12014-7', 4),   
('978-5-699-12014-7', 5),   
('978-5-389-03713-7', 6),  
('978-5-389-03713-7', 7);   


INSERT INTO loans (reader_id, isbn, loan_date, due_date, actual_return_date) VALUES
(1, '978-5-17-118366-8', '2025-09-01', '2025-09-15', NULL),
(2, '978-5-389-06256-6', '2025-09-05', '2025-09-20', NULL),
(1, '978-5-04-116716-3', '2025-08-01', '2025-08-15', '2025-08-10'),
(3, '978-5-699-12014-7', '2025-07-10', '2025-07-25', '2025-07-20'),
(2, '978-5-389-03713-7', '2025-06-01', '2025-06-15', '2025-06-14'),
(4, '978-5-17-118366-8', '2025-08-20', '2025-09-03', '2025-09-01');


UPDATE readers
SET phone = '+7-900-999-88-76'
WHERE reader_id = 3;

UPDATE loans
SET actual_return_date = '2025-09-12'
WHERE loan_id = 1;

INSERT INTO readers (full_name, phone)
VALUES ('Читатель2', '+7-000-000-00-00');

DELETE FROM readers
WHERE full_name = 'Читатель2';


SELECT * FROM Readers;


SELECT title, publish_year FROM Books;


SELECT title, publish_year
FROM Books
WHERE publish_year BETWEEN 1801 AND 1900;


SELECT title, publish_year
FROM Books
WHERE publish_year BETWEEN 1917 AND 1991;


SELECT * FROM Readers
WHERE phone = '+7-900-333-44-55';


SELECT * FROM Readers
WHERE full_name LIKE '%Петров%';


SELECT * FROM Loans
WHERE actual_return_date IS NULL;


SELECT title, publish_year
FROM Books
ORDER BY title ASC;

SELECT loan_id, reader_id, isbn, due_date
FROM Loans
WHERE actual_return_date IS NULL
ORDER BY due_date ASC;


SELECT title, publish_year
FROM Books
ORDER BY publish_year ASC
LIMIT 3;
