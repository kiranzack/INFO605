--Hotel(Hotel_ID, Hotel_Name, Hotel_Street, Hotel_State, Hotel_Zip)
--Staff(Staff_ID, Staff_First_Name, Staff_Last_Name, Staff_Salary, Hotel_ID)
--Customer(Customer_ID, Customer_First_Name, Customer_Last_Name)
--Customer_Phone(Customer_ID, Customer_Phone_No)
--Room(Hotel_ID, Room_No, Room_Cost)
--Booking_Info(Booking_ID, Check_In, Check_Out, Room_Type, Customer_ID, Hotel_ID, Room_No)
--Amenities(Amenity_Code, Amenity_Name, Amenity_Cost)
--Amenity_Requests(Booking_ID, Amenity_Code, No_Of_Times)
--Staff_Handles(Staff_ID, Customer_ID);
--_________________________________;

CREATE TABLE Hotel
(
    Hotel_ID CHAR(8),
    Hotel_Name VARCHAR(50) CONSTRAINT Hotel_nm_nn NOT NULL UNIQUE,
    Hotel_Street VARCHAR(50) CONSTRAINT Hotel_str_nn NOT NULL,
    Hotel_State CHAR(2) CONSTRAINT Hotel_st_nn NOT NULL,
    Hotel_Zip CHAR(5) CONSTRAINT Hotel_zip_nn NOT NULL,
    CONSTRAINT Hotel_pk PRIMARY KEY(Hotel_ID)
);

CREATE TABLE Staff
(
    Staff_ID CHAR(8),
    Staff_First_Name VARCHAR(50) CONSTRAINT staff_fn_nn NOT NULL,
    Staff_Last_Name VARCHAR(50) CONSTRAINT staff_ln_nn NOT NULL,
    Staff_Salary NUMBER(10,2) CONSTRAINT staff_sal_nn NOT NULL,
    Hotel_ID CHAR(8) CONSTRAINT Hotel_staff_id_nn NOT NULL,
    CONSTRAINT Staff_pk PRIMARY KEY(Staff_ID),
    CONSTRAINT Hotel_Staff_fk FOREIGN KEY(Hotel_ID) REFERENCES Hotel(Hotel_ID) ON DELETE CASCADE
);

CREATE TABLE Customer
(
    Customer_ID CHAR(8),
    Customer_First_Name VARCHAR(50) CONSTRAINT Customer_fn_nn NOT NULL,
    Customer_Last_Name VARCHAR(50) CONSTRAINT Customer_ln_nn NOT NULL,
    CONSTRAINT Customer_pk PRIMARY KEY(Customer_ID)
);

CREATE TABLE Customer_Phone
(
    Customer_ID CHAR(8),
    Customer_Phone_No CHAR(10) CONSTRAINT Customer_Phone_N_nn_unq NOT NULL UNIQUE,
    CONSTRAINT Customer_Phone_pk PRIMARY KEY(Customer_ID,Customer_Phone_No),
    CONSTRAINT Customer_Phone_fk FOREIGN KEY(Customer_ID) REFERENCES Customer(Customer_ID) ON DELETE CASCADE
);

CREATE TABLE Room
(
    Hotel_ID CHAR(8),
    Room_No CHAR(4),
    Room_Cost NUMBER(10,2) CONSTRAINT Room_cost_nn NOT NULL,
    CONSTRAINT Room_pk PRIMARY KEY(Hotel_ID,Room_No),
    CONSTRAINT Hotel_Room_fk FOREIGN KEY(Hotel_ID) REFERENCES Hotel(Hotel_ID) ON DELETE CASCADE
);

CREATE TABLE Amenities
(
    Amenity_Code CHAR(8),
    Amenity_Name VARCHAR(50) CONSTRAINT Amenity_nm_nn NOT NULL,
    Amenity_Cost NUMBER(10,2) CONSTRAINT Amenity_cost_nn NOT NULL,
    CONSTRAINT Amenity_pk PRIMARY KEY(Amenity_Code)
);

CREATE TABLE Booking_Info
(
    Booking_ID CHAR(8),
    Check_In DATE CONSTRAINT check_in_nn NOT NULL,
    Check_Out DATE CONSTRAINT check_out_nn NOT NULL,
    Room_Type CHAR(1) CONSTRAINT room_type_nchk NOT NULL CHECK (Room_Type IN ('H','D')),
    Room_Time NUMBER(10,0) DEFAULT 24 CONSTRAINT room_time_nn NOT NULL,
    Customer_ID CHAR(8) CONSTRAINT cust_book_nn NOT NULL,
    Hotel_ID CHAR(8) CONSTRAINT hotel_book_nn NOT NULL,
    Room_No CHAR(4) CONSTRAINT room_book_nn NOT NULL,
    CONSTRAINT booking_pk PRIMARY KEY(Booking_ID),
    CONSTRAINT Customer_Booking_fk FOREIGN KEY(Customer_ID) REFERENCES Customer(Customer_ID) ON DELETE CASCADE,
    CONSTRAINT Hotel_Room_Booking_fk FOREIGN KEY(Hotel_ID, Room_No) REFERENCES Room(Hotel_ID, Room_No) ON DELETE CASCADE
);

CREATE TABLE Amenity_Requests
(
    Booking_ID CHAR(8) CONSTRAINT Booking_Request_id NOT NULL,
    Amenity_Code CHAR(8) CONSTRAINT Amenity_Request_code NOT NULL,
    No_Of_Times NUMBER(10,0) CONSTRAINT No_Of_Times_null NOT NULL,
    CONSTRAINT Amenity_Booking_Request_pk PRIMARY KEY(Booking_ID,Amenity_Code),
    CONSTRAINT Booking_Request_fk FOREIGN KEY(Booking_ID) REFERENCES Booking_Info(Booking_ID) ON DELETE CASCADE,
    CONSTRAINT Amenity_Request_fk FOREIGN KEY(Amenity_Code) REFERENCES Amenities(Amenity_Code) ON DELETE CASCADE
);

CREATE TABLE Staff_Handles
(
    Staff_ID CHAR(8) CONSTRAINT Staff_Handle_null NOT NULL,
    Customer_ID CHAR(8) CONSTRAINT Customer_Handle_null NOT NULL,
    CONSTRAINT Staff_Customer_Handle_pk PRIMARY KEY(Staff_ID,Customer_ID),
    CONSTRAINT Staff_Handle_fk FOREIGN KEY(Staff_ID) REFERENCES Staff(Staff_ID) ON DELETE CASCADE,
    CONSTRAINT Customer_Handle_fk FOREIGN KEY(Customer_ID) REFERENCES Customer(Customer_ID) ON DELETE CASCADE
);

-- Hotel(Hotel_ID, Hotel_Name, Hotel_Street, Hotel_State, Hotel_Zip)
--1
INSERT INTO Hotel(Hotel_ID, Hotel_Name, Hotel_Street, Hotel_State, Hotel_Zip) VALUES ('11111111','Hotel_1','Street1','VA','11111');
--2
INSERT INTO Hotel(Hotel_ID, Hotel_Name, Hotel_Street, Hotel_State, Hotel_Zip) VALUES ('11111112','Hotel_2','Street2','PA','11112');
--3
INSERT INTO Hotel(Hotel_ID, Hotel_Name, Hotel_Street, Hotel_State, Hotel_Zip) VALUES ('11111113','Hotel_3','Street3','VA','11113');
SELECT * FROM Hotel;

--Staff(Staff_ID, Staff_First_Name, Staff_Last_Name, Staff_Salary, Hotel_ID)
--1
INSERT INTO Staff(Staff_ID, Staff_First_Name, Staff_Last_Name, Staff_Salary, Hotel_ID) VALUES ('E1111111','FStaffone','LStaffone',407.00,'11111111');
--2
INSERT INTO Staff(Staff_ID, Staff_First_Name, Staff_Last_Name, Staff_Salary, Hotel_ID) VALUES ('E1111112','FStafftwo','LStafftwo',207.00,'11111111');
--3
INSERT INTO Staff(Staff_ID, Staff_First_Name, Staff_Last_Name, Staff_Salary, Hotel_ID) VALUES ('E1111113','FStaffthree','LStaffthree',77.00,'11111111');
--4
INSERT INTO Staff(Staff_ID, Staff_First_Name, Staff_Last_Name, Staff_Salary, Hotel_ID) VALUES ('E2111111','FNextone','LNextone',107.00,'11111112');
--5
INSERT INTO Staff(Staff_ID, Staff_First_Name, Staff_Last_Name, Staff_Salary, Hotel_ID) VALUES ('E3111111','FLastone','LLastone',307.00,'11111113');
--Show Staff Table
SELECT * FROM Staff;

--Customer(Customer_ID, Customer_First_Name, Customer_Last_Name)
--1
INSERT INTO Customer(Customer_ID, Customer_First_Name, Customer_Last_Name) VALUES ('C1111111', 'CustOne', 'OneLast');
--2
INSERT INTO Customer(Customer_ID, Customer_First_Name, Customer_Last_Name) VALUES ('C1111112', 'CustTwo', 'TwoLast');
--3
INSERT INTO Customer(Customer_ID, Customer_First_Name, Customer_Last_Name) VALUES ('C1111113', 'ThreeCust', 'ThreeCust');
--Show Customer Table
SELECT * FROM Customer;

--Hotel(Hotel_ID, Hotel_Name, Hotel_Street, Hotel_State, Hotel_Zip)
--Staff(Staff_ID, Staff_First_Name, Staff_Last_Name, Staff_Salary, Hotel_ID)
--Customer(Customer_ID, Customer_First_Name, Customer_Last_Name)
--Customer_Phone(Customer_ID, Customer_Phone_No)
--Room(Hotel_ID, Room_No, Room_Cost)
--Booking_Info(Booking_ID, Check_In, Check_Out, Room_Type, Customer_ID, Hotel_ID, Room_No)
--Amenities(Amenity_Code, Amenity_Name, Amenity_Cost)
--Amenity_Requests(Booking_ID, Amenity_Code, No_Of_Times)
--Staff_Handles(Staff_ID, Customer_ID);
--_________________________________;

CREATE TABLE Hotel
(
    Hotel_ID CHAR(8) CONSTRAINT Hotel_id_nn NOT NULL,
    Hotel_Name VARCHAR(50) CONSTRAINT Hotel_nm_nn NOT NULL UNIQUE,
    Hotel_Street VARCHAR(50) CONSTRAINT Hotel_str_nn NOT NULL,
    Hotel_State CHAR(2) CONSTRAINT Hotel_st_nn NOT NULL,
    Hotel_Zip CHAR(5) CONSTRAINT Hotel_zip_nn NOT NULL,
    CONSTRAINT Hotel_pk PRIMARY KEY(Hotel_ID)
);

CREATE TABLE Staff
(
    Staff_ID CHAR(8) CONSTRAINT staff_id_nn NOT NULL,
    Staff_First_Name VARCHAR(50) CONSTRAINT staff_fn_nn NOT NULL,
    Staff_Last_Name VARCHAR(50) CONSTRAINT staff_ln_nn NOT NULL,
    Staff_Salary NUMBER(10,2) CONSTRAINT staff_sal_nn NOT NULL,
    Hotel_ID CHAR(8) CONSTRAINT Hotel_staff_id_nn NOT NULL,
    CONSTRAINT Staff_pk PRIMARY KEY(Staff_ID),
    CONSTRAINT Hotel_Staff_fk FOREIGN KEY(Hotel_ID) REFERENCES Hotel(Hotel_ID) ON DELETE CASCADE
);

CREATE TABLE Customer
(
    Customer_ID CHAR(8) CONSTRAINT Customer_id_nn NOT NULL,
    Customer_First_Name VARCHAR(50) CONSTRAINT Customer_fn_nn NOT NULL,
    Customer_Last_Name VARCHAR(50) CONSTRAINT Customer_ln_nn NOT NULL,
    CONSTRAINT Customer_pk PRIMARY KEY(Customer_ID)
);

CREATE TABLE Customer_Phone
(
    Customer_ID CHAR(8) CONSTRAINT customer_phn_id_nn NOT NULL,
    Customer_Phone_No CHAR(10) CONSTRAINT Customer_Phone_N_nn_unq NOT NULL UNIQUE,
    CONSTRAINT Customer_Phone_pk PRIMARY KEY(Customer_ID,Customer_Phone_No),
    CONSTRAINT Customer_Phone_fk FOREIGN KEY(Customer_ID) REFERENCES Customer(Customer_ID) ON DELETE CASCADE
);

CREATE TABLE Room
(
    Hotel_ID CHAR(8) CONSTRAINT Hotel_Room_nn NOT NULL,
    Room_No CHAR(4) CONSTRAINT Room_no_nn NOT NULL,
    Room_Cost NUMBER(10,2) CONSTRAINT Room_cost_nn NOT NULL,
    CONSTRAINT Room_pk PRIMARY KEY(Hotel_ID,Room_No),
    CONSTRAINT Hotel_Room_fk FOREIGN KEY(Hotel_ID) REFERENCES Hotel(Hotel_ID) ON DELETE CASCADE
);

CREATE TABLE Amenities
(
    Amenity_Code CHAR(8) CONSTRAINT Amenity_code_nn NOT NULL,
    Amenity_Name VARCHAR(50) CONSTRAINT Amenity_nm_nn NOT NULL,
    Amenity_Cost NUMBER(10,2) CONSTRAINT Amenity_cost_nn NOT NULL,
    CONSTRAINT Amenity_pk PRIMARY KEY(Amenity_Code)
);

CREATE TABLE Booking_Info
(
    Booking_ID CHAR(8) CONSTRAINT booking_nn NOT NULL,
    Check_In DATE CONSTRAINT check_in_nn NOT NULL,
    Check_Out DATE CONSTRAINT check_out_nn NOT NULL,
    Room_Type CHAR(1) CONSTRAINT room_type_nchk NOT NULL CHECK (Room_Type IN ('H','D')),
    Room_Time NUMBER(10,0) DEFAULT 24 CONSTRAINT room_time_nn NOT NULL,
    Customer_ID CHAR(8) CONSTRAINT cust_book_nn NOT NULL,
    Hotel_ID CHAR(8) CONSTRAINT hotel_book_nn NOT NULL,
    Room_No CHAR(4) CONSTRAINT room_book_nn NOT NULL,
    CONSTRAINT booking_pk PRIMARY KEY(Booking_ID),
    CONSTRAINT Customer_Booking_fk FOREIGN KEY(Customer_ID) REFERENCES Customer(Customer_ID) ON DELETE CASCADE,
    CONSTRAINT Hotel_Room_Booking_fk FOREIGN KEY(Hotel_ID, Room_No) REFERENCES Room(Hotel_ID, Room_No) ON DELETE CASCADE
);

CREATE TABLE Amenity_Requests
(
    Booking_ID CHAR(8) CONSTRAINT Booking_Request_id NOT NULL,
    Amenity_Code CHAR(8) CONSTRAINT Amenity_Request_code NOT NULL,
    No_Of_Times NUMBER(10,0) CONSTRAINT No_Of_Times_null NOT NULL,
    CONSTRAINT Amenity_Booking_Request_pk PRIMARY KEY(Booking_ID,Amenity_Code),
    CONSTRAINT Booking_Request_fk FOREIGN KEY(Booking_ID) REFERENCES Booking_Info(Booking_ID) ON DELETE CASCADE,
    CONSTRAINT Amenity_Request_fk FOREIGN KEY(Amenity_Code) REFERENCES Amenities(Amenity_Code) ON DELETE CASCADE
);

CREATE TABLE Staff_Handles
(
    Staff_ID CHAR(8) CONSTRAINT Staff_Handle_null NOT NULL,
    Customer_ID CHAR(8) CONSTRAINT Customer_Handle_null NOT NULL,
    CONSTRAINT Staff_Customer_Handle_pk PRIMARY KEY(Staff_ID,Customer_ID),
    CONSTRAINT Staff_Handle_fk FOREIGN KEY(Staff_ID) REFERENCES Staff(Staff_ID) ON DELETE CASCADE,
    CONSTRAINT Customer_Handle_fk FOREIGN KEY(Customer_ID) REFERENCES Customer(Customer_ID) ON DELETE CASCADE
);

-- Hotel(Hotel_ID, Hotel_Name, Hotel_Street, Hotel_State, Hotel_Zip)
--1
INSERT INTO Hotel(Hotel_ID, Hotel_Name, Hotel_Street, Hotel_State, Hotel_Zip) VALUES ('11111111','Hotel_1','Street1','VA','11111');
--2
INSERT INTO Hotel(Hotel_ID, Hotel_Name, Hotel_Street, Hotel_State, Hotel_Zip) VALUES ('11111112','Hotel_2','Street2','PA','11112');
--3
INSERT INTO Hotel(Hotel_ID, Hotel_Name, Hotel_Street, Hotel_State, Hotel_Zip) VALUES ('11111113','Hotel_3','Street3','VA','11113');
SELECT * FROM Hotel;

--Staff(Staff_ID, Staff_First_Name, Staff_Last_Name, Staff_Salary, Hotel_ID)
--1
INSERT INTO Staff(Staff_ID, Staff_First_Name, Staff_Last_Name, Staff_Salary, Hotel_ID) VALUES ('E1111111','FStaffone','LStaffone',407.00,'11111111');
--2
INSERT INTO Staff(Staff_ID, Staff_First_Name, Staff_Last_Name, Staff_Salary, Hotel_ID) VALUES ('E1111112','FStafftwo','LStafftwo',207.00,'11111111');
--3
INSERT INTO Staff(Staff_ID, Staff_First_Name, Staff_Last_Name, Staff_Salary, Hotel_ID) VALUES ('E1111113','FStaffthree','LStaffthree',77.00,'11111111');
--4
INSERT INTO Staff(Staff_ID, Staff_First_Name, Staff_Last_Name, Staff_Salary, Hotel_ID) VALUES ('E2111111','FNextone','LNextone',107.00,'11111112');
--5
INSERT INTO Staff(Staff_ID, Staff_First_Name, Staff_Last_Name, Staff_Salary, Hotel_ID) VALUES ('E3111111','FLastone','LLastone',307.00,'11111113');
--Show Staff Table
SELECT * FROM Staff;

--Customer(Customer_ID, Customer_First_Name, Customer_Last_Name)
--1
INSERT INTO Customer(Customer_ID, Customer_First_Name, Customer_Last_Name) VALUES ('C1111111', 'CustOne', 'OneLast');
--2
INSERT INTO Customer(Customer_ID, Customer_First_Name, Customer_Last_Name) VALUES ('C1111112', 'CustTwo', 'TwoLast');
--3
INSERT INTO Customer(Customer_ID, Customer_First_Name, Customer_Last_Name) VALUES ('C1111113', 'ThreeCust', 'ThreeCust');
--Show Customer Table
SELECT * FROM Customer;

--Customer_Phone(Customer_ID, Customer_Phone_No)
--1
INSERT INTO Customer_Phone(Customer_ID, Customer_Phone_No) VALUES ('C1111111','1213441245');
--2
INSERT INTO Customer_Phone(Customer_ID, Customer_Phone_No) VALUES ('C1111111','1213441246');
--3
INSERT INTO Customer_Phone(Customer_ID, Customer_Phone_No) VALUES ('C1111112','2213441245');
--4
INSERT INTO Customer_Phone(Customer_ID, Customer_Phone_No) VALUES ('C1111113','1213341245');
--Show Customer_Phone Table
SELECT * FROM Customer_Phone;

--Room(Hotel_ID, Room_No, Room_Cost)
--1
INSERT INTO Room(Hotel_ID, Room_No, Room_Cost) VALUES ('11111111', 'A111', 1500.56);
--2
INSERT INTO Room(Hotel_ID, Room_No, Room_Cost) VALUES ('11111111', 'A211', 1500.56);
--3
INSERT INTO Room(Hotel_ID, Room_No, Room_Cost) VALUES ('11111111', 'A311', 1500.56);
--4
INSERT INTO Room(Hotel_ID, Room_No, Room_Cost) VALUES ('11111112', 'A111', 2500.56);
--5
INSERT INTO Room(Hotel_ID, Room_No, Room_Cost) VALUES ('11111113', 'A111', 6000.00);
--Show Room Table
SELECT * FROM Room;

--Amenities(Amenity_Code, Amenity_Name, Amenity_Cost)
--1
INSERT INTO Amenities(Amenity_Code, Amenity_Name, Amenity_Cost) VALUES ('A1111111', 'Dry Cleaning', 12.00);
--2
INSERT INTO Amenities(Amenity_Code, Amenity_Name, Amenity_Cost) VALUES ('A1111112', 'Gym', 3.00);
--3
INSERT INTO Amenities(Amenity_Code, Amenity_Name, Amenity_Cost) VALUES ('A1111113', 'Laundry', 4.00);
--Show Amenities Table
SELECT * FROM Amenities;

--Booking_Info(Booking_ID, Check_In, Check_Out, Room_Type, Room_Time, Customer_ID, Hotel_ID, Room_No)
--1
INSERT INTO Booking_Info(Booking_ID, Check_In, Check_Out, Room_Type, Room_Time, Customer_ID, Hotel_ID, Room_No) VALUES ('B1111111', '13-MAY-2020', '13-MAY-2020', 'H', '14', 'C1111111', '11111111', 'A111');
--2
INSERT INTO Booking_Info(Booking_ID, Check_In, Check_Out, Room_Type, Customer_ID, Hotel_ID, Room_No) VALUES ('B1111112', '14-MAY-2020', '23-MAY-2020', 'D', 'C1111111', '11111111', 'A111');
--3
INSERT INTO Booking_Info(Booking_ID, Check_In, Check_Out, Room_Type, Customer_ID, Hotel_ID, Room_No) VALUES ('B1111113', '13-MAY-2020', '19-MAY-2020', 'D', 'C1111112', '11111111', 'A211');
--4
INSERT INTO Booking_Info(Booking_ID, Check_In, Check_Out, Room_Type, Customer_ID, Hotel_ID, Room_No) VALUES ('B1111114', '1-MAY-2020', '15-MAY-2020', 'D', 'C1111113', '11111111', 'A311');
--5
INSERT INTO Booking_Info(Booking_ID, Check_In, Check_Out, Room_Type, Room_Time, Customer_ID, Hotel_ID, Room_No) VALUES ('B1111115', '16-MAY-2020', '01-JUNE-2020', 'H', '14', 'C1111111', '11111113', 'A111');
--6
INSERT INTO Booking_Info(Booking_ID, Check_In, Check_Out, Room_Type, Room_Time, Customer_ID, Hotel_ID, Room_No) VALUES ('B1111116', '16-MAY-2020', '01-MAY-2020', 'H', '14', 'C1111111', '11111111', 'A211');
--7
INSERT INTO Booking_Info(Booking_ID, Check_In, Check_Out, Room_Type, Room_Time, Customer_ID, Hotel_ID, Room_No) VALUES ('B1111117', '16-MAY-2020', '16-MAY-2020', 'H', '14', 'C1111113', '11111111', 'A111');
--Show Booking_Info Table
SELECT * FROM Booking_Info;

--Amenity_Requests(Booking_ID, Amenity_Code, No_Of_Times)
--1
INSERT INTO Amenity_Requests(Booking_ID, Amenity_Code, No_Of_Times) VALUES ('B1111112','A1111113', 3);
--2
INSERT INTO Amenity_Requests(Booking_ID, Amenity_Code, No_Of_Times) VALUES ('B1111111','A1111112', 1);
--3
INSERT INTO Amenity_Requests(Booking_ID, Amenity_Code, No_Of_Times) VALUES ('B1111114','A1111111', 1);
--4
INSERT INTO Amenity_Requests(Booking_ID, Amenity_Code, No_Of_Times) VALUES ('B1111115','A1111111', 2);
--5
INSERT INTO Amenity_Requests(Booking_ID, Amenity_Code, No_Of_Times) VALUES ('B1111113','A1111111', 1);
--6
INSERT INTO Amenity_Requests(Booking_ID, Amenity_Code, No_Of_Times) VALUES ('B1111112','A1111112', 1);
--7
INSERT INTO Amenity_Requests(Booking_ID, Amenity_Code, No_Of_Times) VALUES ('B1111112','A1111111', 1);
--Show Amenity_Requests Table
SELECT * FROM Amenity_Requests;

--Staff_Handles(Staff_ID, Customer_ID)
--1
INSERT INTO Staff_Handles(Staff_ID, Customer_ID) VALUES ('E1111112', 'C1111111');
--2
INSERT INTO Staff_Handles(Staff_ID, Customer_ID) VALUES ('E1111111', 'C1111111');
--3
INSERT INTO Staff_Handles(Staff_ID, Customer_ID) VALUES ('E2111111', 'C1111112');
--4
INSERT INTO Staff_Handles(Staff_ID, Customer_ID) VALUES ('E3111111', 'C1111113');
--5
INSERT INTO Staff_Handles(Staff_ID, Customer_ID) VALUES ('E1111113', 'C1111111');
--6
INSERT INTO Staff_Handles(Staff_ID, Customer_ID) VALUES ('E1111111', 'C1111112');
--Show Staff_Handles Table
SELECT * FROM Staff_Handles;

--Change customer id is 'C1111113' First name to Alpha and Last name to Beta.
UPDATE Customer
SET Customer_First_Name = 'Alpha', Customer_Last_Name = 'Beta'
WHERE Customer_id = 'C1111113';
--Show Updated Customer Table
SELECT * FROM Customer;

--Delete the record for booking information where check in date is before check out date
DELETE FROM Booking_Info
WHERE Check_in > Check_Out;
--Show Booking_Info Table after deletion
SELECT * FROM Booking_Info;

--Set the room type to 'D' when check-in date is not same as check-out date
UPDATE Booking_Info
SET Room_Type = 'D'
WHERE Check_in != Check_Out;
--Show Updated Booking_Info Table
SELECT * FROM Booking_Info;

--1.) Show all first name, last name and phone numbers of customers 
SELECT C.Customer_First_Name, C.Customer_Last_Name, P.Customer_Phone_No
FROM Customer C
    JOIN Customer_Phone P ON C.Customer_id = P.Customer_id;


--2.) Show the total cost of the amenities requested for each booking ordered according to the booking id
SELECT AR.Booking_ID, SUM(A.amenity_cost * AR.no_of_times ) AS Amenity_Cost_Total
FROM Amenities A 
    JOIN Amenity_Requests AR ON A.Amenity_Code = AR.Amenity_Code
GROUP BY AR.Booking_ID
ORDER BY AR.Booking_ID;

--3.) Show all staff information whose first name contains 'one' in lowercase 
SELECT * 
FROM Staff 
WHERE Staff_First_Name LIKE '%one%';

--4.) Show the customer, id, first name, last name and count of bookings of customers who has more than one booking done at the hotel chains
SELECT B.Customer_Id,C.Customer_First_Name,C.Customer_Last_Name, COUNT(B.Booking_id) AS Cust_Booking_Count
FROM Booking_Info B 
    JOIN Customer C ON B.Customer_id = C.Customer_id
GROUP BY B.Customer_Id,C.Customer_First_Name,C.Customer_Last_Name
HAVING COUNT(B.Booking_id)>1;

--5.) Shows the total amenity cost, room cost and the total booking cost of a booking 
SELECT B.Booking_Id,(A.Amenity_Cost*AR.No_Of_Times) AS "Total Amenity Cost", CASE WHEN B.Room_Type = 'D' THEN ROUND(((B.Check_Out-B.Check_In)*R.Room_Cost),2) WHEN B.Room_Type = 'H' THEN ROUND(((B.Room_Time)*(R.Room_Cost/24)),2) END AS "Total Room Cost",  CASE WHEN B.Room_Type = 'D' THEN ROUND(((B.Check_Out-B.Check_In)*R.Room_Cost),2)+(A.Amenity_Cost*AR.No_Of_Times)  WHEN B.Room_Type = 'H' THEN ROUND(((B.Room_Time)*(R.Room_Cost/24)),2)+(A.Amenity_Cost*AR.No_Of_Times) END AS "Total Booking Cost"
FROM Room R, Booking_Info B, Amenity_Requests AR,Amenities A
WHERE R.Hotel_Id = B.Hotel_Id AND R.Room_No = B.Room_No AND B.Booking_ID = AR.Booking_ID AND AR.Amenity_Code = A.Amenity_Code;

--6.) Show the staff's first name, last name, salary, comission(salary*0.05*number of customers handled) and total salary due which is the sum of salary and commision
SELECT S.Staff_Id, S.Staff_First_Name, S.Staff_Last_Name, S.Staff_Salary, ROUND(S.Staff_Salary*0.05*COUNT(SH.Customer_Id),2) AS Commision, ROUND(S.Staff_Salary*0.05*COUNT(SH.Customer_Id),2)+S.Staff_Salary AS "Total Salary"
FROM Staff S, Staff_Handles SH
WHERE S.Staff_Id = SH.Staff_Id
GROUP BY S.Staff_Id, S.Staff_First_Name, S.Staff_Last_Name, S.Staff_Salary;

--7.) Show the staff's first name, last name and salary of the staffs that make more than the average salary ordered according to their salary
SELECT Staff_First_Name,Staff_Last_Name, Staff_Salary
FROM Staff
WHERE Staff_Salary < (SELECT AVG(Staff_Salary)
                FROM Staff)
ORDER BY Staff_Salary DESC;




--DROP TABLE Staff_Handles CASCADE CONSTRAINTS;
--DROP TABLE Amenity_Requests CASCADE CONSTRAINTS;
--DROP TABLE Booking_Info CASCADE CONSTRAINTS;
--DROP TABLE Amenities CASCADE CONSTRAINTS;
--DROP TABLE Room CASCADE CONSTRAINTS;
--DROP TABLE Customer_Phone CASCADE CONSTRAINTS;
--DROP TABLE Customer CASCADE CONSTRAINTS;
--DROP TABLE Staff CASCADE CONSTRAINTS;
--DROP TABLE Hotel CASCADE CONSTRAINTS;


DELETE FROM Booking_Info
WHERE Check_in > Check_Out;
--Show Booking_Info Table after deletion
SELECT * FROM Booking_Info;
--Customer_Phone(Customer_ID, Customer_Phone_No)
--1
INSERT INTO Customer_Phone(Customer_ID, Customer_Phone_No) VALUES ('C1111111','1213441245');
--2
INSERT INTO Customer_Phone(Customer_ID, Customer_Phone_No) VALUES ('C1111111','1213441246');
--3
INSERT INTO Customer_Phone(Customer_ID, Customer_Phone_No) VALUES ('C1111112','2213441245');
--4
INSERT INTO Customer_Phone(Customer_ID, Customer_Phone_No) VALUES ('C1111113','1213341245');
--Show Customer_Phone Table
SELECT * FROM Customer_Phone;

--Room(Hotel_ID, Room_No, Room_Cost)
--1
INSERT INTO Room(Hotel_ID, Room_No, Room_Cost) VALUES ('11111111', 'A111', 1500.56);
--2
INSERT INTO Room(Hotel_ID, Room_No, Room_Cost) VALUES ('11111111', 'A211', 1500.56);
--3
INSERT INTO Room(Hotel_ID, Room_No, Room_Cost) VALUES ('11111111', 'A311', 1500.56);
--4
INSERT INTO Room(Hotel_ID, Room_No, Room_Cost) VALUES ('11111112', 'A111', 2500.56);
--5
INSERT INTO Room(Hotel_ID, Room_No, Room_Cost) VALUES ('11111113', 'A111', 6000.00);
--Show Room Table
SELECT * FROM Room;

--Amenities(Amenity_Code, Amenity_Name, Amenity_Cost)
--1
INSERT INTO Amenities(Amenity_Code, Amenity_Name, Amenity_Cost) VALUES ('A1111111', 'Dry Cleaning', 12.00);
--2
INSERT INTO Amenities(Amenity_Code, Amenity_Name, Amenity_Cost) VALUES ('A1111112', 'Gym', 3.00);
--3
INSERT INTO Amenities(Amenity_Code, Amenity_Name, Amenity_Cost) VALUES ('A1111113', 'Laundry', 4.00);
--Show Amenities Table
SELECT * FROM Amenities;

--Booking_Info(Booking_ID, Check_In, Check_Out, Room_Type, Room_Time, Customer_ID, Hotel_ID, Room_No)
--1
INSERT INTO Booking_Info(Booking_ID, Check_In, Check_Out, Room_Type, Room_Time, Customer_ID, Hotel_ID, Room_No) VALUES ('B1111111', '13-MAY-2020', '13-MAY-2020', 'H', '14', 'C1111111', '11111111', 'A111');
--2
INSERT INTO Booking_Info(Booking_ID, Check_In, Check_Out, Room_Type, Customer_ID, Hotel_ID, Room_No) VALUES ('B1111112', '14-MAY-2020', '23-MAY-2020', 'D', 'C1111111', '11111111', 'A111');
--3
INSERT INTO Booking_Info(Booking_ID, Check_In, Check_Out, Room_Type, Customer_ID, Hotel_ID, Room_No) VALUES ('B1111113', '13-MAY-2020', '19-MAY-2020', 'D', 'C1111112', '11111111', 'A211');
--4
INSERT INTO Booking_Info(Booking_ID, Check_In, Check_Out, Room_Type, Customer_ID, Hotel_ID, Room_No) VALUES ('B1111114', '1-MAY-2020', '15-MAY-2020', 'D', 'C1111113', '11111111', 'A311');
--5
INSERT INTO Booking_Info(Booking_ID, Check_In, Check_Out, Room_Type, Room_Time, Customer_ID, Hotel_ID, Room_No) VALUES ('B1111115', '16-MAY-2020', '01-JUNE-2020', 'H', '14', 'C1111111', '11111113', 'A111');
--6
INSERT INTO Booking_Info(Booking_ID, Check_In, Check_Out, Room_Type, Room_Time, Customer_ID, Hotel_ID, Room_No) VALUES ('B1111116', '16-MAY-2020', '01-MAY-2020', 'H', '14', 'C1111111', '11111111', 'A211');
--7
INSERT INTO Booking_Info(Booking_ID, Check_In, Check_Out, Room_Type, Room_Time, Customer_ID, Hotel_ID, Room_No) VALUES ('B1111117', '16-MAY-2020', '16-MAY-2020', 'H', '14', 'C1111113', '11111111', 'A111');
--Show Booking_Info Table
SELECT * FROM Booking_Info;

--Amenity_Requests(Booking_ID, Amenity_Code, No_Of_Times)
--1
INSERT INTO Amenity_Requests(Booking_ID, Amenity_Code, No_Of_Times) VALUES ('B1111112','A1111113', 3);
--2
INSERT INTO Amenity_Requests(Booking_ID, Amenity_Code, No_Of_Times) VALUES ('B1111111','A1111112', 1);
--3
INSERT INTO Amenity_Requests(Booking_ID, Amenity_Code, No_Of_Times) VALUES ('B1111114','A1111111', 1);
--4
INSERT INTO Amenity_Requests(Booking_ID, Amenity_Code, No_Of_Times) VALUES ('B1111115','A1111111', 2);
--5
INSERT INTO Amenity_Requests(Booking_ID, Amenity_Code, No_Of_Times) VALUES ('B1111113','A1111111', 1);
--6
INSERT INTO Amenity_Requests(Booking_ID, Amenity_Code, No_Of_Times) VALUES ('B1111112','A1111112', 1);
--7
INSERT INTO Amenity_Requests(Booking_ID, Amenity_Code, No_Of_Times) VALUES ('B1111112','A1111111', 1);
--Show Amenity_Requests Table
SELECT * FROM Amenity_Requests;

--Staff_Handles(Staff_ID, Customer_ID)
--1
INSERT INTO Staff_Handles(Staff_ID, Customer_ID) VALUES ('E1111112', 'C1111111');
--2
INSERT INTO Staff_Handles(Staff_ID, Customer_ID) VALUES ('E1111111', 'C1111111');
--3
INSERT INTO Staff_Handles(Staff_ID, Customer_ID) VALUES ('E2111111', 'C1111112');
--4
INSERT INTO Staff_Handles(Staff_ID, Customer_ID) VALUES ('E3111111', 'C1111113');
--5
INSERT INTO Staff_Handles(Staff_ID, Customer_ID) VALUES ('E1111113', 'C1111111');
--6
INSERT INTO Staff_Handles(Staff_ID, Customer_ID) VALUES ('E1111111', 'C1111112');
--Show Staff_Handles Table
SELECT * FROM Staff_Handles;

--Change customer id is 'C1111113' First name to Alpha and Last name to Beta.
UPDATE Customer
SET Customer_First_Name = 'Alpha', Customer_Last_Name = 'Beta'
WHERE Customer_id = 'C1111113';
--Show Updated Customer Table
SELECT * FROM Customer;

--Delete the record for booking information where check in date is before check out date
DELETE FROM Booking_Info
WHERE Check_in > Check_Out;
--Show Booking_Info Table after deletion
SELECT * FROM Booking_Info;

--Set the room type to 'D' when check-in date is not same as check-out date
UPDATE Booking_Info
SET Room_Type = 'D'
WHERE Check_in != Check_Out;
--Show Updated Booking_Info Table
SELECT * FROM Booking_Info;

--1.) Show all first name, last name and phone numbers of customers 
SELECT C.Customer_First_Name, C.Customer_Last_Name, P.Customer_Phone_No
FROM Customer C
    JOIN Customer_Phone P ON C.Customer_id = P.Customer_id;


--2.) Show the total cost of the amenities requested for each booking ordered according to the booking id
SELECT AR.Booking_ID, SUM(A.amenity_cost * AR.no_of_times ) AS Amenity_Cost_Total
FROM Amenities A 
    JOIN Amenity_Requests AR ON A.Amenity_Code = AR.Amenity_Code
GROUP BY AR.Booking_ID
ORDER BY AR.Booking_ID;

--3.) Show all staff information whose first name contains 'one' in lowercase 
SELECT * 
FROM Staff 
WHERE Staff_First_Name LIKE '%one%';

--4.) Show the customer, id, first name, last name and count of bookings of customers who has more than one booking done at the hotel chains
SELECT B.Customer_Id,C.Customer_First_Name,C.Customer_Last_Name, COUNT(B.Booking_id) AS Cust_Booking_Count
FROM Booking_Info B 
    JOIN Customer C ON B.Customer_id = C.Customer_id
GROUP BY B.Customer_Id,C.Customer_First_Name,C.Customer_Last_Name
HAVING COUNT(B.Booking_id)>1;

--5.) Shows the total amenity cost, room cost and the total booking cost of a booking 
SELECT B.Booking_Id,(A.Amenity_Cost*AR.No_Of_Times) AS "Total Amenity Cost", CASE WHEN B.Room_Type = 'D' THEN ROUND(((B.Check_Out-B.Check_In)*R.Room_Cost),2) WHEN B.Room_Type = 'H' THEN ROUND(((B.Room_Time)*(R.Room_Cost/24)),2) END AS "Total Room Cost",  CASE WHEN B.Room_Type = 'D' THEN ROUND(((B.Check_Out-B.Check_In)*R.Room_Cost),2)+(A.Amenity_Cost*AR.No_Of_Times)  WHEN B.Room_Type = 'H' THEN ROUND(((B.Room_Time)*(R.Room_Cost/24)),2)+(A.Amenity_Cost*AR.No_Of_Times) END AS "Total Booking Cost"
FROM Room R, Booking_Info B, Amenity_Requests AR,Amenities A
WHERE R.Hotel_Id = B.Hotel_Id AND R.Room_No = B.Room_No AND B.Booking_ID = AR.Booking_ID AND AR.Amenity_Code = A.Amenity_Code;

--6.) Show the staff's first name, last name, salary, comission(salary*0.05*number of customers handled) and total salary due which is the sum of salary and commision
SELECT S.Staff_Id, S.Staff_First_Name, S.Staff_Last_Name, S.Staff_Salary, ROUND(S.Staff_Salary*0.05*COUNT(SH.Customer_Id),2) AS Commision, ROUND(S.Staff_Salary*0.05*COUNT(SH.Customer_Id),2)+S.Staff_Salary AS "Total Salary"
FROM Staff S, Staff_Handles SH
WHERE S.Staff_Id = SH.Staff_Id
GROUP BY S.Staff_Id, S.Staff_First_Name, S.Staff_Last_Name, S.Staff_Salary;

--7.) Show the staff's first name, last name and salary of the staffs that make more than the average salary ordered according to their salary
SELECT Staff_First_Name,Staff_Last_Name, Staff_Salary
FROM Staff
WHERE Staff_Salary < (SELECT AVG(Staff_Salary)
                FROM Staff)
ORDER BY Staff_Salary DESC;




DROP TABLE Staff_Handles CASCADE CONSTRAINTS;
DROP TABLE Amenity_Requests CASCADE CONSTRAINTS;
DROP TABLE Booking_Info CASCADE CONSTRAINTS;
DROP TABLE Amenities CASCADE CONSTRAINTS;
DROP TABLE Room CASCADE CONSTRAINTS;
DROP TABLE Customer_Phone CASCADE CONSTRAINTS;
DROP TABLE Customer CASCADE CONSTRAINTS;
DROP TABLE Staff CASCADE CONSTRAINTS;
DROP TABLE Hotel CASCADE CONSTRAINTS;

