CREATE DATABASE BuddhAirBase;

USE BuddhAirBase;

CREATE TABLE AirCrafts(
AcID INT Primary Key,
AcNumber Varchar(32) NOT NULL,
Capacity INT NOT NULL,
MfdBy Varchar(128) NOT NULL,
MfdOn Datetime NOT NULL
);


INSERT INTO AirCrafts
(AcID, AcNumber, Capacity, MfdBy, MfdOn)
VALUES
(1, 'ATR 72-500', 75, 'Alenia Aeronotica', '1998-04-24');

select * from  AirCrafts;

CREATE TABLE Route(
RtID INT,
Airport Varchar(32) NOT NULL,
Destination Varchar(32) NOT NULL,
RouteCode Varchar(16) NOT NULL UNIQUE,
PRIMARY KEY (RtID)
);


INSERT INTO Route (RtID, Airport, Destination, RouteCode)
VALUES (1, 'Kathmandu', 'Pokhara', 'KTM-PKR');

select * from Route;

CREATE TABLE AirFare(
AfID INT,
Route INT,
Fare INT,
FSC INT,
PRIMARY KEY (AfID),
CONSTRAINT fk_Route FOREIGN KEY (Route) REFERENCES
Route(RtID)
);

INSERT INTO AirFare
VALUES
(1,1, 86, 12);

select * from AirFare;
CREATE TABLE Flight_Schedule(
FIID INT,
FlightDate DATETIME,
Departure DATETIME,
Arrival DATETIME,
AirCraft INT,
NetFare INT,
PRIMARY KEY (FIID),
CONSTRAINT fk_AirCraft FOREIGN KEY (AirCraft) REFERENCES
AirCrafts(AcID),
CONSTRAINT fk_NetFare FOREIGN KEY (NetFare) REFERENCES
AirFare(AfID)
);
/*Insert DATA into Flight Schedule */


INSERT INTO Flight_Schedule (FIID, FlightDate, Departure, Arrival, AirCraft, NetFare)
VALUES (1, '2023-05-10 10:00:00', '2023-05-10 10:00:00', '2023-05-10 12:00:00', 1, 1);


CREATE TABLE Discounts(
DiID INT PRIMARY KEY,
Title Varchar(32),
Amount INT,
Description Varchar (255)
);

INSERT INTO Discounts
VALUES
(1,'Children',10, 'Discount is provide all childrens under age of 10.');

select * from Discounts;

CREATE TABLE Charges(
ChID INT PRIMARY KEY,
Title Varchar(32),
Amount INT,
Description Varchar (255)
);

INSERT INTO Charges
VALUES
(2, 'Urgent Cancellation', 33, '33% will be charged for cancellation for booking within 11 hrs from flight');
 
select * from Charges;

CREATE TABLE Countries (
CtID INT PRIMARY KEY,
CountryName Varchar (32) NOT NULL
);


INSERT INTO Countries
VALUES
(1,'Nepal');

select * from Countries;

CREATE TABLE State(
StID INT,
StateName Varchar (32),
Country INT,
PRIMARY KEY (StID),
CONSTRAINT fk_Country FOREIGN KEY (Country) REFERENCES Countries(CtD)
);

INSERT INTO State
VALUES
(1,'Bagmati',1);

/*Create Contact_Details table*/
 
select * from State;

CREATE TABLE Contact_Details(
CnID INT PRIMARY KEY,
Email Varchar (16) NOT NULL,
Cell Varchar (16) NOT NULL,
Tel Varchar (16),
Street Varchar (64),
State INT NOT NULL,
CONSTRAINT fk_State FOREIGN KEY (State) REFERENCES State(StID)
);

INSERT INTO Contact_Details
VALUES
(1, 'hello@sd.com', '1234567890','9876543210','Gandaki Marga', 1);

CREATE TABLE Passengers(
PsID INT PRIMARY KEY,
Name Varchar (32) NOT NULL, Address Varchar (64) NOT NULL,
Age INT NOT NULL,
Nationality Varchar(16) NOT NULL,
Contacts INT NOT NULL,
CONSTRAINT fk_Contacts FOREIGN KEY (Contacts) REFERENCES
Contact_Details(CnID)
);

INSERT INTO Passengers
VALUES
(1, 'Shekhar Kumar Sharma', 'Sinamangal-39', 23, 'Nepalese', 1);

CREATE TABLE Branches(
BrID INT PRIMARY KEY,
Center Varchar(16) NOT NULL,
Address Varchar(32) NOT NULL,
State INT,
CONSTRAINT fk_StateOfEmployee FOREIGN KEY (State) REFERENCES
State(StID)
);

INSERT INTO Branches
VALUES
(1, 'Kathmandu', 'New Road', 1);

CREATE TABLE Employee
(
EmpID INT PRIMARY KEY,
Name Varchar (32) NOT NULL,
Address Varchar (32) NOT NULL,
Branch INT NOT NULL,
Designation Varchar(32) NOT NULL,
Email Varchar (16) NOT NULL,
Tel Varchar (16) NOT NULL,
Ext INT,
CONSTRAINT fk_Branch FOREIGN KEY (Branch) REFERENCES
Branches(BrID)
);
/* 12.1 Insert data into Employee table */
INSERT INTO Employee
VALUES
(1, 'Diwan Adhikari', '123 Main St', 1, 'Sales Executive', 'theone@yahoo.com', '01-4215254',101);




CREATE TABLE Transactions(
TsID INT PRIMARY KEY,
BookingDate DATETIME,
DepartureDate DATETIME,
Passenger INT,
Flight_Schedule INT,
Type BIT,
Employee INT,
Charges INT,
Discount INT,
CONSTRAINT fk_Passenger FOREIGN KEY (Passenger) REFERENCES Passengers(PsID),
CONSTRAINT fk_Flight FOREIGN KEY (Flight_Schedule) REFERENCES Flight_Schedule(FIID),
CONSTRAINT fk_Employee FOREIGN KEY (Employee) REFERENCES Employee(EmpID),
CONSTRAINT fk_Charges FOREIGN KEY (Charges) REFERENCES Charges(ChID),
CONSTRAINT fk_Discount FOREIGN KEY (Discount) REFERENCES Discounts(DiID)
);


INSERT INTO Transactions
VALUES
(1, '2011-11-12', '2011-12-21', 1, 1, 0, 1, NULL, NULL);


