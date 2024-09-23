CREATE DATABASE CarRentalSystem;
USE CarRentalSystem;

CREATE TABLE Vehicle (
    vehicleID INT PRIMARY KEY,
    make VARCHAR(50),
    model VARCHAR(50),
    year INT,
    dailyRate DECIMAL(10, 2),
    status VARCHAR(20),  
    passengerCapacity INT,
    engineCapacity INT
);

CREATE TABLE Customer (
    customerID INT PRIMARY KEY,
    firstName VARCHAR(50),
    lastName VARCHAR(50),
    email VARCHAR(100),
    phoneNumber VARCHAR(15)
);

CREATE TABLE Lease (
    leaseID INT PRIMARY KEY,
    vehicleID INT,
    customerID INT,
    startDate DATE,
    endDate DATE,
    type VARCHAR(20), 
    FOREIGN KEY (vehicleID) REFERENCES Vehicle(vehicleID),
    FOREIGN KEY (customerID) REFERENCES Customer(customerID)
);

CREATE TABLE Payment (
    paymentID INT PRIMARY KEY,
    leaseID INT,
    paymentDate DATE,
    amount DECIMAL(10, 2),
    FOREIGN KEY (leaseID) REFERENCES Lease(leaseID)

);

INSERT INTO Vehicle (vehicleID, make, model, year, dailyRate, status, passengerCapacity, engineCapacity)
VALUES 
    (1, 'Toyota', 'Camry', 2022, 50.00, 'available', 4, 1450),
    (2, 'Honda', 'Civic', 2023, 45.00, 'available', 7, 1500),
    (3, 'Ford', 'Focus', 2022, 48.00, 'notAvailable', 4, 1400),
    (4, 'Nissan', 'Altima', 2023, 52.00, 'available', 7, 1200),
    (5, 'Chevrolet', 'Malibu', 2022, 47.00, 'available', 4, 1800),
    (6, 'Hyundai', 'Sonata', 2023, 49.00, 'notAvailable', 7, 1400),
    (7, 'BMW', '3 Series', 2023, 60.00, 'available', 7, 2499),
    (8, 'Mercedes', 'C-Class', 2022, 58.00, 'available', 8, 2599),
    (9, 'Audi', 'A4', 2022, 55.00, 'notAvailable', 4, 2500),
    (10, 'Lexus', 'ES', 2023, 54.00, 'available', 4, 2500);


	INSERT INTO Customer (customerID, firstName, lastName, email, phoneNumber)
VALUES 
    (1, 'John', 'doe', 'johndoe@example.com', '555-555-5555'),
    (2, 'Jane', 'Smith', 'janesmith@example.com', '555-123-4567'),
    (3, 'Robert', 'Johnson', 'robert@example.com', '555-789-1234'),
    (4, 'Sarah', 'Brown', 'sarah@example.com', '555-456-7890'),
    (5, 'David', 'Lee', 'david@example.com', '555-987-6543'),
    (6, 'Laura', 'Hall', 'laura@example.com', '555-234-5678'),
    (7, 'Michael', 'Davis', 'michael@example.com', '555-876-5432'),
    (8, 'Emma', 'Wilson', 'emma@example.com', '555-432-1098'),
    (9, 'William', 'Taylor', 'william@example.com', '555-321-6547'),
    (10, 'Olivia', 'Adams', 'olivia@example.com', '555-765-4321');

	INSERT INTO Lease (leaseID, vehicleID, customerID, startDate, endDate, type)
VALUES 
    (1, 1, 1, '2023-01-01', '2023-01-05', 'Daily'),
    (2, 2, 2, '2023-02-15', '2023-02-28', 'Monthly'),
    (3, 3, 3, '2023-03-10', '2023-03-15', 'Daily'),
    (4, 4, 4, '2023-04-20', '2023-04-30', 'Monthly'),
    (5, 5, 5, '2023-05-05', '2023-05-10', 'Daily'),
    (6, 4, 3, '2023-06-15', '2023-06-30', 'Monthly'),
    (7, 7, 7, '2023-07-01', '2023-07-10', 'Daily'),
    (8, 8, 8, '2023-08-12', '2023-08-15', 'Monthly'),
    (9, 3, 3, '2023-09-07', '2023-09-10', 'Daily'),
    (10, 10, 10, '2023-10-10', '2023-10-31', 'Monthly');

	INSERT INTO Payment (paymentID, leaseID, paymentDate, amount)
VALUES 
    (1, 1, '2023-01-03', 200.00),
    (2, 2, '2023-02-20', 1000.00),
    (3, 3, '2023-03-12', 75.00),
    (4, 4, '2023-04-25', 900.00),
    (5, 5, '2023-05-07', 60.00),
    (6, 6, '2023-06-18', 1200.00),
    (7, 7, '2023-07-03', 40.00),
    (8, 8, '2023-08-14', 1100.00),
    (9, 9, '2023-09-09', 80.00),
    (10, 10, '2023-10-25', 1500.00);


--1
	UPDATE Vehicle
SET dailyRate = 68.00
WHERE make = 'Mercedes';

select * from Vehicle;

--2
DELETE FROM Payment
WHERE leaseID IN (SELECT leaseID FROM Lease WHERE customerID = 3);

DELETE FROM Lease
WHERE customerID = 3;

DELETE FROM Customer
WHERE customerID = 3;

select * from Payment;


--3
EXEC sp_rename 'Payment.paymentDate', 'transactionDate', 'COLUMN';

select * from Payment;


--4
SELECT *
FROM Customer
WHERE email = 'sarah@example.com';


--5
DECLARE @customerID INT = 5;

SELECT DISTINCT C.customerID, C.firstName, C.lastName, C.email, C.phoneNumber
FROM Lease L
JOIN Customer C ON L.customerID = C.customerID
WHERE C.customerID=@customerID;



--6
DECLARE @phoneNumber NVARCHAR(20) = '555-456-7890';

SELECT P.paymentID, P.leaseID, P.transactionDate, P.amount
FROM Payment P
JOIN Lease L ON P.leaseID = L.leaseID
JOIN Customer C ON L.customerID = C.customerID
WHERE C.phoneNumber = @phoneNumber;

--7
SELECT AVG(dailyRate) AS averageDailyRate
FROM Vehicle
WHERE status = 'available';


--8
SELECT TOP 1 *
FROM Vehicle
ORDER BY dailyRate DESC;


--9
SELECT V.*
FROM Vehicle V
JOIN Lease L ON V.vehicleID = L.vehicleID
JOIN Customer C ON L.customerID = C.customerID
WHERE C.customerID = 4;



--10
SELECT TOP 1 *
FROM Lease
ORDER BY endDate DESC;

-11
SELECT *
FROM Payment
WHERE YEAR(transactionDate) = 2023;


--12
SELECT C.*
FROM Customer C
LEFT JOIN Lease L ON C.customerID = L.customerID
LEFT JOIN Payment P ON L.leaseID = P.leaseID
WHERE P.paymentID IS NULL;

--13
SELECT V.vehicleID, V.make, V.model, V.year, V.dailyRate, 
ISNULL(SUM(P.amount), 0) AS totalPayments
FROM Vehicle V
LEFT JOIN Lease L ON V.vehicleID = L.vehicleID
LEFT JOIN Payment P ON L.leaseID = P.leaseID
GROUP BY V.vehicleID, V.make, V.model, V.year, V.dailyRate
ORDER BY V.vehicleID;

--14
SELECT C.customerID, C.firstName, C.lastName, C.email, C.phoneNumber,
ISNULL(SUM(P.amount), 0) AS totalPayments
FROM Customer C
LEFT JOIN Lease L ON C.customerID = L.customerID
LEFT JOIN Payment P ON L.leaseID = P.leaseID
GROUP BY C.customerID, C.firstName, C.lastName, C.email, C.phoneNumber
ORDER BY C.customerID;

--15
SELECT L.leaseID, L.vehicleID, L.customerID, L.startDate, L.endDate, L.type AS leaseType,
V.make, V.model, V.year, V.dailyRate, V.status, V.passengerCapacity, V.engineCapacity
FROM Lease L
JOIN Vehicle V ON L.vehicleID = V.vehicleID
ORDER BY L.leaseID;


--16
DECLARE @currentDate DATE = '2023-05-06';

SELECT L.leaseID, L.vehicleID, V.make, V.model, V.year, V.dailyRate,
       L.customerID, C.firstName, C.lastName, C.email, C.phoneNumber,
       L.startDate, L.endDate, L.type AS leaseType
FROM Lease L
JOIN Vehicle V ON L.vehicleID = V.vehicleID
JOIN Customer C ON L.customerID = C.customerID
WHERE @currentDate BETWEEN L.startDate AND L.endDate
ORDER BY L.leaseID;


--17
Select top 1
	C.customerID,
	C.firstname,
	C.lastname,
	C.email,
	C.phoneNumber,
	SUM(p.amount) AS totalSpent
From Customer C
JOIN Lease L on C.customerID = L.customerID
JOIN Payment P on L.leaseID =  P.leaseID
GROUP BY C.customerID, C.firstName, C.lastName, C.email, C.phoneNumber
ORDER BY totalSpent DESC;


--18

SELECT
V.vehicleID,
V.make,
V.model,
V.year,
V.dailyRate,
V.status,
L.leaseID,
L.customerID,
L.startDate,
L.endDate,
L.type as leaseType
FROM Vehicle V
LEFT JOIN Lease L on V.vehicleID=L.vehicleID;


