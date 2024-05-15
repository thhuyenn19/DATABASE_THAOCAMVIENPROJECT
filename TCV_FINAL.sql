CREATE database THAOCAMVIEN

--Tạo bảng Partner
CREATE TABLE Partner(
    PartnerID CHAR(4) PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL,
    Phone VARCHAR(12) NOT NULL,
    Email NVARCHAR(30) NOT NULL,
    Street NVARCHAR(50) NOT NULL,
    District NVARCHAR(20) NOT NULL,
    City NVARCHAR(20) NOT NULL,
    PartnerType NVARCHAR(10) NOT NULL);

--Tạo bảng Supplier
CREATE TABLE Supplier(
    PartnerID CHAR(4) PRIMARY KEY,
    MainProductLine NVARCHAR(50) NOT NULL,
    FOREIGN KEY (PartnerID) REFERENCES Partner(PartnerID));

--Tạo bảng Business
CREATE TABLE Business(
    PartnerID CHAR(4) PRIMARY KEY,
    BusinessField NVARCHAR(50) NOT NULL,
    Area NVARCHAR(10),
    FOREIGN KEY (PartnerID) REFERENCES Partner(PartnerID));

--Tạo bảng Food
CREATE TABLE Food(
	FoodID CHAR(4) PRIMARY KEY,
	Name NVARCHAR(50) NOT NULL,
	PartnerID CHAR(4) REFERENCES Supplier(PartnerID));


--Tạo bảng Customer Online
CREATE TABLE CustomerOnline(
	CustomerID CHAR(4) PRIMARY KEY,
	Name NVARCHAR(40) NOT NULL, 
	Phone VARCHAR(12) NOT NULL, 
	Street NVARCHAR(50) NOT NULL, 
	District NVARCHAR(20) NOT NULL, 
	City NVARCHAR(20) NOT NULL);

--Tạo bảng Employee
CREATE TABLE Employee(
	EmployeeID CHAR(7) PRIMARY KEY, 
	LastName NVARCHAR(40) NOT NULL, 
	FirstName NVARCHAR(10) NOT NULL,
	DateOfBirth DATE NOT NULL, 
	Sex NCHAR(3) NOT NULL,
	HireDate DATE NOT NULL, 
	Phone VARCHAR(12) NOT NULL, 
	Email NVARCHAR(30) NOT NULL,
	Street NVARCHAR(50) NOT NULL,
	District NVARCHAR(20) NOT NULL, 
	City NVARCHAR(20) NOT NULL, 
	Department NVARCHAR(25) NOT NULL,
	Salary MONEY NOT NULL,
	ManagerID CHAR(7),
	CONSTRAINT FK_ManagerID FOREIGN KEY (ManagerID) REFERENCES Employee(EmployeeID))

--Tạo bảng Receipt
CREATE TABLE Receipt(
    ReceiptID CHAR(4) PRIMARY KEY,
    OrderDate DATETIME NOT NULL,
    Price MONEY NOT NULL,
    EmployeeID CHAR(7) NOT NULL,
    PartnerID CHAR(4),
    CustomerID CHAR(4),
    FOREIGN KEY (PartnerID) REFERENCES Business(PartnerID));

ALTER TABLE Receipt
ADD CONSTRAINT FK_Receipt_Employee
FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
CONSTRAINT FK_Receipt_Customer
FOREIGN KEY (CustomerID) REFERENCES CustomerOnline(CustomerID);

--Tạo bảng Order Invoice
CREATE TABLE OrderInvoice(
	InvoiceID CHAR(5) PRIMARY KEY,
	OrderDate DATETIME NOT NULL,
	Price MONEY NOT NULL,
	PartnerID CHAR(4) FOREIGN KEY 
	REFERENCES Supplier(PartnerID),
	EmployeeID CHAR(7) NOT NULL,
	FOREIGN KEY (EmployeeID) 
	REFERENCES Employee(EmployeeID));

-- Tạo bảng Ticket
CREATE TABLE Ticket(
	TicketID CHAR(4) PRIMARY KEY,
	Type NVARCHAR(15) NOT NULL,
	Price MONEY NOT NULL,
	Description NVARCHAR(50) NOT NULL)

--Tạo bảng Plant
CREATE TABLE Plant(
	PlantID CHAR(5) PRIMARY KEY, 
	Name NVARCHAR (25) NOT NULL, 
	Type NVARCHAR(15) NOT NULL, 
	Area NVARCHAR(10) NOT NULL, 
	GreenHouse TINYINT, 
	Origin NVARCHAR(15) NOT NULL, 
	Description NVARCHAR(200) NOT NULL)

--Tạo bảng Services
CREATE TABLE Services(
	ServiceID CHAR(5) PRIMARY KEY,  
	Name NVARCHAR (30) NOT NULL, 
	Type NVARCHAR(5) NOT NULL, 
	Area NVARCHAR(10) NOT NULL, 
	Price MONEY NOT NULL)

--Tạo bảng Activity Entertainment
CREATE TABLE Activity_Entertainment(
	ActivityID CHAR(5) PRIMARY KEY, 
	Name NVARCHAR (15) NOT NULL, 
	Area NVARCHAR(10) NOT NULL)

--Tạo bảng Species
CREATE TABLE Species(
	SpeciesID CHAR(5) PRIMARY KEY, 
	Name NVARCHAR(50) NOT NULL, 
	Quantity INT NOT NULL, 
	FoodID CHAR(4) NOT NULL)

ALTER TABLE Species 
ADD CONSTRAINT FK_Species_Food FOREIGN KEY (FoodID) REFERENCES Food(FoodID)

-- Tạo bảng Animal
CREATE TABLE Animal (
	AnimalID CHAR(5) PRIMARY KEY, 
	Name NVARCHAR(15),
	DateOfBirth DATE, 
	DayIn DATE NOT NULL,
	Cage TINYINT, 
	Origin NVARCHAR(10) NOT NULL, 
	Area NVARCHAR(10) NOT NULL,
	SpeciesID CHAR(5) NOT NULL, 
	ActivityID CHAR(5),
	Description NVARCHAR(500) NOT NULL,
	FOREIGN KEY (SpeciesID) REFERENCES Species(SpeciesID), 
	FOREIGN KEY (ActivityID) REFERENCES Activity_Entertainment(ActivityID))

--Tạo bảng Medical Record
CREATE TABLE Medical_Record (
	AnimalID CHAR(5), 
	MedicalRecordID CHAR(4),
	VaccineStatus NVARCHAR(10) NOT NULL,
	PRIMARY KEY (AnimalID, MedicalRecordID),
	FOREIGN KEY (AnimalID) 
	REFERENCES Animal (AnimalID))


--Tạo bảng History_Detail
CREATE TABLE History_Detail (
	HistoryID CHAR(4) PRIMARY KEY,
    Date DATETIME NOT NULL,
    Status NVARCHAR(20) NOT NULL,
    Description NVARCHAR(200) NOT NULL);

--Tạo bảng Medical record history
CREATE TABLE Medical_Record_History(
	AnimalID CHAR(5) NOT NULL,
    MedicalRecordID CHAR(4) NOT NULL,
	HistoryID CHAR(4) NOT NULL,
	MedicalRecordUnit NVARCHAR(40),
	PRIMARY KEY (AnimalID,MedicalRecordID,HistoryID),
	FOREIGN KEY (AnimalID, MedicalRecordID) REFERENCES Medical_Record (AnimalID, MedicalRecordID), 
	FOREIGN KEY (HistoryID) REFERENCES History_Detail (HistoryID))


--Tạo bảng Sale Service
CREATE TABLE SaleService ( SaleServiceID CHAR(5) PRIMARY KEY, EmployeeID CHAR(7) NOT NULL,
ServiceID CHAR(5),TicketID CHAR(4), Date DATE NOT NULL, Quantity INT NOT NULL,
CONSTRAINT FK_SS_EmployeeID FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
CONSTRAINT FK_SS_ServiceID FOREIGN KEY (ServiceID) REFERENCES Services(ServiceID),
CONSTRAINT FK_SS_TicketID FOREIGN KEY (TicketID) REFERENCES Ticket(TicketID));

--Tạo bảng Management
CREATE TABLE Management(ManagementID CHAR(7) PRIMARY KEY,EmployeeID CHAR(7) NOT NULL, WorkShift NVARCHAR(30) NOT NULL,
SpeciesID CHAR(5), ActivityID CHAR(5), ServiceID CHAR(5), PlantID CHAR(5),
CONSTRAINT FK_EmployeeID FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
CONSTRAINT FK_ActivityID FOREIGN KEY (ActivityID) REFERENCES Activity_Entertainment(ActivityID),
CONSTRAINT FK_ServiceID FOREIGN KEY (ServiceID) REFERENCES Services(ServiceID),
CONSTRAINT FK_PlantID FOREIGN KEY (PlantID) REFERENCES Plant(PlantID),
CONSTRAINT FK_SpeciesID FOREIGN KEY (SpeciesID) REFERENCES Species(SpeciesID))


--Tạo bảng Feeding Management
CREATE TABLE FeedingManagement(
    FManagementID CHAR(5) PRIMARY KEY,
    EmployeeID CHAR(7) NOT NULL,
	FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    SpeciesID CHAR(5) NOT NULL,
	FOREIGN KEY (SpeciesID) REFERENCES Species(SpeciesID),
	WorkShift NVARCHAR(50) NOT NULL,
    FeedingTime NVARCHAR(50) NOT NULL);


--Thêm dữ liệu vào bảng Partner
INSERT INTO Partner(PartnerID, Name, Phone, Email, Street, District, City, PartnerType) 
VALUES 
		('P001', N'Nông trại Bình Minh', '02873099799', 'nongtraibinhminh@gmail.com.vn', N'Huỳnh Văn Cọ', N'Củ Chi', N'Hồ Chí Minh', 'Supplier'),
		('P002', N'Nông trại Ánh Mai', '0933619087', 'anhmai@gmail.com.vn', N'Lê Văn Khương', N'Quận 12', N'Hồ Chí Minh', 'Supplier'),
		('P003', N'Công ty Cổ phần chăn nuôi Lan Phúc', '02864987328', 'lanphuc@gmail.com.vn', N'Trường Sa', N'Quận 3', N'Hồ Chí Minh', 'Supplier'),
		('P004', N'Công ty TNHH Thủy Sản Tân Thuận', '02838732295', 'tanthuan@gmail.com.vn', N'Huỳnh Tấn Phát', N'Nhà Bè', N'Hồ Chí Minh', 'Supplier'),
		('P005', N'Nông trại chăn nuôi Hòa An', '09876543210', 'hoaan@gmail.com.vn', N'Nguyễn Kiệm', N'Phú Nhuận', N'Hồ Chí Minh', 'Supplier'),
		('P006', N'Công ty CP Dược phẩm Imexpharm', '08432915670', 'duocphamimexpharm@gmail.com.vn', N'Nguyễn Chí Thanh', N'Quận 10', N'Hồ Chí Minh', 'Supplier'),
		('P007', N'Công ty Cổ phần Thực Phẩm Chức Năng DAVINCI', '07654321098', 'davinci@gmail.com.vn', N'Ung Văn Khiêm', N'Bình Thạnh', N'Hồ Chí Minh', 'Supplier'),
		('P008', N'Công ty TNHH Phân Phối Dụng cụ vệ sinh Cao Lam', '05623489701', 'dcvscaolam@gmail.com.vn', N'Trần Quốc Toản', N'Quận 3', N'Hồ Chí Minh', 'Supplier'),
		('P009', N'Công ty Cổ phần Sài Gòn Hoa Vương', '03987654123', 'hoavuong.sg@gmail.com.vn', N'Vạn Kiếp', N'Bình Thạnh', N'Hồ Chí Minh', 'Supplier'),
		('P010', N'Công ty TNHH MTV Phát Đạt', '02546879301', 'phatdat@gmail.com.vn', N'Phan Văn Trị', N'Gò Vấp', N'Hồ Chí Minh', 'Supplier'),
		('P011', N'Công ty TNHH Phân Phối Thiết bị Y tế Hoàng Minh', '02838479806', 'hoangminhcompany@gmail.com.vn', N'Nguyễn Thị Huỳnh', N'Phú Nhuận', N'Hồ Chí Minh', 'Supplier'),
		('P012', N'Công ty TNHH Phân Phối Thiết bị Văn phòng Thư Quán', '03124567890', 'tbvpthuquan@gmail.com.vn', N'Hoài Thanh', N'Quận 8', N'Hồ Chí Minh', 'Supplier'),
		('P013', N'Công ty Phân bón Miền Nam', '07293845160', 'phanbon.miennam@gmail.com.vn', N'Lã Xuân Oai', N'Quận 9', N'Hồ Chí Minh', 'Supplier'),
		('P014', N'Công ty Cổ phần Bảo vệ thực vật Sài Gòn', '02838733003', 'info@spchcmc.vn', N'Nguyễn Văn Quỳ', N'Quận 7', N'Hồ Chí Minh', 'Supplier'),
		('P015', N'Công Ty May Đồng Phục Hải Anh', '0921889889', 'kinhdoanh@dpha.vn', N'Cách mạng tháng Tám', N'Tân Bình', N'Hồ Chí Minh', 'Supplier'),
		('P016', N'Công ty Cổ phần dịch vụ Quản lý bãi xe SMP Group', '0764987654', 'smpgroup@gmail.com.vn', N'Tam Phú', N'Thủ Đức', N'Hồ Chí Minh', 'Business'),
		('P017', N'Nhà hàng Gió Xuân', '0962218547', 'gioxuan@gmail.com.vn', N'Lê Văn Sỹ', N'Phú Nhuận', N'Hồ Chí Minh', 'Business'),
		('P018', N'Hệ thống cửa hàng lưu niệm Hoa Hồng', '0337443666', 'hoahong@gmail.com.vn', N'Nguyễn Văn Cừ', N'Quận 1', N'Hồ Chí Minh', 'Business'),
		('P019', N'Công ty tổ chức sự kiện Vietsky', '0932 687 477', 'sukienvietsky@gmail.com', N'Đường Số 2', N'Thủ Đức', N'Hồ Chí Minh', 'Business'),
		('P020', N'Cắm trại KAMP', '0961 558 799', 'Kamp.vn@gmail.com', N'Bùi Đình Túy', N'Bình Thạnh', N'Hồ Chí Minh', 'Business');

--Thêm dữ liệu vào bảng Supplier
INSERT INTO Supplier(PartnerID, MainProductLine) 
VALUES 
		('P001', N'Rau củ quả'),
		('P002', N'Cỏ'),
		('P003', N'Thịt'),
		('P004', N'Cá'),
		('P005', N'Trứng'),
		('P006', N'Thuốc'),
		('P007', N'Thực phẩm chức năng'),
		('P008', N'Dụng cụ vệ sinh'),
		('P009', N'Dụng cụ làm vườn'),
		('P010', N'Dụng cụ nhà bếp'),
		('P011', N'Thiết bị y tế'),
		('P012', N'Thiết bị văn phòng'),
		('P013', N'Phân bón'),
		('P014', N'Thuốc trừ sâu'),
		('P015', N'Đồng phục nhân viên');

--Thêm dữ liệu vào bảng Business
INSERT INTO Business(PartnerID, BusinessField, Area)
VALUES 
		('P016', N'Dịch vụ giữ xe', N'Khu vực 24'),
		('P017', N'Nhà hàng', N'Khu vực 25'),
		('P018', N'Quầy hàng lưu niệm', N'Khu vực 26'),
		('P019', N'Tổ chức lễ hội', N'Khu vực 27'),
		('P020', N'Dịch vụ cắm trại', N'Khu vực 28');

--Thêm dữ liệu vào bảng Food
INSERT INTO Food(FoodID, Name, PartnerID) 
VALUES 
		('F001', N'Rau củ quả', 'P001'),
		('F002', N'Cỏ, thân cây, thảo mộc', 'P002'),
		('F003', N'Thịt trâu', 'P003'),
		('F004', N'Cá, tôm, mực', 'P004'),
		('F005', N'Trứng', 'P005'),
		('F006', N'Thịt, gạo, ngũ cốc', 'P001'),
		('F007', N'Rau, trái cây', 'P001'),
		('F008', N'Khoai, ngô, lạc', 'P001'),
		('F009', N'Đầu cổ gia cầm, thịt', 'P003'),
		('F010', N'Cỏ, nhành cây, lá cây, trái cây', 'P002'),
		('F011', N'Hạt, ngũ cốc', 'P001'),
		('F012', N'Thịt, cá', 'P003'),
		('F013', N'Hạt, quả, côn trùng, sâu bọ', 'P001'),
		('F014', N'Cá, lưỡng cư, sâu bọ', 'P004'),
		('F015', N'Hải sản, lưỡng cư', 'P004');

--Thêm dữ liệu vào bảng Customer Online
INSERT INTO CustomerOnline (CustomerID, Name, Phone, Street, District, City)
VALUES
		('C001', N'Trần Gia Huy', '0942728159', N'Võ Văn Tần', N'Quận 5', N'Hồ Chí Minh'),
		('C002', N'Vũ Anh Tuấn', '0866466258', N'Tôn Đản', N'Quận 4' , N'Hồ Chí Minh'),
		('C003', N'Trần Phương Dung', '0375001528', N'Nguyễn Thị Minh Khai', N'Quận 1', N'Hồ Chí Minh'),
        ('C004', N'Vũ Thị Hồng', '0363751272', N'Nguyễn Tri Phương', N'Quận 10', N'Hồ Chí Minh'), 
		('C005', N'Tô Như Ngọc', '0913854054', N'Nguyễn Trãi', N'Quận 5', N'Hồ Chí Minh'), 
		('C006', N'Ngô Nguyễn Quỳnh Trâm', '0962764117', N'Sư Vạn Hạnh', N'Quận 10', N'Hồ Chí Minh'), 
		('C007', N'Hồ Nguyễn Anh Thy', '0919180880', N'Bạch Đằng',N'Bình Thạnh', N'Hồ Chí Minh'), 
		('C008', N'Nguyễn Ngọc Thiên Thanh', '0944483283', N'Lê Đại Hành', N'Quận 11', N'Hồ Chí Minh'), 
		('C009', N'Phạm Thụy Phương', '0869764150', N'Trần Hưng Đạo',N'Quận 5', N'Hồ Chí Minh'), 
		('C010', N'Đinh Thị Như', '0366370098', N'Kinh Dương Vương', N'Bình Tân', N'Hồ Chí Minh'), 
		('C011', N'Đặng Thị Kiều', '0707317912',	N'Nơ Trang Long', N'Bình Thạnh', N'Hồ Chí Minh'), 
		('C012', N'Nguyễn Quế Lâm', '0828813683', N'Lê Văn Việt',	N'Quận 9', N'Hồ Chí Minh'), 
		('C013', N'Ngô Thị Thanh', '0761363567', N'Nguyễn Đình Chiểu', N'Quận 3', N'Hồ Chí Minh'), 
		('C014', N'Đào Gia Bảo', '0968381464', N'Lê Đức Thọ', N'Gò Vấp', N'Hồ Chí Minh'), 
		('C015', N'Tô Nguyễn Tường Minh', '0945803313', N'Phạm Văn Chí', N'Quận 6', N'Hồ Chí Minh'), 
		('C016', N'Đặng Hồng Ngọc', '0388084912', N'Hưng Phú', N'Quận 8', N'Hồ Chí Minh'), 
		('C017', N'Nguyễn Thị Kim', '0817948093', N'Âu Cơ', N'Tân Phú', N'Hồ Chí Minh'),
		('C018', N'Nguyễn Phạm Bảo Minh', '0888772905', N'Trường Chinh', N'Tân Bình', N'Hồ Chí Minh'),
		('C019', N'Nguyễn Sỹ Anh', '0903191262', N'Nguyễn Văn Tạo', N'Nhà Bè', N'Hồ Chí Minh'),
		('C020', N'Trần Thị Cẩm', '0944772586', N'Huỳnh Văn Bánh', N'Phú Nhuận', N'Hồ Chí Minh');

--Thêm dữ liệu vào bảng Employee
INSERT INTO Employee (EmployeeID, LastName, FirstName, DateOfBirth, Sex, HireDate, Phone, Email, Street, District, City, Department, Salary, ManagerID)
VALUES
('TCV0001', N'Ngô Văn', N'Thái', '1989-11-12', 'Nam', '2013-05-20', '0956789012', 'ngovanthai@gmail.com', N'Nguyễn Tri Phương', N'Quận 10', N'Hồ Chí Minh', N'Kỹ thuật', 8500000, 'TCV0002'),
('TCV0002', N'Phạm Ngô Khôi', N'Vĩ', '1980-03-18', 'Nam', '2014-07-12', '0967890123', 'phamngokhoivi@gmail.com', N'Nguyễn Trãi', N'Quận 5', N'Hồ Chí Minh', N'Kỹ thuật', 8000000, NULL),
('TCV0003', N'Lê Thùy', N'Lâm', '1986-04-28', N'Nữ', '2015-07-20', '0987654321', 'lethuylam@gmail.com', N'Nguyễn Tri Phương', N'Quận 7', N'Hồ Chí Minh', N'Xí nghiệp kinh doanh', 4700000, 'TCV0008'),
('TCV0004', N'Hoàng Văn', N'Toàn', '1983-12-05', 'Nam', '2016-02-25', '0709876543', 'hoangvantoan@gmail.com', N'Bạch Đằng', N'Bình Thạnh', N'Hồ Chí Minh', N'Xí nghiệp kinh doanh', 7000000, 'TCV0007'),
('TCV0005', N'Nguyễn Thiện', N'Mỹ', '1987-12-20', N'Nữ', '2016-08-27', '0823456789', 'nguyenthienmy@gmail.com', N'Lê Đại Hành', N'Quận 11', N'Hồ Chí Minh', N'Xí nghiệp kinh doanh', 7250000, 'TCV0008'),
('TCV0006', N'Trần Thị Ngọc', N'Hòa', '1988-07-25', N'Nữ', '2017-09-10', '0892345678', 'tranthingochoa@gmail.com', N'Trần Hưng Đạo', N'Quận 5', N'Hồ Chí Minh', N'Xí nghiệp kinh doanh', 6000000, 'TCV0008'),
('TCV0007', N'Lê Văn', N'Chí', '1998-02-28', 'Nam', '2017-11-05', '0976543210', 'levanchi01@gmail.com', N'Võ Văn Tần', N'Quận 5', N'Hồ Chí Minh', N'Xí nghiệp kinh doanh', 9000000, NULL),
('TCV0008', N'Trần Thị Linh', N'Hà', '1995-10-21', N'Nữ', '2018-03-10', '0912345678', 'tranthilinhh23@gmail.com', N'Tôn Đản', N'Quận 4', N'Hồ Chí Minh', N'Xí nghiệp kinh doanh', 10000000, NULL),
('TCV0009', N'Hà Thị Lan', N'Anh', '1990-03-15', N'Nữ', '2018-05-20', '0881234567', 'hathilanh@gmail.com', N'Nguyễn Thị Minh Khai', N'Quận 1', N'Hồ Chí Minh', N'Xí nghiệp động vật', 4500000, 'TCV0014'),
('TCV0010', N'Phạm Nguyễn Kim', N'Oanh', '1989-10-08', N'Nữ', '2018-11-30', '0834567890', 'phamnguyenkimoanh@gmail.com', N'Lê Hồng Phong', N'Vũng Tàu', N'Bà Rịa Vũng Tàu', N'Xí nghiệp động vật', 5200000, 'TCV0014'),
('TCV0011', N'Trần Đỗ Nhật', N'Huy', '1996-12-20', 'Nam', '2019-08-27', '0743210987', 'trandonhathuy@gmail.com', N'Lê Lợi', N'Ninh Kiều', N'Cần Thơ', N'Xí nghiệp bảo vệ', 7000000, 'TCV0021'),
('TCV0012', N'Mai Thị', N'Liên', '1992-09-30', N'Nữ', '2019-09-03', '0710987654', 'maithilien@gmail.com', N'Hà Tôn Quyền', N'Quận 11', N'Hồ Chí Minh', N'Xí nghiệp động vật', 7000000, 'TCV0014'),
('TCV0013', N'Thái Hồng', N'Xuyên', '1991-09-05', 'Nữ', '2019-10-12', '0865432109', 'thaihongxuyen@gmail.com', N'Lý Thường Kiệt', N'Quận 10', N'Hồ Chí Minh', N'Xí nghiệp động vật', 6000000, 'TCV0014'),
('TCV0014', N'Đặng Thị', N'Hòa', '1997-06-25', N'Nữ', '2019-12-30', '0923456789', 'dangthihoa@gmail.com', N'Cách Mạng Tháng Tám', N'Quận 10', N'Hồ Chí Minh', N'Xí nghiệp động vật', 7500000, 'TCV0014'),
('TCV0015', N'Đinh Tấn', N'Lực', '1992-11-10', 'Nam', '2020-03-18', '0876543210', 'dinhtanluc@gmail.com', N'Đường Cộng Hòa', N'Tân Bình', N'Hồ Chí Minh', N'Xí nghiệp thực vật', 5500000, 'TCV0019'),
('TCV0016', N'Phạm Thị Duyên', N'Hải', '2001-07-10', N'Nữ', '2020-06-15', '0801234567', 'phamthiduyenhai@gmail.com', N'Phan Xích Long', N'Phú Nhuận', N'Hồ Chí Minh', N'Xí nghiệp kinh doanh', 8000000, NULL),
('TCV0017', N'Nguyễn Văn', N'Tú', '2000-05-15', 'Nam', '2020-08-20', '0901234567', 'nguyenvantu@gmail.com', N'Xô Viết Nghệ Tĩnh', N'Bình Thạnh', N'Hồ Chí Minh', N'Kế hoạch đầu tư', 5000000, 'TCV0007'),
('TCV0018', N'Vũ Bảo', N'Châu', '1997-09-05', N'Nữ', '2020-10-12', '0732109876', 'vubaochau7@gmail.com', N'Lê Việt Thắng', N'Mỹ Tho', N'Tiền Giang', N'Xí nghiệp kinh doanh', 5000000, NULL),
('TCV0019', N'Ninh Đứ', N'Anh', '1993-05-02', 'Nam', '2021-02-14', '0812345678', 'ninhducanh@gmail.com', N'Xuân Thủy', N'Quận 2', N'Hồ Chí Minh', N'Xí nghiệp thực vật', 7000000, NULL),
('TCV0020', N'Lý Thị Kim', N'Loan', '1993-04-08', N'Nữ', '2021-04-18', '0998765432', 'lythikimloan@gmail.com', N'Cao Thắng', N'Quận 3', N'Hồ Chí Minh', N'Xí nghiệp thực vật', 5500000, 'TCV0019'),
('TCV0021', N'Trần Bảo', N'Luân', '1998-03-15', 'Nam', '2021-05-20', '0934567890', 'tranbaoluan@gmail.com', N'Đường Nguyễn Văn Rốp', N'Trảng Bàng', N'Tây Ninh', N'Xí nghiệp bảo vệ', 7350000, NULL),
('TCV0022', N'Bùi Huệ', N'Chi', '1994-08-12', N'Nữ', '2021-06-30', '0856789012', 'buihuechi@gmail.com', N'Phan Chu Trinh', N'Vũng Tàu', N'Bà Rịa Vũng Tàu', N'Xí nghiệp kinh doanh', 4900000, 'TCV0008'),
('TCV0023', N'Phạm Trần Lam', N'Giang', '1995-02-17', N'Nữ', '2022-01-05', '0845678901', 'phamtranlamgiang@gmail.com', N'Trần Hưng Đạo', N'Biên Hòa', N'Đồng Nai', N'Xí nghiệp xây dựng', 6100000, NULL),
('TCV0024', N'Trần Như Nhật', N'Lệ', '1999-07-25', N'Nữ', '2022-09-10', '0945678901', 'trannhunhatle@gmail.com', N'Ngô Gia Tự', N'Thủ Dầu Một', N'Bình Dương', N'Xí nghiệp kinh doanh', 3900000, 'TCV0018'),
('TCV0025', N'Nguyễn Hoàng', N'Phi', '2000-11-10', 'Nam', '2023-03-18', '0721098765', 'nguyenhoangphi21@gmail.com', N'Nguyễn Văn Tạo', N'Tân An', N'Long An', N'Xí nghiệp kinh doanh', 4500000, 'TCV0018');

--Thêm dữ liệu vào bảng Order Invoice
INSERT 
INTO OrderInvoice(InvoiceID, OrderDate, Price, PartnerID, EmployeeID)
	VALUES
		('OI001', '2024-04-07 09:15:00', '11,200,000', 'P001','TCV0018'),
		('OI002', '2024-03-25 14:45:00', '2,160,000', 'P002','TCV0024'),
		('OI003', '2024-02-03 08:00:00','9,260,000','P003','TCV0025'),
		('OI004', '2024-01-15 10:30:00','1,140,000','P004',	'TCV0018'),
		('OI005', '2024-03-25 09:00:00','3,500,000',	'P005',	'TCV0024'),
		('OI006', '2024-02-07 09:45:00','4,180,000','P006',	'TCV0025'),
		('OI007', '2024-04-01 08:30:00','2,240,000','P007',	'TCV0018'),
		('OI008','2024-04-27 08:00:00',	'21,000,000','P008','TCV0024'),
		('OI009','2024-03-18 07:45:00',	'4,000,000','P009',	'TCV0025'),
		('OI010','2024-01-19 13:30:00',	'7,180,000','P010',	'TCV0018'),
		('OI011','2024-02-15 13:00:00',	'6,000,000','P011',	'TCV0024'),
		('OI012','2024-04-29 13:30:00',	'1,400,000', 'P012','TCV0025'),
		('OI013','2024-03-02 09:15:00',	'8,120,000','P013',	'TCV0018'),
		('OI014','2024-04-13 10:00:00',	'6,000,000','P014',	'TCV0024'),
		('OI015','2024-01-14 08:30:00',	'3,860,000','P015',	'TCV0025'),
		('OI016','2024-04-30 08:45:00',	'2,300,000','P012',	'TCV0018'),
		('OI017','2024-01-20 08:40:00',	'2,920,000','P005',	'TCV0024'),
		('OI018','2024-03-22 09:15:00',	'10,320,000','P007','TCV0025'),
		('OI019','2024-01-11 08:45:00',	'1,000,000','P015',	'TCV0018'),
		('OI020','2024-03-20 08:40:00',	'5,860,000','P008','TCV0024');

--Thêm dữ liệu vào bảng Plant
INSERT INTO Plant(PlantID, Name, Type, Area, GreenHouse, Origin, Description)
VALUES 
		('P0001', N'Trầm Hương', N'Bảo tồn', N'Khu vực 1', null, N'Châu Á', N'Thân cây to, lá dài, gỗ màu vàng nhạt, có thớ đen. Vỏ màu nâu xám, nứt dọc, dễ bóc. Cành có lông, có màu nâu sẫm. Chồi ngọn có lông màu vàng nhạt. Tán lá thưa.'),
		('P0002', N'Trầm Hương', N'Bảo tồn', N'Khu vực 1', null, N'Châu Á', N'Thân cây to, lá dài, gỗ màu vàng nhạt, có thớ đen. Vỏ màu nâu xám, nứt dọc, dễ bóc. Cành có lông, có màu nâu sẫm. Chồi ngọn có lông màu vàng nhạt. Tán lá thưa.'),
		('P0003', N'Mặc Nưa', N'Bảo tồn', N'Khu vực 1', null, N'Châu Á', N'Mặc nưa là loại cây đặc trưng của vùng nhiệt đới, phân bố tại Việt Nam, Myanmar, Thái Lan, Lào và Campuchia. Gỗ mặc nưa màu đen bóng đẹp, càng dùng lâu càng lên nước, thuộc dạng quý hiếm.'),
		('P0004', N'Lát Hoa', N'Bảo tồn', N'Khu vực 1', null, N'Châu Á', N'Lát hoa phân bổ tự nhiên ở rừng hỗn giao lá rộng thường xanh hoặc rụng lá, cũng thường mọc rải rác ở các thảm thực vật thưa thớt.'),
		('P0005', N'Gõ Mật', N'Bảo tồn', N'Khu vực 1', null, N'Châu Á', N'Đây là loài cây ưa sáng, dễ tính, sinh trưởng được cả ở những nơi đất nghèo dinh dưỡng. Ngoài Việt Nam, gõ mật còn phân bố ở Thái Lan, Lào, Campuchia và Malaysia.'),
		('P0006', N'Gõ Mật', N'Bảo tồn', N'Khu vực 1', null, N'Châu Á', N'Đây là loài cây ưa sáng, dễ tính, sinh trưởng được cả ở những nơi đất nghèo dinh dưỡng. Ngoài Việt Nam, gõ mật còn phân bố ở Thái Lan, Lào, Campuchia và Malaysia.'),
		('P0007', N'Gõ Mật', N'Bảo tồn', N'Khu vực 1', null, N'Châu Á', N'Đây là loài cây ưa sáng, dễ tính, sinh trưởng được cả ở những nơi đất nghèo dinh dưỡng. Ngoài Việt Nam, gõ mật còn phân bố ở Thái Lan, Lào, Campuchia và Malaysia.'),
		('P0008', N'Gõ Đỏ', N'Bảo tồn', N'Khu vực 1', null, N'Châu Á', N'Cây gõ đỏ phân bố trong rừng thường xanh hoặc rừng nửa rụng lá, mọc trên đất bằng hoặc sườn thoát nước. Đây là loài cây đặc hữu của khu vực Đông Dương.'),
		('P0009', N'Gõ Đỏ', N'Bảo tồn', N'Khu vực 1', null, N'Châu Á', N'Cây gõ đỏ phân bố trong rừng thường xanh hoặc rừng nửa rụng lá, mọc trên đất bằng hoặc sườn thoát nước. Đây là loài cây đặc hữu của khu vực Đông Dương.'),
		('P0010', N'Bách Xanh', N'Bảo tồn', N'Khu vực 1', null, N'Châu Á', N'Bách Xanh phân bố ở Việt Nam và một số nước châu Á khác như Trung Quốc,.. Loại cây này mọc trong rừng mưa nhiệt đới ở núi thấp hoặc núi có độ cao trung bình.'),
		('P0011', N'Lan Phi Điệp', N'Bảo tồn', N'Khu vực 2', 0001, N'Châu Á', N'Lan phi điệp tím còn có tên gọi khác như: Giã hạc, giả hạc,... Có tên khoa học là Dendrobium Anosmum. Đây là một loài lan thuộc dòng dõi lan phi điệp, thuộc dòng lan Hoàng Thảo.'),
		('P0012', N'Lan Ngọc Điểm', N'Bảo tồn', N'Khu vực 2', 0001, N'Châu Á', N'Hoa lan ngọc điểm, có tên khoa học là Phalaenopsis, thuộc họ Orchidaceae, là một trong những loại hoa lan phổ biến và được yêu thích. Nó có nguồn gốc từ châu Á.'),
		('P0013', N'Lan Ngọc Điểm', N'Bảo tồn', N'Khu vực 2', 0001, N'Châu Á', N'Hoa lan ngọc điểm, có tên khoa học là Phalaenopsis, thuộc họ Orchidaceae, là một trong những loại hoa lan phổ biến và được yêu thích. Nó có nguồn gốc từ châu Á.'),
		('P0014', N'Lan Ngọc Điểm', N'Bảo tồn', N'Khu vực 2', 0001, N'Châu Á', N'Hoa lan ngọc điểm, có tên khoa học là Phalaenopsis, thuộc họ Orchidaceae, là một trong những loại hoa lan phổ biến và được yêu thích. Nó có nguồn gốc từ châu Á.'),
		('P0015', N'Muồng Hoa Đào', N'Làm đẹp', N'Khu vực 6', null, N'Châu Á', N'Muồng hoa đào thuộc phân họ Vang thuộc họ Đậu (Fabaceae). Loài này có nguồn gốc từ rừng tự nhiên khu vực Đông Nam Á.'),
		('P0016', N'Tường Vi', N'Làm đẹp', N'Khu vực 9', null, N'Châu Á', N'Tường vi được trồng dọc lối đi có nắng gần vườn hoa và một thảm lớn tại khu sân chơi nước thiếu nhi, được trồng sau hơn một năm loài này bắt đầu cho hoa.'),
		('P0017', N'Hướng Dương', N'Làm đẹp', N'Khu vực 12', null, N'Châu Mỹ', N'Cây hướng dương có nguồn gốc từ Bắc Mỹ. Đây là loài cây thảo sống khoảng một năm, thân to thẳng có lông cứng, thường có đốm. Lá to, thường mọc so le, có cuống dài, phiến lá hình trứng đầu nhọn.'),
		('P0018', N'Hoa Ngọc Hân', N'Làm đẹp', N'Khu vực 10', null, N'Châu Mỹ', N'Cây hoa ngọc hân thuộc loại cây thân thảo, hoa chùm trên đỉnh có nhiều màu sắc, tươi lâu nên rất được ưa chuộng dùng để làm cây trang trí nội thất, cây trồng viền – trồng nền.'),
		('P0019', N'Cây Ngọc Ngân', N'Kinh doanh', N'Khu vực 3', 0002, N'Châu Mỹ', N'Cây Ngọc Ngân có tên khoa học Dieffenbachia picta hay còn có tên gọi khác là cây Valentine. Cây Ngọc Ngân có lá khá nổi bật, vì tính tương phản giữa màu xanh thẫm của lá.'),
		('P0020', N'Cây Ngọc Ngân', N'Kinh doanh', N'Khu vực 3', 0002, N'Châu Mỹ', N'Cây Ngọc Ngân có tên khoa học Dieffenbachia picta hay còn có tên gọi khác là cây Valentine. Cây Ngọc Ngân có lá khá nổi bật, vì tính tương phản giữa màu xanh thẫm của lá.'),
		('P0021', N'Mai Địa Thảo', N'Kinh doanh', N'Khu vực 3', 0002, N'Châu Phi', N'Mai địa thảo (danh pháp hai phần: Impatiens walleriana) là một loài thực vật có hoa trong họ Bóng nước (Balsaminaceae). Là loài cây thân thảo mềm, thân cây có màu đỏ hồng, màu sắc hoa đỏ tươi đẹp.'),
		('P0022', N'Mai Địa Thảo', N'Kinh doanh', N'Khu vực 3', 0002, N'Châu Phi', N'Mai địa thảo (danh pháp hai phần: Impatiens walleriana) là một loài thực vật có hoa trong họ Bóng nước (Balsaminaceae). Là loài cây thân thảo mềm, thân cây có màu đỏ hồng, màu sắc hoa đỏ tươi đẹp.'),
		('P0023', N'Huyết Dụ Thái', N'Kinh doanh', N'Khu vực 3', 0002, N'Châu Á', N'Cây huyết dụ được trồng làm cây cảnh trang trí tại khuôn viên, công viên, trường học hay trong phòng khách, phòng làm việc. Lá cây huyết dụ có tác dụng bổ máu, cầm máu giảm phong thấp,...');


--Thêm dữ liệu vào bảng Services
INSERT INTO Services(ServiceID, Name, Type, Area, Price)
VALUES 
		('SR001',N'Phi tiêu','Game',N'Khu vực 21',15000),
		('SR002',N'Thú nhún','Game',N'Khu vực 21',10000),
		('SR003',N'Massage cá','Game',N'Khu vực 21',20000),
		('SR004',N'Câu cá','Game',N'Khu vực 21',20000),
		('SR005',N'Đu quay đám mây','Game',N'Khu vực 21',20000),
		('SR006',N'Trò chơi cát','Game',N'Khu vực 21',20000),
		('SR007',N'Nhà banh','Game',N'Khu vực 21',20000),
		('SR008',N'Máy bay thủy lực','Game',N'Khu vực 21',20000),
		('SR009',N'Mâm xoay không gian','Game',N'Khu vực 21',20000),
		('SR010',N'Thuyền nhún','Game',N'Khu vực 21',20000),
		('SR011',N'Xe lửa nữ hoàng','Game',N'Khu vực 21',20000),
		('SR012',N'Thảm bay','Game',N'Khu vực 22',40000),
		('SR013',N'Xxe điện sàn','Game',N'Khu vực 22',40000),
		('SR014',N'Thám hiểm vũ trụ','Game',N'Khu vực 22',40000),
		('SR015',N'Đu quay lồng','Game',N'Khu vực 22',40000),
		('SR016',N'Tàu lượn siêu tốc','Game',N'Khu vực 22',40000),
		('SR017',N'Music Express','Game',N'Khu vực 22',40000),
		('SR018',N'Aladin','Game',N'Khu vực 23',30000),
		('SR019',N'Cano đụng','Game',N'Khu vực 23',30000),
		('SR020',N'Ô tô bay','Game',N'Khu vực 23',30000),
		('SR021',N'Nhà banh liên hoàn','Game',N'Khu vực 23',30000)


--Thêm dữ liệu vào bảng Activity Entertainment
INSERT INTO Activity_Entertainment(ActivityID, Name, Area)
VALUES
		('AC001',N'Xiếc thú',N'Khu vực 4'),
		('AC002',N'Cho thú ăn',N'Khu vực 6'),
		('AC003',N'Cho thú ăn',N'Khu vực 7'),
		('AC004',N'Cho thú ăn',N'Khu vực 8'),
		('AC005',N'Cho thú ăn',N'Khu vực 9'),
		('AC006',N'Cho thú ăn',N'Khu vực 13'),
		('AC007',N'Âm nhạc',N'Khu vực 5');

--Thêm dữ liệu vào bảng Species
INSERT INTO Species(SpeciesID, Name, Quantity, FoodID)
VALUES 
		('SP001',N'Voi',6,'F007'),
		('SP002',N'Sư tử',5,'F003'),
		('SP003',N'Sói',4,'F006'),
		('SP004',N'Tê giác',10,'F010'),
		('SP005',N'Hà mã',8,'F007'),
		('SP006',N'Hổ',8,'F009'),
		('SP007',N'Báo',9,'F009'),
		('SP008',N'Hươu cao cổ',12,'F001'),
		('SP009',N'Ngựa vằn',20,'F002'),
		('SP010',N'Linh dương',22,'F010'),
		('SP011',N'Vẹt',19,'F011'),
		('SP012',N'Cá sấu',15,'F012'),
		('SP013',N'Rái cá',7,'F004'),
		('SP014',N'Sóc',30,'F013'),
		('SP015',N'Cò quắm',37,'F014'),
		('SP016',N'Gấu chó',7,'F002'),
		('SP017',N'Cầy mực',13,'F015')

--Thêm dữ liệu vào bảng Ticket
INSERT INTO Ticket(TicketID, Type, Price, Description)
VALUES
('LTIC', N'Vé người lớn', 60000, N'Vé dành cho người với chiều cao trên 1m3.'),
('NTIC', N'Vé trẻ em', 40000, N'Vé dành cho người với chiều cao dưới 1m3.');


--Thêm dữ liệu vào bảng Sale Service
INSERT INTO SaleService (SaleServiceID, EmployeeID, ServiceID, TicketID, Date, Quantity)
VALUES
('SL001', 'TCV0024', NULL, 'LTIC', '2024-01-01', 20),
('SL002', 'TCV0024', NULL, 'LTIC', '2024-01-02', 15),
('SL003', 'TCV0024', NULL, 'NTIC', '2024-01-01', 22),
('SL004', 'TCV0024', NULL, 'NTIC', '2024-01-02', 17),
('SL005', 'TCV0025', NULL, 'LTIC', '2024-01-03', 24),
('SL006', 'TCV0025', NULL, 'LTIC', '2024-01-04', 12),
('SL007', 'TCV0025', NULL, 'NTIC', '2024-01-03', 34),
('SL008', 'TCV0025', NULL, 'NTIC', '2024-01-04', 28),
('SL009', 'TCV0003', 'SR001', NULL, '2024-01-01', 11),
('SL010', 'TCV0003', 'SR002', NULL, '2024-01-01', 10),
('SL011', 'TCV0005', 'SR003', NULL, '2024-01-01', 23),
('SL012', 'TCV0005', 'SR004', NULL, '2024-01-01', 9),
('SL013', 'TCV0003', 'SR012', NULL, '2024-01-02', 7),
('SL014', 'TCV0003', 'SR013', NULL, '2024-01-02', 12),
('SL015', 'TCV0005', 'SR014', NULL, '2024-01-02', 19),
('SL016', 'TCV0005', 'SR015', NULL, '2024-01-02', 3),
('SL017', 'TCV0006', 'SR018', NULL, '2024-01-03', 16),
('SL018', 'TCV0006', 'SR019', NULL, '2024-01-03', 18),
('SL019', 'TCV0006', 'SR020', NULL, '2024-01-03', 10),
('SL020', 'TCV0006', 'SR021', NULL, '2024-01-03', 15)


--Thêm dữ liệu bảng Animal
INSERT INTO Animal (AnimalID, Name,DateOfBirth,DayIn, Cage, Origin, Description, Area, SpeciesID,ActivityID)
VALUES
('AN001',NULL, '1992-03-12', '1995-05-15', NULL, N'Châu Á', N'Voi là loài động vật có vú lớn nhất còn sinh sống trên mặt đất ngày nay. Voi có thể sống được tới 80 năm. Voi châu Á đặc biệt sống theo bầy đàn, thường gồm 6-7 voi cái. Khoảng hai phần ba ngày, voi dành để ăn cỏ, vỏ cây, rễ, lá và các cành nhỏ.', N'Khu vực 6', 'SP001', 'AC002'),
('AN002', NULL,'2006-05-24', '2010-05-15', '001', N'Châu Phi', N'Sư tử sống từ 10–14 năm trong tự nhiên nhưng trong môi trường nuôi nhốt, chúng có thể sống hơn 20 năm. Trong tự nhiên, sư tử đực hiếm khi sống hơn 10 năm, do hậu quả của việc đánh nhau liên tục với các sư tử đối thủ. Sư tử có tập tính xã hội khác biệt so với các loài họ Mèo còn lại.', N'Khu vực 18', 'SP002', NULL),
('AN003', NULL,NULL, '2014-09-29', '002', N'Châu Mỹ', N'Chó sói xám có chung tổ tiên với chó nhà. Sói xám săn mồi theo bầy đàn nên hiệu quả săn mồi của chúng rất cao. Sói xám rất dai sức, có thể săn bám mồi liên tục trong thời gian dài và chạy nhanh tới 65 km/h. Loài sói này thường cất tiếng hú để giao tiếp với đồng loại, tiếng hú của chúng to và kéo dài.', N'Khu vực 18', 'SP003', NULL),
('AN004', NULL,'2015-05-30', '2015-05-30', '001', N'Châu Phi', N'Sư tử sống từ 10–14 năm trong tự nhiên nhưng trong môi trường nuôi nhốt, chúng có thể sống hơn 20 năm. Trong tự nhiên, sư tử đực hiếm khi sống hơn 10 năm, do hậu quả của việc đánh nhau liên tục với các sư tử đối thủ. Sư tử có tập tính xã hội khác biệt so với các loài họ Mèo còn lại.',N'Khu vực 18', 'SP002', NULL),
('AN005', NULL,'2018-04-23', '2019-01-01', NULL, N'Châu Phi', N'Tê giác trắng hay tê giác môi vuông là một trong năm loài tê giác và là một trong số rất ít loài động vật ăn cỏ lớn còn tồn tại. Chúng có nguồn gốc ở Đông Bắc và miền nam châu Phi. Tê giác có xu hướng sống thành bầy đàn từ 1 đến 7 con, trên mõm của chúng có hai sừng với cấu tạo từ các sợi keratin (không phải xương như ở gạc hươu, nai).',N'Khu vực 19', 'SP004', NULL),
('AN006', NULL,'2019-09-17', '2019-10-03', NULL, N'Châu Phi', N'Hà mã là loài sống nửa dưới nước nửa trên cạn, cư trú ở các con sông, hồ và các đầm lầy rừng ngập mặn Tây Phi. Hà mã sống theo đàn, con đực đầu đàn sẽ chiếm lĩnh một đoạn sông và đứng đầu đàn gồm 5 đến 30 con cái và con non. Vào ban ngày, chúng duy trì sự mát mẻ bằng cách dầm mình trong nước hay bùn và sự sinh sản cũng diễn ra trong nước.',N'Khu vực 20', 'SP005', NULL),
('AN007', N'Bình','2019-09-03', '2020-01-13', '004', N'Châu Á', N'Hổ Đông Dương có cân nặng trung bình từ 180 – 249kg, chiều dài trung bình từ mũi đến đuôi khoảng 2,7m. Môi trường sinh sống tự nhiên của Hổ Đông Dương là rừng lá rộng ẩm nhiệt đới và cận nhiệt đới. Quần thể loài này đã giảm hơn 70% trong một thập kỷ qua.',N'Khu vực 18', 'SP006', NULL),
('AN008', NULL,'2020-03-20', '2020-03-22', '007', N'Châu Á', N'Báo lửa, hay beo vàng châu Á, còn được gọi là beo vàng Temminck. Đây là loài động vật ăn thịt thuộc họ Mèo có kích thước trung bình (dài 90 cm, cộng với đuôi dài 50 cm), cân nặng 12 đến 16kg. Trong điều kiện nuôi nhốt, báo lửa có thể sống đến 20 năm.',N'Khu vực 16', 'SP007', NULL),
('AN009', N'Thảo Em',NULL, '2021-03-29', NULL, N'Châu Phi', N'Hươu cao cổ là động vật có vú thuộc bộ Guốc chẵn, là động vật cao nhất trên cạn và động vật nhai lại lớn nhất. Hươu cao cổ thường sống ở savan, đồng cỏ và rừng thưa. Nguồn thức ăn chính của chúng là lá cây keo – loại lá cây mà hầu hết các động vật ăn cỏ khác không thể với tới. Hươu cao cổ thường uống một lượng lớn nước trong một lần và có thể giữ nước lâu trong cơ thể.',N'Khu vực 7', 'SP008', 'AC003'),
('AN010', NULL,'2021-07-12', '2021-04-12', NULL, N'Châu Á', N'Voi là loài động vật có vú lớn nhất còn sinh sống trên mặt đất ngày nay. Voi có thể sống được tới 80 năm. Voi châu Á đặc biệt sống theo bầy đàn, thường gồm 6-7 voi cái. Khoảng hai phần ba ngày, voi dành để ăn cỏ, vỏ cây, rễ, lá và các cành nhỏ.',N'Khu vực 6', 'SP001', 'AC002'),
('AN011',N'Bún cá', '2020-04-24', '2021-10-05', '011', N'Châu Phi', N'Ngựa vằn là một số loài họ Ngựa châu Phi được nhận dạng bởi các sọc đen và trắng đặc trưng trên người chúng. Sọc của chúng có những biểu tượng khác nhau, mang tính độc nhất cho mỗi cá thể.[2] Loài động vật này thường sống theo bầy đàn. Những vằn sọc độc nhất của ngựa vằn khiến chúng trở thành một trong những loài động vật quen thuộc nhất đối với con người.',N'Khu vực 8', 'SP009','AC004'),
('AN012', NULL,'2021-09-24', '2021-10-05', '011', N'Châu Phi',N'Ngựa vằn là một số loài họ Ngựa châu Phi được nhận dạng bởi các sọc đen và trắng đặc trưng trên người chúng. Sọc của chúng có những biểu tượng khác nhau, mang tính độc nhất cho mỗi cá thể.[2] Loài động vật này thường sống theo bầy đàn. Những vằn sọc độc nhất của ngựa vằn khiến chúng trở thành một trong những loài động vật quen thuộc nhất đối với con người.',N'Khu vực 8', 'SP009', 'AC004'),
('AN013', NULL,'2021-03-29', '2022-01-04', '009', N'Châu Mỹ', N'Vẹt Nam Mỹ (Scarlet Macaw) có kích thước phụ thuộc vào loài và là dòng chim có kích thước trung bình. Có những loài có thể nặng từ 2 – 4kg, có loài khi trưởng thành chỉ nặng 1,2 – 1,7kg. Chiều dài cơ thể dao động từ 8,6 – 100cm. Chiếc mỏ rất to chính là điểm nổi bật nhất trên khuôn mặt của chúng. Chiếc mỏ của chúng vô cùng chắc khỏe và được cấu tạo bởi lớp sừng cứng.',N'Khu vực 9', 'SP011', 'AC005'),
('AN014', NULL,'2022-04-10', '2022-01-04', '010', N'Châu Úc', N'Giống vẹt Eclectus có kích thước khá lớn, chúng có thể đạt kích thước từ 35 tới 42cm và nặng trung bình từ 450 đến 500g. Về màu sắc, giống vẹt Eclectus có sự khác biệt rõ rệt giữa con đực và con cái. Con vẹt Eclectus đực sẽ có màu xanh, đôi khi có những con có màu ngọc lục bảo với điểm nhấn là xanh và đỏ dọc theo đường cánh.',N'Khu vực 9', 'SP011', 'AC005'),
('AN015', NULL,'2022-01-02', '2022-05-02', '008', N'Châu Á', N'Loài rái cá nhỏ thân mập . Thân màu xám nâu , cổ và bụng trắng mờ . Vuốt ngón chân rất ngắn , không nhô ra khỏi đầu ngón chân . Màng bơi thoái hóa nhờ vậy các ngón chân chuyển động tự do',N'Khu vực 10', 'SP013', NULL),
('AN016', NULL,'2021-04-02', '2022-12-02', '012', N'Châu Mỹ', N'Cá sấu là các loài bò sát lớn ưa thích môi trường nước, chúng sống trên một diện tích rộng của khu vực nhiệt đới của châu Phi, châu Á, Bắc Mỹ, Nam Mỹ và châu Đại Dương. Cá sấu có xu hướng sinh sống ở những vùng sông và hồ có nước chảy chậm, thức ăn của chúng khá đa dạng, chủ yếu là động vật có vú sống hay đã chết cũng như cá',N'Khu vực 13', 'SP012', 'AC006'),
('AN017',NULL, '2020-10-02', '2022-12-02', '012', N'Châu Mỹ', N'Cá sấu là các loài bò sát lớn ưa thích môi trường nước, chúng sống trên một diện tích rộng của khu vực nhiệt đới của châu Phi, châu Á, Bắc Mỹ, Nam Mỹ và châu Đại Dương. Cá sấu có xu hướng sinh sống ở những vùng sông và hồ có nước chảy chậm, thức ăn của chúng khá đa dạng, chủ yếu là động vật có vú sống hay đã chết cũng như cá',N'Khu vực 13', 'SP012', 'AC006'),
('AN018',NULL, NULL, '2022-12-02', '012', N'Châu Mỹ', N'Cá sấu là các loài bò sát lớn ưa thích môi trường nước, chúng sống trên một diện tích rộng của khu vực nhiệt đới của châu Phi, châu Á, Bắc Mỹ, Nam Mỹ và châu Đại Dương. Cá sấu có xu hướng sinh sống ở những vùng sông và hồ có nước chảy chậm, thức ăn của chúng khá đa dạng, chủ yếu là động vật có vú sống hay đã chết cũng như cá',N'Khu vực 13', 'SP012', 'AC006'),
('AN019', NULL,'2022-03-25', '2023-03-28', NULL, N'Châu Phi', N'Linh dương đầu bò là động vật ăn cỏ, kiếm ăn chủ yếu tại đồng cỏ ngắn. Linh dương đầu bò chủ yếu hoạt động vào buổi sáng và chiều tối. Thời gian nóng nhất trong ngày được chúng dành để nghỉ ngơi trong bóng cây hoặc bụi cỏ dày. Đây cũng là thời điểm linh dương đầu bò ưa thích nhổ nước và cỏ cạn cung cấp cho chúng nước uống cũng như thức ăn.',N'Khu vực 11', 'SP010', NULL),
('AN020',NULL, '2023-01-01', '2023-12-03', '015', N'Châu Phi', N'Linh dương đầu bò là động vật ăn cỏ, kiếm ăn chủ yếu tại đồng cỏ ngắn. Linh dương đầu bò chủ yếu hoạt động vào buổi sáng và chiều tối. Thời gian nóng nhất trong ngày được chúng dành để nghỉ ngơi trong bóng cây hoặc bụi cỏ dày. Đây cũng là thời điểm linh dương đầu bò ưa thích nhổ nước và cỏ cạn cung cấp cho chúng nước uống cũng như thức ăn.',N'Khu vực 11', 'SP010', NULL),
('AN021', N'Nô-en','2022-1-23', '2023-4-12', '005', N'Châu Á', N'Gấu chó sinh sống chủ yếu trong các rừng mưa nhiệt đới ở khu vực Đông Nam Á. Chúng là loài nhỏ nhất của họ Gấu, lông ngắn và mượt. Màu lông đen sẫm hoặc nâu đen, ngoại trừ phần ngực có màu vàng da cam nhạt, có hình dạng giống như móng ngựa hoặc hình chữ U.',N'Khu vực 15', 'SP016',NULL),
('AN022', NULL,'2023-4-21', '2023-4-21', '007', N'Châu Á', N'Báo lửa, hay beo vàng châu Á, còn được gọi là beo vàng Temminck. Đây là loài động vật ăn thịt thuộc họ Mèo có kích thước trung bình (dài 90 cm, cộng với đuôi dài 50 cm), cân nặng 12 đến 16kg. Trong điều kiện nuôi nhốt, báo lửa có thể sống đến 20 năm.',N'Khu vực 16', 'SP007',NULL),
('AN023', NULL,'2023-5-10', '2023-5-10', '006', N'Nam Á', N'Cầy mực, hay còn gọi là chồn mực, là loài động vật ăn thịt thuộc họ Cầy. Môi trường sống của chúng là các khu rừng mưa ở Nam Á và Đông Nam Á. Cầy mực là loài thú ăn đêm và ngủ trên các cành cây.',N'Khu vực 17', 'SP017', NULL),
('AN024', NULL,'2023-1-2', '2023-10-2', '008', N'Châu Á', N'Loài rái cá nhỏ thân mập. Thân màu xám nâu, cổ và bụng trắng mờ. Vuốt ngón chân rất ngắn, không nhô ra khỏi đầu ngón chân. Màng bơi thoái hóa nhờ vậy các ngón chân chuyển động tự do.',N'Khu vực 10', 'SP013',NULL),
('AN025', NULL,'2023-12-4', '2023-12-4', '003', N'Châu Á', N'Loài sóc đen này chỉ phân bố tại Côn Đảo, Việt Nam. Sóc đen Côn Đảo sống trên những cây gỗ cao trong các khu rừng sâu trên núi hoặc dọc bờ sông, suối. Thức ăn của sóc đen bao gồm thực vật, một số loài côn trùng, kiến, mối, đôi khi cả trứng chim… Khi kiếm ăn, sóc thường phát ra tiếng kêu “túc…túc…” nên rất dễ phát hiện và bị săn bắn nhiều.',N'Khu vực 11', 'SP014',NULL),
('AN026', NULL,'2023-2-12', '2024-1-1', NULL, N'Châu Mỹ', N'Cò quăm đỏ là một loài chim thuộc Họ Cò quăm. Nó sinh sống vùng nhiệt đới Nam Mỹ và hải đảo vùng Caribê. Tuy hình dáng của nó giống như hầu hết các loài cò quăm khác, nó vẫn rất khác biệt ở màu lông đỏ tươi rựa rỡ. Khi còn bé, lông của cò quăm đỏ có màu nâu xám, bụng có màu trắng. Khi lớn lên, màu đỏ của lông có được là nhờ cò quăm đỏ ăn một loại cua nhỏ màu đỏ trong tự nhiên.',N'Khu vực 12', 'SP015',NULL),
('AN027', NULL,'2024-1-2', '2024-1-2', '008', N'Châu Á', N'Loài rái cá nhỏ thân mập. Thân màu xám nâu, cổ và bụng trắng mờ. Vuốt ngón chân rất ngắn, không nhô ra khỏi đầu ngón chân. Màng bơi thoái hóa nhờ vậy các ngón chân chuyển động tự do.',N'Khu vực 10', 'SP013',NULL),
('AN028',NULL, '2024-1-3', '2024-1-3', '012', N'Châu Mỹ', N'Cá sấu là các loài bò sát lớn ưa thích môi trường nước, chúng sống trên một diện tích rộng của khu vực nhiệt đới của châu Phi, châu Á, Bắc Mỹ, Nam Mỹ và châu Đại Dương. Cá sấu có xu hướng sinh sống ở những vùng sông và hồ có nước chảy chậm, thức ăn của chúng khá đa dạng, chủ yếu là động vật có vú sống hay đã chết cũng như cá.',N'Khu vực 13', 'SP012',NULL),
('AN029', N'Dương','2019-09-03', '2020-01-13', '004', N'Châu Á', N'Hổ Đông Dương có cân nặng trung bình từ 180 – 249kg, chiều dài trung bình từ mũi đến đuôi khoảng 2,7m. Môi trường sinh sống tự nhiên của Hổ Đông Dương là rừng lá rộng ẩm nhiệt đới và cận nhiệt đới. Quần thể loài này đã giảm hơn 70% trong một thập kỷ qua.',N'Khu vực 18', 'SP006', NULL);

--Thêm dữ liệu vào bảng Receipt
INSERT INTO Receipt (ReceiptID, OrderDate, Price, EmployeeID, PartnerID, CustomerID) VALUES 
('R001', '2024-03-19 09:15:00', 120000, 'TCV0018', NULL, 'C001'),
('R002', '2024-01-25 08:45:00', 160000, 'TCV0024', NULL, 'C002'),
('R003', '2024-02-13 11:00:00', 960000, 'TCV0025', NULL, 'C003'),
('R004', '2024-04-05 13:30:00', 40000, 'TCV0018', NULL, 'C004'),
('R005', '2024-03-15 10:00:00', 5350000, 'TCV0024', 'P016', NULL),
('R006', '2024-02-07 09:45:00', 180000, 'TCV0025', NULL, 'C006'),
('R007', '2024-04-01 08:30:00', 240000, 'TCV0018', NULL, 'C007'),
('R008', '2024-04-27 08:00:00', 300000, 'TCV0024', NULL, 'C008'),
('R009', '2024-03-18 07:45:00', 24000000, 'TCV0025', 'P017', NULL),
('R010', '2024-01-19 13:30:00', 180000, 'TCV0018', NULL, 'C010'),
('R011', '2024-04-22 09:15:00', 6000000, 'TCV0024', 'P018', NULL),
('R012', '2024-03-11 10:15:00', 31400000, 'TCV0025', 'P017', NULL),
('R013', '2024-04-12 08:30:00', 120000, 'TCV0018', NULL, 'C013'),
('R014', '2024-04-13 10:00:00', 600000, 'TCV0024', NULL, 'C014'),
('R015', '2024-01-14 08:30:00', 360000, 'TCV0025', NULL, 'C015'),
('R016', '2024-02-15 13:00:00', 12300000, 'TCV0018', 'P016', NULL),
('R017', '2024-04-29 13:30:00', 220000, 'TCV0024', NULL, 'C017'),
('R018', '2024-03-22 09:15:00', 320000, 'TCV0025', NULL, 'C018'),
('R019', '2024-04-30 08:45:00', 100000, 'TCV0018', NULL, 'C019'),
('R020', '2024-01-20 08:40:00', 15860000, 'TCV0024', 'P018', NULL);


--Thêm dữ liệu vào bảng Feeding Management
INSERT INTO FeedingManagement(FManagementID, EmployeeID, SpeciesID, WorkShift, FeedingTime) VALUES
    ('FM001', 'TCV0006', 'SP001', N'Ca 1 (07:00:00 - 12:00:00)', N'7:00:00 và 12:00:00'),
    ('FM002', 'TCV0009', 'SP002', N'Ca 2 (12:00:00 - 17:00:00)', N'7:00:00 và 16:00:00'),
    ('FM003', 'TCV0010', 'SP003', N'Ca 2 (12:00:00 - 17:00:00)', N'12:00:00 và 16:00:00'),
    ('FM004', 'TCV0012', 'SP004', N'Ca 1 (07:00:00 - 12:00:00)', N'7:00:00 và 12:00:00'),
    ('FM005', 'TCV0013', 'SP005', N'Ca 2 (12:00:00 - 17:00:00)', N'7:00:00 và 16:00:00'),
    ('FM006', 'TCV0014', 'SP006', N'Ca 1 (07:00:00 - 12:00:00)', N'12:00:00 và 16:00:00'),
    ('FM007', 'TCV0015', 'SP007', N'Ca 2 (12:00:00 - 17:00:00)', N'7:00:00 và 12:00:00'),
    ('FM008', 'TCV0019', 'SP008', N'Ca 2 (12:00:00 - 17:00:00)', N'7:00:00 và 16:00:00'),
    ('FM009', 'TCV0020', 'SP009', N'Ca 2 (12:00:00 - 17:00:00)', N'12:00:00 và 16:00:00'),
    ('FM010', 'TCV0006', 'SP010', N'Ca 1 (07:00:00 - 12:00:00)', N'7:00:00 và 12:00:00'),
    ('FM011', 'TCV0009', 'SP011', N'Ca 2 (12:00:00 - 17:00:00)', N'7:00:00 và 16:00:00'),
    ('FM012', 'TCV0010', 'SP012', N'Ca 1 (07:00:00 - 12:00:00)', N'12:00:00 và 16:00:00'),
    ('FM013', 'TCV0012', 'SP013', N'Ca 2 (12:00:00 - 17:00:00)', N'7:00:00 và 12:00:00'),
    ('FM014', 'TCV0013', 'SP014', N'Ca 1 (07:00:00 - 12:00:00)', N'7:00:00 và 16:00:00'),
    ('FM015', 'TCV0014', 'SP015', N'Ca 1 (07:00:00 - 12:00:00)', N'12:00:00 và 16:00:00'),
    ('FM016', 'TCV0015', 'SP016', N'Ca 2 (12:00:00 - 17:00:00)', N'7:00:00 và 16:00:00'),
    ('FM017', 'TCV0019', 'SP017', N'Ca 1 (07:00:00 - 12:00:00)', N'12:00:00 và 16:00:00');

 --Thêm dữ liệu vào Management 
INSERT INTO Management (ManagementID, EmployeeID, WorkShift, SpeciesID, ActivityID, ServiceID, PlantID)
VALUES
('MNG0001', 'TCV0001', N'Ca 1 (07:00:00 - 12:00:00)', NULL, NULL, NULL, NULL),
('MNG0002', 'TCV0004', N'Ca 2 (12:00:00 - 17:00:00)', NULL, NULL, NULL, NULL),
('MNG0003', 'TCV0017', N'Ca 1 (07:00:00 - 12:00:00)', NULL, NULL, NULL, NULL),
('MNG0004', 'TCV0005', N'Ca 2 (12:00:00 - 17:00:00)', NULL, 'AC002',NULL, NULL),
('MNG0005', 'TCV0006', N'Ca 1 (07:00:00 - 12:00:00)', NULL, 'AC003',NULL, NULL),
('MNG0006', 'TCV0003', N'Ca 2 (12:00:00 - 17:00:00)', NULL,NULL, 'SR002', NULL),
('MNG0007', 'TCV0022', N'Ca 1 (07:00:00 - 12:00:00)', NULL, NULL,'SR003',  NULL),
('MNG0008', 'TCV0013', N'Ca 2 (12:00:00 - 17:00:00)', 'SP001', NULL, NULL, NULL),
('MNG0009', 'TCV0009', N'Ca 1 (07:00:00 - 12:00:00)', 'SP002', NULL, NULL, NULL),
('MNG0010', 'TCV0010', N'Ca 2 (12:00:00 - 17:00:00)', 'SP003', NULL, NULL, NULL),
('MNG0011', 'TCV0012', N'Ca 1 (07:00:00 - 12:00:00)', 'SP004', NULL, NULL, NULL),
('MNG0012', 'TCV0024', N'Ca 2 (12:00:00 - 17:00:00)', NULL, NULL, NULL, NULL),
('MNG0013', 'TCV0025', N'Ca 1 (07:00:00 - 12:00:00)', NULL, NULL, NULL, NULL),
('MNG0014', 'TCV0015', N'Ca 2 (12:00:00 - 17:00:00)', NULL, NULL, NULL, 'P0001'),
('MNG0015', 'TCV0020', N'Ca 1 (07:00:00 - 12:00:00)', NULL, NULL, NULL, 'P0005'),
('MNG0016', 'TCV0011', N'Ca 2 (12:00:00 - 17:00:00)', NULL, NULL, NULL, NULL)


--Thêm dữ liệu vào bảng History Detail
INSERT INTO History_Detail (HistoryID, Date, Status, Description)
VALUES
		('H001', '2024-01-05 08:30:00', N'Khỏe mạnh', N'Tốt'),
		('H002', '2024-02-15 14:00:00', N'Khỏe mạnh', N'Tốt'),
		('H003', '2024-01-07 09:00:00', N'Khỏe mạnh', N'Tốt'),
		('H004', '2024-01-15 08:30:00', N'Không khỏe', N'Sốt'),
		('H005', '2024-02-10 12:30:00', N'Khỏe mạnh', N'Tốt'),
		('H006', '2024-01-25 13:45:00', N'Khỏe mạnh', N'Tốt'),
		('H007', '2024-03-11 10:15:00', N'Khỏe mạnh', N'Tốt'),
		('H008', '2024-01-12 08:30:00', N'Khỏe mạnh', N'Tốt'),
		('H009', '2024-04-13 10:00:00', N'Không khỏe', N'Giảm thị lực'),
		('H010', '2024-01-14 08:30:00', N'Không khỏe', 'Chán ăn'),
		('H011', '2024-03-15 15:00:00', N'Khỏe mạnh', N'Tốt'),
		('H012', '2024-04-16 11:00:00', N'Khỏe mạnh', N'Tốt'),
		('H013', '2024-02-27 08:00:00', N'Khỏe mạnh', N'Tốt'),
		('H014', '2024-04-18 07:45:00', N'Khỏe mạnh', N'Tốt'),
		('H015', '2024-01-19 13:30:00', N'Không khỏe', N'Tim đập nhanh'),
		('H016', '2024-04-22 09:15:00', N'Khỏe mạnh', N'Tốt'),
		('H017', '2024-03-19 07:45:00', N'Khỏe mạnh', N'Tốt'),
		('H018', '2024-01-20 08:40:00', N'Không khỏe', N'Sốt'),
		('H019', '2024-03-21 07:45:00', N'Không khỏe', N'Tiêu chảy'),
		('H020', '2024-04-08 15:45:00', N'Không khỏe', N'Viêm da'),
		('H021', '2024-04-29 11:25:00', N'Khỏe mạnh', N'Tốt'),
		('H022', '2024-04-30 10:00:00', N'Khỏe mạnh', N'Tốt'),
		('H023', '2024-03-19 08:25:00', N'Khỏe mạnh', N'Tốt'),
		('H024', '2024-04-02 10:50:00', N'Không khỏe', N'Sốt'),
		('H025', '2024-01-13 09:05:00', N'Khỏe mạnh', N'Tốt'),
		('H026', '2024-04-04 12:20:00', N'Khỏe mạnh', N'Tốt'),
		('H027', '2024-02-25 11:05:00', N'Không khỏe', N'Chán ăn'),
		('H028', '2024-03-06 08:25:00', N'Khỏe mạnh', N'Tốt'),
		('H029', '2024-06-05 07:25:00', N'Khỏe mạnh', N'Tốt'),
		('H030', '2024-06-18 14:10:00', N'Không khỏe', N'Chán ăn'),
		('H031', '2024-05-17 09:35:00', N'Không khỏe', N'Sốt'),
		('H032', '2024-07-29 15:10:00', N'Khỏe mạnh', N'Tốt'),
		('H033', '2024-08-27 11:50:00', N'Khỏe mạnh', N'Tốt');

--Thêm dữ liệu vào bảng Medical Record
INSERT INTO Medical_Record(AnimalID, MedicalRecordID, VaccineStatus)
VALUES 
		('AN001','MR01',N'Đã tiêm'),
		('AN002','MR02',N'Chưa tiêm'),
		('AN003','MR03',N'Chưa tiêm'),
		('AN004','MR04',N'Đã tiêm'),
		('AN005','MR05',N'Đã tiêm'),
		('AN006','MR06',N'Đã tiêm'),
		('AN007','MR07',N'Chưa tiêm'),
		('AN008','MR08',N'Đã tiêm'),
		('AN009','MR09',N'Đã tiêm'),
		('AN010','MR10',N'Đã tiêm'),
		('AN011','MR11',N'Chưa tiêm'),
		('AN012','MR12',N'Đã tiêm'),
		('AN013','MR13',N'Chưa tiêm'),
		('AN014','MR14',N'Chưa tiêm'),
		('AN015','MR15',N'Đã tiêm'),
		('AN016','MR16',N'Chưa tiêm'),
		('AN017','MR17',N'Chưa tiêm'),
		('AN018','MR18',N'Đã tiêm'),
		('AN019','MR19',N'Chưa tiêm'),
		('AN020','MR20',N'Chưa tiêm'),
		('AN021','MR21',N'Đã tiêm'),
		('AN022','MR22',N'Chưa tiêm'),
		('AN023','MR23',N'Đã tiêm'),
		('AN024','MR24',N'Chưa tiêm'),
		('AN025','MR25',N'Đã tiêm'),
		('AN026','MR26',N'Đã tiêm'),
		('AN027','MR27',N'Đã tiêm'),
		('AN028','MR28',N'Đã tiêm')

--Thêm dữ liệu vào bảng Medical Record History
INSERT INTO Medical_Record_History(AnimalID, MedicalRecordID, HistoryID, MedicalRecordUnit) 
VALUES
		('AN001','MR01','H001',N'Chi cục thú y TPHCM'),
		('AN002','MR02','H002',N'Bệnh viện thú y Miền Nam'),
		('AN003','MR03','H003',N'Bệnh viện thú y PETPRO'),
		('AN004','MR04','H004',N'Chi cục thú y TPHCM'),
		('AN005','MR05','H005',N'Bệnh viện thú y Miền Nam'),
		('AN006','MR06','H006',N'Bệnh viện thú y PETPRO'),
		('AN007','MR07','H007',N'Chi cục thú y TPHCM'),
		('AN008','MR08','H008',N'Bệnh viện thú y Miền Nam'),
		('AN009','MR09','H009',N'Chi cục thú y TPHCM'),
		('AN010','MR10','H010',N'Chi cục thú y TPHCM'),
		('AN011','MR11','H011',N'Chi cục thú y TPHCM'),
		('AN012','MR12','H012',N'Bệnh viện thú y Miền Nam'),
		('AN013','MR13','H013',N'Bệnh viện thú y Miền Nam'),
		('AN014','MR14','H014',N'Bệnh viện thú y Miền Nam'),
		('AN015','MR15','H015',N'Chi cục thú y TPHCM'),
		('AN016','MR16','H016',N'Bệnh viện thú y Miền Nam'),
		('AN017','MR17','H017',N'Bệnh viện thú y PETPRO'),
		('AN018','MR18','H018',N'Chi cục thú y TPHCM'),
		('AN019','MR19','H019',N'Bệnh viện thú y Miền Nam'),
		('AN020','MR20','H020',N'Bệnh viện thú y PETPRO'),
		('AN021','MR21','H021',N'Chi cục thú y TPHCM'),
		('AN022','MR22','H022',N'Chi cục thú y TPHCM'),
		('AN023','MR23','H023',N'Bệnh viện thú y Miền Nam'),
		('AN024','MR24','H024',N'Chi cục thú y TPHCM'),
		('AN025','MR25','H025',N'Chi cục thú y TPHCM'),
		('AN026','MR26','H026',N'Bệnh viện thú y Miền Nam'),
		('AN027','MR27','H027',N'Chi cục thú y TPHCM'),
		('AN028','MR28','H028',N'Chi cục thú y TPHCM'),
		('AN010','MR10','H029',N'Bệnh viện thú y PETPRO'),
		('AN026','MR26','H030',N'Bệnh viện thú y Miền Nam'),
		('AN022','MR22','H031',N'Chi cục thú y TPHCM'),
		('AN003','MR03','H032',N'Bệnh viện thú y PETPRO'),
		('AN018','MR18','H033',N'Chi cục thú y TPHCM')