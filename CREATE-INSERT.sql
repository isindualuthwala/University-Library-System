CREATE TABLE Item
(
	Item_ID CHAR(5) NOT NULL,
	Item_Name VARCHAR(50) NOT NULL,
	Publisher VARCHAR(50) NOT NULL,

	CONSTRAINT Item_PK PRIMARY KEY(Item_ID)
);

CREATE TABLE Book
(
	Item_ID CHAR(5) NOT NULL,
	ISBN CHAR(13) NOT NULL,
	Author VARCHAR(50) NOT NULL,
	Genre VARCHAR(50) NOT NULL,

	CONSTRAINT Book_PK PRIMARY KEY(Item_ID),
	CONSTRAINT Book_FK FOREIGN KEY(Item_ID) REFERENCES Item(Item_ID)
);

CREATE TABLE Journal
(
	Item_ID CHAR(5) NOT NULL,
	ISSN CHAR(9) NOT NULL,
	Issue VARCHAR(10) NOT NULL,
	Volume VARCHAR(10) NOT NULL,

	CONSTRAINT Journal_PK PRIMARY KEY(Item_ID),
	CONSTRAINT Journal_FK FOREIGN KEY(Item_ID) REFERENCES Item(Item_ID)
);

CREATE TABLE Digital_Media
(
	Item_ID CHAR(5) NOT NULL,
	DMID CHAR(5) NOT NULL,
	Media_Format VARCHAR(10) NOT NULL,
	Volume VARCHAR(10) NOT NULL,

	CONSTRAINT Digital_Media_PK PRIMARY KEY(Item_ID),
	CONSTRAINT Digital_Media_FK FOREIGN KEY(Item_ID) REFERENCES Item(Item_ID)
);

CREATE TABLE Library_User
(
	UserID CHAR(5) NOT NULL,
	First_Name VARCHAR(50) NOT NULL,
	Last_Name VARCHAR(50) NOT NULL,
	Email VARCHAR(50) NOT NULL,

	CONSTRAINT Library_User_PK PRIMARY KEY(UserID),
);

CREATE TABLE User_Contact
(
	UserID CHAR(5) NOT NULL,
	Contact_Number VARCHAR(15) NOT NULL,

	CONSTRAINT User_Contact_PK PRIMARY KEY(UserID),
	CONSTRAINT User_Contact_FK FOREIGN KEY(UserID) REFERENCES Library_User(UserID)
);

CREATE TABLE Student
(
	Student_ID char (5) NOT NULL,
	Major varchar (50) NOT NULL,
	Year_Of_Study varchar (10) NOT NULL,

	CONSTRAINT Student_PK PRIMARY KEY(Student_ID),
	CONSTRAINT Student_FK FOREIGN KEY(Student_ID) REFERENCES Library_User(UserID)

);

CREATE TABLE Faculty_Member
(
	FID char (5) NOT NULL,
	Title varchar (50) NOT NULL,
	Department varchar (50) NOT NULL,

	CONSTRAINT Faculty_Member_PK PRIMARY KEY(FID),
	CONSTRAINT Faculty_Member_FK FOREIGN KEY(FID) REFERENCES Library_User(UserID)

);

CREATE TABLE Staff
(
	StaffID char (5) NOT NULL,
	Position varchar (50) NOT NULL,
	Office varchar (50) NOT NULL,

	CONSTRAINT Staff_PK PRIMARY KEY(StaffID),
	CONSTRAINT Staff_FK FOREIGN KEY(StaffID) REFERENCES Library_User(UserID)

);

CREATE TABLE Librarian
(
	LID char (5) NOT NULL,
	Department varchar (50) NOT NULL,
	Designation varchar (50) NOT NULL,

	CONSTRAINT Librarian_PK PRIMARY KEY(LID),
	CONSTRAINT Librarian_FK FOREIGN KEY(LID) REFERENCES Library_User(UserID)

);

CREATE TABLE Item_Copy
(
	Copy_ID char (5) NOT NULL,
	Condition varchar (50) NOT NULL,
	Shelf varchar (50) NOT NULL,
	Item_ID char (5) NOT NULL,

	CONSTRAINT Item_Copy_PK PRIMARY KEY(Copy_ID),
	CONSTRAINT Item_Copy_FK FOREIGN KEY(Item_ID) REFERENCES Item(Item_ID)

);

CREATE TABLE Library_Branch 
(
    Branch_ID char (5) NOT NULL,
    Branch_Name varchar (50) NOT NULL,
    Branch_Location varchar (50) NOT NULL,

    CONSTRAINT Library_Branch_PK PRIMARY KEY(Branch_ID)

);

CREATE TABLE Library_Has_Copy 
(
    Copy_ID char (5) NOT NULL,
    Branch_ID char (5) NOT NULL, 
 
    CONSTRAINT Library_Has_Copy_PK PRIMARY KEY(Copy_ID, Branch_ID),
	CONSTRAINT Library_Has_Copy_FK1 FOREIGN KEY(Copy_ID) REFERENCES Item_Copy(Copy_ID),
	CONSTRAINT Library_Has_Copy_FK2 FOREIGN KEY(Branch_ID) REFERENCES Library_Branch(Branch_ID)
);

CREATE TABLE Category 
(
    Category_ID char (5) NOT NULL,
    Category_Name varchar (50) NOT NULL,

    CONSTRAINT Category_PK PRIMARY KEY(Category_ID)

);

CREATE TABLE Item_Belongs_Category
(
    Item_ID char (5) NOT NULL,
    Category_ID char (5) NOT NULL,

    CONSTRAINT Item_Belongs_Category_PK PRIMARY KEY(Item_ID, Category_ID),
	CONSTRAINT Item_Belongs_Category_FK1 FOREIGN KEY(Item_ID) REFERENCES Item(Item_ID),
	CONSTRAINT Item_Belongs_Category_FK2 FOREIGN KEY(Category_ID) REFERENCES Category(Category_ID)
 
);

CREATE TABLE Review 
(
    UserID char (5) NOT NULL,
    Item_ID char (5) NOT NULL,
    Review_Date date NOT NULL,
    Rating varchar (10) NOT NULL,
    Comment varchar (50) NOT NULL,

    CONSTRAINT Review_PK PRIMARY KEY(UserID, Item_ID),
	CONSTRAINT Review_FK1 FOREIGN KEY(UserID) REFERENCES Library_User(UserID),
	CONSTRAINT Review_FK2 FOREIGN KEY(Item_ID) REFERENCES Item(Item_ID)

);

 CREATE TABLE Msg
 (
	MID char (5) NOT NULL,
	Msg varchar(50) NOT NULL,
	LID char(5),

	CONSTRAINT Msg_PK PRIMARY KEY(MID),
	CONSTRAINT Msg_FK FOREIGN KEY(LID) REFERENCES Librarian(LID)
);

CREATE TABLE Msg_Deliver_LUser
(
	UserID char (5) NOT NULL,
	MID char (5) NOT NULL,

	CONSTRAINT Msg_Deliver_LUser_PK PRIMARY KEY(UserID, MID),
	CONSTRAINT Msg_Deliver_LUser_FK1 FOREIGN KEY(UserID) REFERENCES Library_User(UserID),
	CONSTRAINT Msg_Deliver_LUser_FK2 FOREIGN KEY(MID) REFERENCES Msg(MID)
	
);

CREATE TABLE Borrowed_Item
(
	Borrow_ID char(5) NOT NULL,
	Due_Date varchar(10) NOT NULL,
	Borrow_Status varchar(10) NOT NULL,
	Copy_ID char(5) NOT NULL,
	UserID char(5) NOT NULL,

	CONSTRAINT BORROW_Item_PK PRIMARY KEY(Borrow_ID),
	CONSTRAINT BORROW_Item_FK1 FOREIGN KEY(Copy_ID) REFERENCES Item_Copy(Copy_ID),
	CONSTRAINT BORROW_Item_FK2 FOREIGN KEY(UserID) REFERENCES Library_User(UserID)

);

CREATE TABLE Returned
(
	Return_ID char(5) NOT NULL,
	Return_Condition varchar(50) NOT NULL,
	Return_Date date NOT NULL,
	Borrow_ID char(5),

	CONSTRAINT Returned_PK PRIMARY KEY(Return_ID),
	CONSTRAINT Returned_FK FOREIGN KEY(Borrow_ID) REFERENCES Borrowed_Item(Borrow_ID) 
	
);

CREATE TABLE Fine
(
	Fine_ID char(5) NOT NULL,
	Amount float NOT NULL,
	Reason varchar(50) NOT NULL,
	Return_ID char(5) Not NULL,

	CONSTRAINT Fine_PK PRIMARY KEY(Fine_ID),
	CONSTRAINT Fine_FK FOREIGN KEY(Return_ID) REFERENCES Returned(Return_ID)

);

CREATE TABLE User_Borrow_Copy
(
	UserID char(5) NOT NULL,
	Copy_ID char(5) NOT NULL,
	Borrow_Date date NOT NULL,

	CONSTRAINT User_Borrow_Copy_PK PRIMARY KEY(UserID,Copy_ID),
	CONSTRAINT User_Borrow_Copy_FK1 FOREIGN KEY(UserID) REFERENCES Library_User(UserID),
	CONSTRAINT User_Borrow_Copy_FK2 FOREIGN KEY(Copy_ID) REFERENCES Item_Copy(Copy_ID)

);

ALTER TABLE Library_User
ADD CONSTRAINT Email_Check
CHECK (Email LIKE '%@%.%');



ALTER TABLE User_Contact
ADD CONSTRAINT Contact_Number_Check
CHECK (PATINDEX('+94-[0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]', Contact_Number) = 1);



INSERT INTO Item (Item_ID, Item_Name, Publisher) VALUES 
('B0001', 'Book A', 'Publisher 1'),
('B0002', 'Book B', 'Publisher 2'),
('B0003', 'Book C', 'Publisher 3'),
('B0004', 'Book D', 'Publisher 3'),
('B0005', 'Book E', 'Publisher 4'),
('J0001', 'Journal A', 'Publisher 5'),
('J0002', 'Journal B', 'Publisher 6'),
('J0003', 'Journal C', 'Publisher 7'),
('J0004', 'Journal D', 'Publisher 8'),
('J0005', 'Journal E', 'Publisher 9'),
('M0001', 'Media A', 'Publisher 10'),
('M0002', 'Media B', 'Publisher 11'),
('M0003', 'Media C', 'Publisher 12'),
('M0004', 'Media D', 'Publisher 13'),
('M0005', 'Media E', 'Publisher 14');


INSERT INTO Book (Item_ID, ISBN, Author, Genre) VALUES
('B0001', '7788130000000', 'J.R.R.Talkien', 'Fantasy'), 
('B0002', '7788130000001', 'Arthur C. Clarke ', 'Science Fiction'), 
('B0003', '7788130000002', 'J.R.R.Talkien', 'Fantasy'), 
('B0004', '7788130000003', 'Jeff Kinney', 'Comedy'), 
('B0005', '9780134685991', 'Kevin Kwan', 'Romantic');

INSERT INTO Journal (Item_ID, ISSN, Issue, Volume) VALUES 
('J0001', '1234-5678', 'Issue 1', 'Vol 1'),
('J0002', '2234-5678', 'Issue 2', 'Vol 2'),
('J0003', '3234-5678', 'Issue 3', 'Vol 3'),
('J0004', '4234-5678', 'Issue 4', 'Vol 4'),
('J0005', '5234-5678', 'Issue 5', 'Vol 5');

INSERT INTO Digital_Media (Item_ID, DMID, Media_Format, Volume) VALUES 
('M0001', 'D0001', 'Video', 'Vol 1'),
('M0002', 'D0002', 'Audio', 'Vol 2'),
('M0003', 'D0003', 'Audio', 'Vol 3'),
('M0004', 'D0004', 'Text', 'Vol 4'),
('M0005', 'D0005', 'Text', 'Vol 5');






INSERT INTO Library_User (UserID, First_Name, Last_Name, Email) VALUES 
('S0001', 'Sandul', 'Wickrama', 'sandul@example.com'),
('S0002', 'Sugreewa', 'Rajapaksha', 'sugreewa@example.com'),
('S0003', 'Vikum', 'Jayawardana', 'vikum@example.com'),
('S0004', 'Isindu', 'Jayasooriya', 'isindu@example.com'),
('S0005', 'Dimuthu', 'Dilshan', 'dimuthu@example.com'),
('F0001', 'Kasun', 'Perera', 'kasun.perera@example.com'),
('F0002', 'Nuwan', 'Silva', 'nuwan.silva@example.com'),
('F0003', 'Amaya', 'Fernando', 'amaya.fernando@example.com'),
('F0004', 'Sanduni', 'Wijesinghe', 'sanduni.wijesinghe@example.com'),
('F0005', 'Ruwan', 'Jayasinghe', 'ruwan.jayasinghe@example.com'),
('Sf001', 'Tharushi', 'Gunawardena', 'tharushi.gunawardena@example.com'),
('Sf002', 'Anura', 'Ratnayake', 'anura.ratnayake@example.com'),
('Sf003', 'Chathura', 'Dias', 'chathura.dias@example.com'),
('Sf004', 'Samantha', 'De Silva', 'samantha.desilva@example.com'),
('Sf005', 'Ishara', 'Hettiarachchi', 'ishara.hettiarachchi@example.com'),
('L0001', 'Kavinda', 'Abeysekera', 'kavinda.abeysekera@example.com'),
('L0002', 'Dilshan', 'Senanayake', 'dilshan.senanayake@example.com'),
('L0003', 'Nadeeka', 'Bandara', 'nadeeka.bandara@example.com'),
('L0004', 'Thilini', 'Rajapaksha', 'thilini.rajapaksha@example.com'),
('L0005', 'Suresh', 'Dissanayake', 'suresh.dissanayake@example.com');


INSERT INTO User_Contact (UserID, Contact_Number) VALUES 
('S0001', '+94-77-111-1117'),
('S0002', '+94-71-444-5555'),
('S0003', '+94-76-555-6666'),
('S0004', '+94-72-888-9999'),
('S0005', '+94-72-999-9999');

INSERT INTO Student (Student_ID, Major, Year_Of_Study) VALUES
('S0001', 'Information Technology', 'First'),
('S0002', 'Information Technology', 'Second'),
('S0003', 'Information Technology', 'Second'),
('S0004', 'Business Management', 'Third'),
('S0005', 'Engineering', 'Fourth');


INSERT INTO Faculty_Member (FID, Title, Department) VALUES 
('F0001', 'Professor', 'Computer Science'),
('F0002', 'Associate Professor', 'Biology'),
('F0003', 'Assistant Professor', 'Mathematics'),
('F0004', 'Lecturer', 'Physics'),
('F0005', 'Researcher', 'Chemistry');

INSERT INTO Staff (StaffID, Position, Office) VALUES 
('Sf001', 'Clerk', 'Main Office'),
('Sf002', 'Administrator', 'HR Office'),
('Sf003', 'System Administrator', 'IT Office'),
('Sf004', 'Supervisor', 'Maintenance'),
('Sf005', 'Receptionist', 'Front Desk');



INSERT INTO Librarian (LID, Department, Designation) VALUES 
('L0001', 'Engineering', 'Assistant'),
('L0002', 'Information Technology', 'Assistant'),
('L0003', 'Business Management', 'Assistant'),
('L0004', 'Information Technology', 'Manager'),
('L0005', 'Engineering', 'Manager');


INSERT INTO Item_Copy (Copy_ID, Condition, Shelf, Item_ID) VALUES 
('C0001', 'Good', 'Shelf A1', 'B0001'),
('C0002', 'Excellent', 'Shelf A2', 'B0002'),
('C0003', 'Fair', 'Shelf B1', 'B0003'),
('C0004', 'New', 'Shelf B2', 'B0004'),
('C0005', 'Good', 'Shelf C1', 'B0005'),
('C0006', 'Fair', 'Shelf C2', 'J0001'),
('C0007', 'Excellent', 'Shelf D1', 'J0002'),
('C0008', 'New', 'Shelf D2', 'J0003'),
('C0009', 'Good', 'Shelf E1', 'J0004'),
('C0010', 'Excellent', 'Shelf E2', 'J0005'),
('C0011', 'Fair', 'Shelf F1', 'M0001'),
('C0012', 'New', 'Shelf F2', 'M0002'),
('C0013', 'Good', 'Shelf G1', 'M0003'),
('C0014', 'Excellent', 'Shelf G2', 'M0004'),
('C0015', 'Fair', 'Shelf H1', 'M0005');


INSERT INTO Library_Branch (Branch_ID, Branch_Name, Branch_Location) VALUES 
('B001', 'Central Library', 'New building Level 1'),
('B002', 'East Branch', 'Main building Level 3'),
('B003', 'West Branch', 'BM building Level 4'),
('B004', 'North Branch', 'New building Level 2'),
('B005', 'South Branch', 'New building Level 3');




INSERT INTO Library_Has_Copy (Copy_ID, Branch_ID) VALUES 
('C0001', 'B001'),
('C0002', 'B002'),
('C0003', 'B003'),
('C0004', 'B004'),
('C0005', 'B005');




INSERT INTO Category (Category_ID, Category_Name) VALUES 
('Cat01', 'Fantasy'),
('Cat02', 'Science fiction'),
('Cat03', 'Science'),
('Cat04', 'Comedy'),
('Cat05', 'Romantic');


INSERT INTO Item_Belongs_Category (Item_ID, Category_ID) VALUES 
('B0001', 'Cat01'),
('B0002', 'Cat02'),
('B0003', 'Cat03'),
('B0004', 'Cat04'),
('B0005', 'Cat05'),
('J0001', 'Cat01'),
('J0002', 'Cat02'),
('J0003', 'Cat03'),
('J0004', 'Cat04'),
('J0005', 'Cat05'),
('M0001', 'Cat01'),
('M0002', 'Cat02'),
('M0003', 'Cat03'),
('M0004', 'Cat04'),
('M0005', 'Cat05');



INSERT INTO Review (UserID, Item_ID, Review_Date, Rating, Comment) VALUES 
('S0001', 'B0001', '2024-10-10', '5', 'Excellent read'),
('S0002', 'B0002', '2024-10-11', '4', 'Very informative'),
('S0003', 'B0003', '2024-10-12', '3', 'Good content'),
('S0004', 'B0004', '2024-10-13', '5', 'Loved it'),
('S0005', 'B0005', '2024-10-14', '2', 'Not my favorite');

INSERT INTO Msg (MID, Msg, LID) VALUES 
('00001', 'Library is closing soon.', 'L0004'),
('00002', 'New books arrived.', 'L0004'),
('00003', 'Staff meeting at 10 AM.', 'L0005'),
('00004', 'Library event next week.', 'L0005'),
('00005', 'Holiday hours posted.', 'L0005');


INSERT INTO Msg_Deliver_LUser (UserID, MID) VALUES 
('S0001', '00001'),
('S0002', '00002'),
('S0003', '00003'),
('S0004', '00004'),
('S0005', '00005');


INSERT INTO Borrowed_Item (Borrow_ID, Due_Date, Borrow_Status, Copy_ID, UserID) VALUES 
('Br001', '2024-10-01', 'Borrowed', 'C0001', 'S0001'),
('Br002', '2024-10-02', 'Borrowed', 'C0002', 'S0002'),
('Br003', '2024-10-03', 'Returned', 'C0003', 'S0003'),
('Br004', '2024-10-04', 'Borrowed', 'C0004', 'S0004'),
('Br005', '2024-10-05', 'Returned', 'C0005', 'S0005');


INSERT INTO Returned (Return_ID, Return_Condition, Return_Date, Borrow_ID)
VALUES 
('R0001', 'Good', '2024-10-02', 'Br001'),
('R0002', 'Fair', '2024-10-02', 'Br002'),
('R0003', 'Excellent', '2024-10-02', 'Br003'),
('R0004', 'Good', '2024-10-02', 'Br004'),
('R0005', 'Damaged', '2024-10-02', 'Br005');

INSERT INTO Fine (Fine_ID, Amount, Reason, Return_ID)
VALUES 
('F0001', 50.00, 'Late return', 'R0001'),
('F0002', 90.00, 'Damaged', 'R0005');


INSERT INTO User_Borrow_Copy (UserID, Copy_ID, Borrow_Date)
VALUES 
('S0001', 'C0001', '2024-01-15'),
('S0002', 'C0002', '2024-01-20'),
('S0003', 'C0003', '2024-01-22'),
('S0004', 'C0004', '2024-01-25'),
('S0005', 'C0005', '2024-01-30');
