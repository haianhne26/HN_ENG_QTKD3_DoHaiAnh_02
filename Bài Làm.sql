CREATE DATABASE flight_booking;			-- tạo bảng flight_booking
USE flight_booking;										-- thiếu USE thì khỏi chạy :)))

CREATE TABLE Passenger (					-- bảng Passenger để lấy thông tin nè
  passenger_id VARCHAR(10) NOT NULL PRIMARY KEY,
  passenger_full_name VARCHAR(150) NOT NULL,
  passenger_email VARCHAR(255) NOT NULL UNIQUE,
  passenger_phone VARCHAR(15) NOT NULL UNIQUE,
  passenger_bod DATE,
  passenger_gender ENUM('Nam', 'Nu', 'Khac') DEFAULT 'Nam',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Flight (						-- bảng thông tin bay các kiểu 
  flight_id VARCHAR(10) NOT NULL PRIMARY KEY,
  airline_name VARCHAR(100),
  departure_airport VARCHAR(100),
  arrival_airport VARCHAR(100),
  departure_time DATETIME,
  arrival_time DATETIME,
  ticket_price DECIMAL(10,2) CHECK (ticket_price >= 0)
);

CREATE TABLE Booking (							-- bảng booking chuyến bay cho khách hàng
  booking_id INT PRIMARY KEY AUTO_INCREMENT,
  passenger_id INT NOT NULL,
  flight_id INT NOT NULL,
  booking_status ENUM('Confirmed','Cancelled','Pending') DEFAULT 'Pending',
  ticket_quantity INT NOT NULL DEFAULT 1 CHECK (ticket_quantity >= 1),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY (passenger_id)
      REFERENCES Passenger(passenger_id)
      ON DELETE RESTRICT
      ON UPDATE CASCADE,

  FOREIGN KEY (flight_id)
      REFERENCES Flight(flight_id)
      ON DELETE RESTRICT
      ON UPDATE CASCADE
);

CREATE TABLE Payment (								-- bảng giá tiền này
  payment_id INT AUTO_INCREMENT PRIMARY KEY,
  booking_id INT NOT NULL,
  payment_method ENUM('Credit Card','Bank Transfer','Cash') NOT NULL,
  payment_amount DECIMAL(10,2) NOT NULL CHECK (payment_amount > 0),
  payment_date DATE,
  payment_status ENUM('Success','Failed','Pending') DEFAULT 'Pending',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY (booking_id)
      REFERENCES Booking(booking_id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);


INSERT INTO Passenger (passenger_id, passenger_full_name, passenger_email, passenger_phone, passenger_bod, passenger_gender)   -- giờ chèn bảng cho Passenger nè
VALUES
('P0001','Nguyen Anh Tuan','tuan.nguyen@example.com','0901234567','1995-05-15','Nam'),
('P0002','Tran Thi Mai','mai.tran@example.com','0912345678','1996-06-16','Nữ'),
('P0003','Le Minh Tuan','tuan.le@example.com','0923456789','1997-07-17','Nam'),
('P0004','Pham Hong Son','son.pham@example.com','0934567890','1998-08-18','Nam'),
('P0005','Nguyen Thi Lan','lan.nguyen@example.com','0945678901','1999-09-19','Nữ'),
('P0006','Vu Thi Bao','bao.vu@example.com','0956789012','2000-10-20','Nữ'),
('P0007','Doan Minh Hoang','hoang.doan@example.com','0967890123','2001-11-21','Nam'),
('P0008','Nguyen Thi Thanh','thanh.nguyen@example.com','0978901234','2002-12-22','Nữ'),
('P0009','Trinh Bao Vy','vy.trinh@example.com','0989012345','2003-01-23','Nữ'),
('P0010','Bui Hoang Nam','nam.bui@example.com','0990123456','2004-02-24','Nam');

INSERT INTO Flight (flight_id, airline_name, departure_airport, arrival_airport, departure_time, arrival_time, ticket_price)     -- dữ liệu flight nè
VALUES
('F001','VietJet Air','Tan Son Nhat','Nha Trang','2025-03-01 08:00:00','2025-03-01 10:00:00',150.50),
('F002','Vietnam Airlines','Noi Bai','Hanoi','2025-03-01 09:00:00','2025-03-01 11:30:00',200.00),
('F003','Bamboo Airways','Da Nang','Phu Quoc','2025-03-01 10:00:00','2025-03-01 12:00:00',120.80),
('F004','Vietravel Airlines','Can Tho','Ho Chi Minh','2025-03-01 11:00:00','2025-03-01 12:30:00',180.00);

INSERT INTO Booking (booking_id, passenger_id, flight_id, booking_date, booking_status, ticket_quantity)        -- dữ liệu booking cho khách nè
VALUES
(1,'P0001','F001','2025-02-20','Confirmed',1),
(2,'P0002','F002','2025-02-21','Cancelled',2),
(3,'P0003','F003','2025-02-22','Pending',1),
(4,'P0004','F004','2025-02-23','Confirmed',3),
(5,'P0005','F001','2025-02-24','Pending',1),
(6,'P0006','F002','2025-02-25','Confirmed',2),
(7,'P0007','F003','2025-02-26','Cancelled',1),
(8,'P0008','F004','2025-02-27','Pending',4),
(9,'P0009','F001','2025-02-28','Confirmed',1),
(10,'P0010','F002','2025-02-28','Pending',1),
(11,'P0001','F003','2025-03-01','Confirmed',3),
(12,'P0002','F004','2025-03-02','Cancelled',1),
(13,'P0003','F001','2025-03-03','Pending',2),
(14,'P0004','F002','2025-03-04','Confirmed',1),
(15,'P0005','F003','2025-03-05','Cancelled',2),
(16,'P0006','F004','2025-03-06','Pending',1),
(17,'P0007','F001','2025-03-07','Confirmed',3),
(18,'P0008','F002','2025-03-08','Cancelled',2),
(19,'P0009','F003','2025-03-09','Pending',1),
(20,'P0010','F004','2025-03-10','Confirmed',1);

INSERT INTO Payment (payment_id, booking_id, payment_method, payment_amount, payment_date, payment_status)			-- chèn bảng Payment vào cho còn có dữ liệu tiền
VALUES
(1,1,'Credit Card',150.50,'2025-02-20','Success'),
(2,2,'Bank Transfer',200.00,'2025-02-21','Failed'),
(3,3,'Cash',120.80,'2025-02-22','Pending'),
(4,4,'Credit Card',180.00,'2025-02-23','Success'),
(5,5,'Bank Transfer',150.50,'2025-02-24','Pending'),
(6,6,'Cash',200.00,'2025-02-25','Success'),
(7,7,'Credit Card',120.80,'2025-02-26','Failed'),
(8,8,'Bank Transfer',180.00,'2025-02-27','Pending'),
(9,9,'Cash',150.50,'2025-02-28','Success'),
(10,10,'Credit Card',200.00,'2025-03-01','Pending');

UPDATE Payment							-- update payment lớn hơn 0 thành đã thanh toán 
SET payment_status = 'Success'
WHERE payment_method = 'Credit Card'
  AND payment_amount > 0
  AND payment_date < CURRENT_DATE();

UPDATE Payment							-- Cập nhật trạng thái thanh toán thành "Pending" nếu phương thức thanh toán là "Bank Transfer" và số tiền thanh toán nhỏ hơn 100.
SET payment_status = 'Pending'
WHERE payment_method = 'Bank Transfer'
  AND payment_amount < 100
  AND payment_date < CURRENT_DATE();	-- giao dịch trước CURRENT_DATE

DELETE FROM Payment
WHERE payment_status = 'Pending'
  AND payment_method = 'Cash';
  
  

-- giờ đến phần 4 select các dữ liệu   
SELECT passenger_id, passenger_full_name, passenger_email, passenger_bod, passenger_gender
FROM Passenger
ORDER BY passenger_full_name ASC
LIMIT 5;

SELECT flight_id, airline_name, departure_airport, arrival_airport, ticket_price
FROM Flight
ORDER BY ticket_price DESC;

SELECT b.passenger_id, p.passenger_full_name, b.flight_id, b.booking_status
FROM Booking b
JOIN Passenger p ON b.passenger_id = p.passenger_id
WHERE b.booking_status = 'Cancelled';

SELECT booking_id, passenger_id, flight_id, ticket_quantity
FROM Booking
WHERE booking_status = 'Confirmed'
ORDER BY ticket_quantity DESC;

SELECT b.booking_id, p.passenger_full_name, b.flight_id, b.ticket_quantity
FROM Booking b
JOIN Passenger p ON b.passenger_id = p.passenger_id
WHERE b.ticket_quantity BETWEEN 2 AND 3
ORDER BY p.passenger_full_name ASC;

SELECT b.passenger_id, p.passenger_full_name, b.ticket_quantity
FROM Booking b
JOIN Passenger p ON b.passenger_id = p.passenger_id
JOIN Payment pay ON pay.booking_id = b.booking_id
WHERE b.ticket_quantity >= 2
  AND pay.payment_status = 'Pending';

SELECT DISTINCT p.passenger_id, p.passenger_full_name, pay.payment_amount
FROM Payment pay
JOIN Booking b ON pay.booking_id = b.booking_id
JOIN Passenger p ON b.passenger_id = p.passenger_id
WHERE pay.payment_status = 'Success';

SELECT b.passenger_id, p.passenger_full_name, b.ticket_quantity, b.booking_status
FROM Booking b
JOIN Passenger p ON b.passenger_id = p.passenger_id
WHERE b.ticket_quantity > 1
ORDER BY b.ticket_quantity DESC
LIMIT 5;

SELECT f.flight_id, f.airline_name, SUM(b.ticket_quantity) AS total_tickets_booked
FROM Flight f
JOIN Booking b ON f.flight_id = b.flight_id
GROUP BY f.flight_id, f.airline_name
ORDER BY total_tickets_booked DESC;

SELECT p.passenger_full_name, pay.payment_amount, pay.payment_status
FROM Passenger p
JOIN Booking b ON p.passenger_id = b.passenger_id
JOIN Payment pay ON pay.booking_id = b.booking_id
WHERE p.passenger_bod < '2000-01-01'
ORDER BY p.passenger_full_name ASC;

-- (p. b. f.) ở đây được sử dụng là bí danh