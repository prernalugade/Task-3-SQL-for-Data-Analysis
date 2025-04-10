CREATE TABLE transactions (
    InvoiceNo TEXT,
    StockCode TEXT,
    Description TEXT,
    Quantity INTEGER,
    InvoiceDate TIMESTAMP,
    UnitPrice NUMERIC,
    CustomerID TEXT,
    Country TEXT
);

INSERT INTO transactions VALUES
('536365','85123A','White Mug',6,'2010-12-01 08:26',2.55,'17850','United Kingdom'),
('536366','71053','Glass Bowl',6,'2010-12-01 08:34',3.39,'17850','United Kingdom'),
('536367','84406B','Mini Tray',8,'2010-12-01 08:52',2.75,'13047','France'),
('536368','84029G','Green Notebook',3,'2010-12-01 09:17',3.75,'12583','Germany'),
('536369','84029E','Red Notebook',2,'2010-12-01 09:45',3.75,'13748','Germany'),
('536370','84879','Red Pen',32,'2010-12-01 10:01',1.69,'15100','Italy'),
('536371','85099B','Set of Coasters',6,'2010-12-01 10:20',5.95,'14527','Portugal'),
('536372','79323P','Wall Clock',10,'2010-12-01 10:45',3.39,'13480','Spain'),
('536373','22086','Blue Mug',6,'2010-12-01 11:06',1.85,'15311','United Kingdom'),
('536374','22632','Candle Holder',12,'2010-12-01 11:30',2.55,'13263','France');

-- BASIC SELECT

SELECT * FROM transactions;

-- WHERE Clause

SELECT * FROM transactions
WHERE Country ='France';

-- ORDER BY

SELECT * FROM transactions
ORDER BY UnitPrice DESC;

-- GROUP BY with COUNT

SELECT Country, COUNT(*) AS total_orders
FROM transactions
GROUP BY Country;

-- GROUP BY with SUM

SELECT Country, SUM(Quantity * UnitPrice) AS total_sales
FROM transactions
GROUP BY Country;


CREATE TABLE products (
    StockCode TEXT PRIMARY KEY,
    Category TEXT,
    Supplier TEXT
);


INSERT INTO products VALUES
('85123A', 'Home Decor', 'UK Supplier'),
('71053', 'Kitchenware', 'UK Supplier'),
('84406B', 'Stationery', 'France Ltd'),
('84029G', 'Stationery', 'Germany Co'),
('84029E', 'Stationery', 'Germany Co'),
('84879', 'Office Supplies', 'Italy Corp'),
('85099B', 'Home Decor', 'Portugal Inc'),
('79323P', 'Clocks', 'Spain SA'),
('22086', 'Kitchenware', 'UK Supplier'),
('22632', 'Candleware', 'France Ltd');


-- INNER JOIN

SELECT t.InvoiceNo, t.Description, p.Category
FROM transactions t
INNER JOIN products p ON t.StockCode = p.StockCode;

-- LEFT JOIN

SELECT t.InvoiceNo, t.Description, p.Supplier
FROM transactions t
LEFT JOIN products p ON t.StockCode = p.StockCode;

-- RIGHT JOIN

SELECT p.StockCode, p.Category, t.InvoiceNo
FROM products p
RIGHT JOIN transactions t ON t.StockCode = p.StockCode;


-- SUBQUERY with WHERE CLAUSE

SELECT * FROM transactions
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM transactions);


-- Aggregate function (SUM, AVERAGE)
-- Total revenue per country

SELECT Country, SUM(Quantity * UnitPrice) AS TotalRevenue
FROM transactions
GROUP BY Country
ORDER BY TotalRevenue DESC

-- Average quantity sold per transaction

SELECT AVG(Quantity) AS AvgQuantitySold
FROM transactions;


-- VIEW

CREATE VIEW HighValueTransactions AS
SELECT *, Quantity * UnitPrice AS TotalValue
FROM transactions
WHERE Quantity * UnitPrice > 100;


-- INDEX

CREATE INDEX idx_country ON transactions(Country);
