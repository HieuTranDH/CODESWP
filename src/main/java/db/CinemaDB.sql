-- Tạo cơ sở dữ liệu
CREATE DATABASE CinemaDB;	
GO

-- Sử dụng cơ sở dữ liệu vừa tạo
USE CinemaDB;
GO
-- Tạo bảng Cinema
CREATE TABLE Cinema (
    cinema_id INT IDENTITY(1,1) PRIMARY KEY, -- Khóa chính, tự tăng
    name NVARCHAR(255) NOT NULL,             -- Tên rạp chiếu
    address NVARCHAR(255) NOT NULL,          -- Địa chỉ rạp chiếu
    phone_number NVARCHAR(15),               -- Số điện thoại của rạp (có thể để trống)
    email NVARCHAR(100),                      -- Email của rạp (có thể để trống)
         status NVARCHAR(50) DEFAULT 'open' NOT NULL     --Trạng thái của rạp
);
GO

-- Tạo bảng ScreeningRoom
CREATE TABLE ScreeningRoom (
    room_id INT IDENTITY(1,1) PRIMARY KEY,   -- Khóa chính, tự tăng
    cinema_id INT,                           -- Khóa ngoại liên kết với Cinema
    room_name NVARCHAR(100) NOT NULL,        -- Tên của phòng chiếu
    seat_capacity INT NOT NULL,              -- Sức chứa của phòng chiếu (tổng số ghế)
    CONSTRAINT FK_ScreeningRoom_Cinema FOREIGN KEY (cinema_id) REFERENCES Cinema(cinema_id) -- Liên kết với bảng Cinema
);
GO

-- Tạo bảng Movie với cột status
CREATE TABLE Movie (
    movie_id INT IDENTITY(1,1) PRIMARY KEY,  -- Khóa chính, tự tăng
    title NVARCHAR(255) NOT NULL,            -- Tên phim
    duration INT NOT NULL,                   -- Thời lượng phim (phút)
    genre NVARCHAR(100),                     -- Thể loại phim (có thể để trống)
    release_date DATE,                       -- Ngày phát hành (có thể để trống)
    description NVARCHAR(MAX),               -- Mô tả phim (có thể để trống)
    status NVARCHAR(20) DEFAULT 'ComingSoon',    -- Trạng thái của phim (Active hoặc Inactive)
    poster NVARCHAR(255),                    -- Đường dẫn tới poster phim (có thể để trống)
    average_rating DECIMAL(3, 2) DEFAULT 0.00 -- Điểm đánh giá trung bình của phim
);
GO

-- Tạo bảng Showtime
CREATE TABLE Showtime (
    showtime_id INT IDENTITY(1,1) PRIMARY KEY, -- Khóa chính, tự tăng
    movie_id INT,                              -- Khóa ngoại liên kết với bảng Movie
    room_id INT,                               -- Khóa ngoại liên kết với bảng ScreeningRoom
    start_time DATETIME NOT NULL,              -- Thời gian bắt đầu của suất chiếu
    end_time DATETIME NOT NULL,                -- Thời gian kết thúc của suất chiếu
    CONSTRAINT FK_Showtime_Movie FOREIGN KEY (movie_id) REFERENCES Movie(movie_id), -- Liên kết với bảng Movie
    CONSTRAINT FK_Showtime_ScreeningRoom FOREIGN KEY (room_id) REFERENCES ScreeningRoom(room_id) -- Liên kết với bảng ScreeningRoom
);
GO
-- Tạo bảng Seat
CREATE TABLE Seat (
    seat_id INT IDENTITY(1,1) PRIMARY KEY,       -- Khóa chính, tự tăng
    room_id INT,                                 -- Khóa ngoại liên kết với bảng ScreeningRoom
    seat_number NVARCHAR(10) NOT NULL,           -- Số ghế trong phòng chiếu
    seat_type NVARCHAR(50) DEFAULT 'Standard',   -- Loại ghế (có thể là VIP, Standard)
    seat_price DECIMAL(10, 2) DEFAULT 0.00,      -- Giá của ghế (có thể thay đổi theo loại ghế)
    CONSTRAINT FK_Seat_ScreeningRoom FOREIGN KEY (room_id) REFERENCES ScreeningRoom(room_id), -- Liên kết với bảng ScreeningRoom
    UNIQUE (room_id, seat_number)                -- Đảm bảo mỗi ghế trong cùng một phòng chiếu là duy nhất
);
GO
-- Tạo bảng Customer
CREATE TABLE Customer (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,   -- Khóa chính, tự tăng
    name NVARCHAR(255) NOT NULL,                 -- Tên khách hàng
    email NVARCHAR(100) UNIQUE NOT NULL,         -- Email (phải là duy nhất)
    phone_number NVARCHAR(15),                   -- Số điện thoại
    password NVARCHAR(255) NOT NULL,             -- Mật khẩu (đã được mã hóa)
    loyalty_points INT DEFAULT 0,                -- Điểm tích lũy khách hàng
    registration_date DATETIME DEFAULT GETDATE(),-- Ngày đăng ký tài khoản
    avatar NVARCHAR(255),                        -- Đường dẫn đến ảnh đại diện (có thể để trống)
    birth_date DATE,                             -- Ngày sinh của khách hàng (có thể để trống)
    location NVARCHAR(255)                       -- Địa chỉ khách hàng (có thể để trống)
);
GO
-- Tạo bảng Promotion
CREATE TABLE Promotion (
    promotion_id INT IDENTITY(1,1) PRIMARY KEY,   -- Khóa chính, tự tăng
    promotion_code NVARCHAR(50) UNIQUE NOT NULL,  -- Mã khuyến mãi (phải là duy nhất)
    description NVARCHAR(255),                    -- Mô tả khuyến mãi (có thể để trống)
    discount_percentage DECIMAL(5, 2) NOT NULL,   -- Phần trăm giảm giá
    start_date DATETIME NOT NULL,                 -- Ngày bắt đầu khuyến mãi
    end_date DATETIME NOT NULL,                   -- Ngày kết thúc khuyến mãi
    min_ticket_quantity INT DEFAULT 2,            -- Số lượng vé tối thiểu áp dụng khuyến mãi
    max_ticket_quantity INT DEFAULT 3,            -- Số lượng vé tối đa áp dụng khuyến mãi
    max_discount_amount DECIMAL(10, 2),           -- Mức giảm giá tối đa
    status NVARCHAR(50) DEFAULT 'Active'          -- Trạng thái khuyến mãi
);
GO
-- Tạo bảng Combo

CREATE TABLE Combo (
    combo_id INT IDENTITY(1,1) PRIMARY KEY,  -- Khóa chính, tự tăng
    combo_name NVARCHAR(255) NOT NULL,       -- Tên combo
    combo_price DECIMAL(10, 2) NOT NULL,     -- Giá combo
    description NVARCHAR(255),                -- Mô tả combo (có thể để trống)
         status NVARCHAR(50) NOT NULL DEFAULT 'open'    -- Trạng thái combo
);
GO
-- Tạo bảng Ticket
CREATE TABLE Ticket (
    ticket_id INT IDENTITY(1,1) PRIMARY KEY,     -- Khóa chính, tự tăng
    showtime_id INT,                             -- Khóa ngoại liên kết với bảng Showtime
    price DECIMAL(10, 2) NOT NULL,               -- Giá vé
    customer_id INT,                             -- Khóa ngoại liên kết với bảng Customer
    purchase_date DATETIME NOT NULL,             -- Ngày mua vé
    promotion_id INT NULL,                       -- Khóa ngoại liên kết với bảng Promotion
    discount_amount DECIMAL(10, 2) DEFAULT 0,    -- Số tiền được giảm giá
    combo_id INT NULL,                           -- Khóa ngoại liên kết với bảng Combo
    status NVARCHAR(255) DEFAULT 'NotCheckin',   -- Trạng thái vé (NotCheckin, CheckedIn, Canceled)
    CONSTRAINT FK_Ticket_Showtime FOREIGN KEY (showtime_id) REFERENCES Showtime(showtime_id), -- Liên kết với bảng Showtime
    CONSTRAINT FK_Ticket_Customer FOREIGN KEY (customer_id) REFERENCES Customer(customer_id), -- Liên kết với bảng Customer
    CONSTRAINT FK_Ticket_Promotion FOREIGN KEY (promotion_id) REFERENCES Promotion(promotion_id), -- Liên kết với bảng Promotion
    CONSTRAINT FK_Ticket_Combo FOREIGN KEY (combo_id) REFERENCES Combo(combo_id) -- Liên kết với bảng Combo
);
GO
-- Bảng trung gian giữa Ticket và Seat
CREATE TABLE TicketSeat (
    ticket_seat_id INT IDENTITY(1,1) PRIMARY KEY, -- Khóa chính, tự tăng
    ticket_id INT,                                -- Khóa ngoại liên kết với bảng Ticket
    seat_id INT,                                  -- Khóa ngoại liên kết với bảng Seat
	showtime_id INT                      
    CONSTRAINT FK_TicketSeat_Ticket FOREIGN KEY (ticket_id) REFERENCES Ticket(ticket_id), -- Liên kết với bảng Ticket
    CONSTRAINT FK_TicketSeat_Seat FOREIGN KEY (seat_id) REFERENCES Seat(seat_id)          -- Liên kết với bảng Seat
);

GO
-- Tạo bảng Staff
CREATE TABLE Staff (
    staff_id INT IDENTITY(1,1) PRIMARY KEY,     -- Khóa chính, tự tăng
    cinema_id INT NULL,                         -- Khóa ngoại liên kết với bảng Cinema (nhân viên có thể không thuộc rạp cụ thể)
    name NVARCHAR(255) NOT NULL,                -- Tên nhân viên
    hire_date DATE DEFAULT GETDATE(),           -- Ngày thuê
    email NVARCHAR(100) UNIQUE NOT NULL,        -- Email nhân viên (phải là duy nhất)
    phone_number NVARCHAR(15),                  -- Số điện thoại của nhân viên
    password NVARCHAR(255) NOT NULL,            -- Mật khẩu nhân viên (đã mã hóa)
    role NVARCHAR(100) NOT NULL,                -- Vai trò của nhân viên (ví dụ: Quản lý, Nhân viên bán vé)
    CONSTRAINT FK_Staff_Cinema FOREIGN KEY (cinema_id) REFERENCES Cinema(cinema_id) -- Liên kết với bảng Cinema
);
GO
-- Tạo bảng MovieRating
CREATE TABLE MovieRating (
    rating_id INT IDENTITY(1,1) PRIMARY KEY,   -- Khóa chính, tự tăng
    movie_id INT,                              -- Khóa ngoại liên kết với bảng Movie
    customer_id INT,                           -- Khóa ngoại liên kết với bảng Customer
    rating DECIMAL(2, 1) NOT NULL,             -- Điểm đánh giá của khách hàng (từ 1.0 đến 5.0)
    comment NVARCHAR(MAX),                     -- Nhận xét của khách hàng
    rating_date DATETIME DEFAULT GETDATE(),    -- Ngày đánh giá
    CONSTRAINT FK_MovieRating_Movie FOREIGN KEY (movie_id) REFERENCES Movie(movie_id), -- Liên kết với bảng Movie
    CONSTRAINT FK_MovieRating_Customer FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) -- Liên kết với bảng Customer
);

-- Dữ liệu mẫu cho bảng Cinema
INSERT INTO Cinema (name, address, phone_number, email)
VALUES 
(N'CGV Vincom Hà Nội', N'191 Bà Triệu, Hai Bà Trưng, Hà Nội', N'024-12345678', N'contact-hanoi@cgv.vn'),
(N'Lotte Cinema Đống Đa', N'229 Tây Sơn, Đống Đa, Hà Nội', N'024-87654321', N'lotte-dongda@lotte.vn'),
(N'BHD Star Vincom Thảo Điền', N'Vincom Mega Mall Thảo Điền, Q2, TP. Hồ Chí Minh', N'028-56781234', N'bhdt@bhdstar.vn');

-- Dữ liệu mẫu cho bảng ScreeningRoom
INSERT INTO ScreeningRoom (cinema_id, room_name, seat_capacity)
VALUES 
(1, N'Phòng 1', 100),
(1, N'Phòng 2', 80),
(2, N'Phòng 3', 150),
(3, N'Phòng 4', 120);

-- Dữ liệu mẫu cho bảng Movie
INSERT INTO Movie (title, duration, genre, release_date, description, status, poster, average_rating)
VALUES 
(N'Em và Trịnh', 120, N'Tình cảm', '2023-05-15', N'Bộ phim tái hiện cuộc đời và tình yêu của cố nhạc sĩ Trịnh Công Sơn.', N'Active', N'https://th.bing.com/th/id/R.1f45255f37abf681ae3217c1d8993b29?rik=DiC%2fjF3Y08l1tA&riu=http%3a%2f%2fwww.impawards.com%2fintl%2fvietnam%2f2022%2fposters%2fem_va_trinh_ver15_xxlg.jpg&ehk=0e1aiqi4YoOYqnBmQIbR%2fevksjgF17g1qxKEMGM%2bvY8%3d&risl=&pid=ImgRaw&r=0', 4.5),
(N'Mắt Biếc', 115, N'Tình cảm', '2022-12-20', N'Chuyển thể từ tác phẩm nổi tiếng của Nguyễn Nhật Ánh, kể về câu chuyện tình yêu của Ngạn và Hà Lan.', N'Active', N'https://th.bing.com/th/id/OIP.ztUBfLTulP5xYRA29qiaNgHaKk?rs=1&pid=ImgDetMain', 4.7),
(N'Hai Phượng', 90, N'Hành động', '2021-02-05', N'Hai Phượng là một bộ phim hành động kể về cuộc chiến của một người mẹ để cứu con gái.', N'Active', N'https://th.bing.com/th/id/OIP.1oyU6ZxRacchi12SUERSoAHaK-?w=580&h=860&rs=1&pid=ImgDetMain', 4.8);

-- Dữ liệu mẫu cho bảng Showtime
INSERT INTO Showtime (movie_id, room_id, start_time, end_time)
VALUES 
(1, 1, '2024-10-05 18:30:00', '2024-10-05 20:30:00'),
(2, 1, '2024-10-04 19:00:00', '2024-10-04 21:00:00'),
(1, 1, '2024-10-06 18:30:00', '2024-10-06 20:30:00'),
(2, 1, '2024-10-02 19:00:00', '2024-10-02 21:00:00'),
(1, 1, '2024-10-08 18:30:00', '2024-10-08 20:30:00'),
(2, 1, '2024-10-04 19:00:00', '2024-10-04 21:00:00'),
(1, 1, '2024-10-03 18:30:00', '2024-10-03 20:30:00'),
(2, 1, '2024-10-05 19:00:00', '2024-10-05 21:00:00'),
(3, 2, '2024-10-04 20:00:00', '2024-10-04 21:30:00');

-- Dữ liệu mẫu cho bảng Seat
-- Dữ liệu mẫu cho bảng Seat cho phòng chiếu 1 với các ghế từ A đến I
INSERT INTO Seat (room_id, seat_number, seat_type, seat_price) VALUES
(1, N'A1', 'Standard', 100000),
(1, N'A2', 'Standard', 100000),
(1, N'A3', 'Standard', 100000),
(1, N'A4', 'Standard', 100000),
(1, N'B1', 'Standard', 100000),
(1, N'B2', 'Standard', 100000),
(1, N'B3', 'Standard', 100000),
(1, N'B4', 'Standard', 100000),
(1, N'C1', 'Standard', 100000),
(1, N'C2', 'Standard', 100000),
(1, N'C3', 'Standard', 100000),
(1, N'C4', 'Standard', 100000),
(1, N'D1', 'Standard', 100000),
(1, N'D2', 'Standard', 100000),
(1, N'D3', 'Standard', 100000),
(1, N'D4', 'Standard', 100000),
(1, N'E1', 'VIP', 120000),
(1, N'E2', 'VIP', 120000),
(1, N'F1', 'VIP', 120000),
(1, N'F2', 'VIP', 120000),
(1, N'G1', 'VIP', 120000),
(1, N'G2', 'VIP', 120000),
(1, N'H1', 'Couple', 150000),
(1, N'I1', 'Couple', 150000);
-- Dữ liệu mẫu cho bảng Seat cho phòng chiếu 2 với các ghế từ A đến I
INSERT INTO Seat (room_id, seat_number, seat_type, seat_price) VALUES
(2, N'A1', 'Standard', 100000),
(2, N'A2', 'Standard', 100000),
(2, N'A3', 'Standard', 100000),
(2, N'A4', 'Standard', 100000),
(2, N'B1', 'Standard', 100000),
(2, N'B2', 'Standard', 100000),
(2, N'B3', 'Standard', 100000),
(2, N'B4', 'Standard', 100000),
(2, N'C1', 'Standard', 100000),
(2, N'C2', 'Standard', 100000),
(2, N'C3', 'Standard', 100000),
(2, N'C4', 'Standard', 100000),
(2, N'D1', 'Standard', 100000),
(2, N'D2', 'Standard', 100000),
(2, N'D3', 'Standard', 100000),
(2, N'D4', 'Standard', 100000),
(2, N'E1', 'VIP', 120000),
(2, N'E2', 'VIP', 120000),
(2, N'F1', 'VIP', 120000),
(2, N'F2', 'VIP', 120000),
(2, N'G1', 'VIP', 120000),
(2, N'G2', 'VIP', 120000),
(2, N'H1', 'Couple', 150000),
(2, N'I1', 'Couple', 150000);
-- Dữ liệu mẫu cho bảng Seat cho phòng chiếu 3 với các ghế từ A đến I
INSERT INTO Seat (room_id, seat_number, seat_type, seat_price) VALUES
(3, N'A1', 'Standard', 100000),
(3, N'A2', 'Standard', 100000),
(3, N'A3', 'Standard', 100000),
(3, N'A4', 'Standard', 100000),
(3, N'B1', 'Standard', 100000),
(3, N'B2', 'Standard', 100000),
(3, N'B3', 'Standard', 100000),
(3, N'B4', 'Standard', 100000),
(3, N'C1', 'Standard', 100000),
(3, N'C2', 'Standard', 100000),
(3, N'C3', 'Standard', 100000),
(3, N'C4', 'Standard', 100000),
(3, N'D1', 'Standard', 100000),
(3, N'D2', 'Standard', 100000),
(3, N'D3', 'Standard', 100000),
(3, N'D4', 'Standard', 100000),
(3, N'E1', 'VIP', 120000),
(3, N'E2', 'VIP', 120000),
(3, N'F1', 'VIP', 120000),
(3, N'F2', 'VIP', 120000),
(3, N'G1', 'VIP', 120000),
(3, N'G2', 'VIP', 120000),
(3, N'H1', 'Couple', 150000),
(3, N'I1', 'Couple', 150000);
-- Dữ liệu mẫu cho bảng Customer
INSERT INTO Customer (name, email, phone_number, password, loyalty_points, registration_date, avatar, birth_date, location)
VALUES 
(N'Nguyễn Văn A', N'testa@gmail.com', N'0909123456', N'123', 100, '2024-01-15',NULL, '1995-03-21', N'Hà Nội'),
(N'Trần Thị B', N'testb@gmail.com', N'0909234567', N'123', 50, '2024-02-10', NULL, '1990-11-05', N'TP. Hồ Chí Minh');

-- Dữ liệu mẫu cho bảng Promotion
INSERT INTO Promotion (promotion_code, description, discount_percentage, start_date, end_date, min_ticket_quantity, max_ticket_quantity, max_discount_amount, status)
VALUES 
(N'PROMO20', N'Giảm giá 20% cho khách hàng mua từ 2 vé', 20.00, '2024-10-01', '2024-10-31', 2, 5, 50000, N'Active'),
(N'PROMO50', N'Giảm 50% cho vé thứ 2', 50.00, '2024-09-01', '2024-09-30', 2, 3, 80000, N'Inactive');

-- Dữ liệu mẫu cho bảng Combo
INSERT INTO Combo (combo_name, combo_price, description)
VALUES 
(N'Combo 1', 50000, N'1 bắp rang, 1 nước ngọt'),
(N'Combo 2', 70000, N'1 bắp rang, 2 nước ngọt'),
(N'Combo 3', 90000, N'2 bắp rang, 2 nước ngọt');
-- Dữ liệu mẫu cho bảng Staff
INSERT INTO Staff (cinema_id, name, hire_date, email, phone_number, password, role)
VALUES 
(1, N'Lê Văn C', '2023-01-01', N'admin@gmail.com', N'0988123456', N'123', N'Admin'),
(2, N'Phạm Thị D', '2023-02-15', N'staff@gmail.com', N'0988765432', N'123', N'Staff');
-- Dữ liệu mẫu cho bảng MovieRating
INSERT INTO MovieRating (movie_id, customer_id, rating, comment, rating_date)
VALUES 
(1, 1, 4.5, N'Phim rất cảm động và ý nghĩa.', '2024-09-25'),
(2, 2, 4.7, N'Cảnh quay đẹp, nội dung hay.', '2024-09-26'),
(3, 1, 4.8, N'Hành động kịch tính, diễn viên xuất sắc.', '2024-09-27');
