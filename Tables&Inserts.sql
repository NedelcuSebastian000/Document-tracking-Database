use lefti_nedelcuflorin;
DROP TABLE IF EXISTS Document_Locations;
DROP TABLE IF EXISTS Documents_to_be_Destroyed;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Roles;
DROP TABLE IF EXISTS All_Documents;
DROP TABLE IF EXISTS Ref_Documents_Type;
DROP TABLE IF EXISTS Ref_Calendar;
DROP TABLE IF EXISTS Ref_Locations;

CREATE TABLE IF NOT EXISTS Roles(
Role_code INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
Role_Name VARCHAR(100) NOT NULL,
Role_Description VARCHAR(100) default 'No description'
);
CREATE TABLE IF NOT EXISTS Employees(
Employee_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
Employee_Name VARCHAR(100) NOT NULL,
Gender_MFU VARCHAR(10)  DEFAULT 'U',
Date_of_Birth DATE NOT NULL,
Other_Details VARCHAR(100) DEFAULT 'No details',
Role_code INT NOT NULL,
 FOREIGN KEY(Role_code) REFERENCES Roles(Role_code)
 );
 
 
 
 CREATE TABLE IF NOT EXISTS Ref_Locations(
  Location_Code int NOT NULL AUTO_INCREMENT,
  Location_Name varchar(100) NOT NULL,
  Location_Description varchar(100) NOT NULL DEFAULT 'No description',
  PRIMARY KEY (Location_Code)
);

CREATE TABLE IF NOT EXISTS Ref_Documents_Type(
 Document_Type_Code INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
 Document_Type_Name VARCHAR(100) NOT NULL,
 Document_Type_Description VARCHAR(100) DEFAULT 'No description'
 );
 
  CREATE TABLE IF NOT EXISTS Ref_Calendar(
 Calendar_Date DATE NOT NULL PRIMARY KEY,
 Day_Number INT NOT NULL);
 
 CREATE TABLE IF NOT EXISTS All_Documents(
 Document_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
 Date_Stored DATE NOT NULL, 
 Document_Type_Code INT NOT NULL,
 Document_Name VARCHAR(100) NOT NULL,
 Document_Description VARCHAR(100) NOT NULL DEFAULT 'No description',
 Other_Details VARCHAR(100) DEFAULT 'No other details',
 FOREIGN KEY(Date_Stored) REFERENCES Ref_Calendar(Calendar_Date),
 FOREIGN KEY(Document_Type_Code) REFERENCES Ref_Documents_Type(Document_Type_Code)
 );
 

 
 CREATE TABLE IF NOT EXISTS Documents_to_be_Destroyed(
 Document_ID INT NOT NULL primary key,
 Destruction_Authorised_by_Employee_ID int NOT NULL,
 Destroyed_by_Employee_ID int NOT NULL,
 Planned_Destruction_Date DATE NOT NULL,
 Actual_Destruction_Date DATE NOT NULL,
 FOREIGN KEY(Document_ID) REFERENCES All_Documents(Document_ID),
 FOREIGN KEY(Destruction_Authorised_by_Employee_ID) REFERENCES Employees(Employee_ID),
 FOREIGN KEY (Destroyed_by_Employee_ID) REFERENCES Employees(Employee_ID),
 FOREIGN KEY (Planned_Destruction_Date) REFERENCES Ref_Calendar(Calendar_Date),
 FOREIGN KEY ( Actual_Destruction_Date) REFERENCES Ref_Calendar(Calendar_Date),
 Other_Details VARCHAR(100) default 'No other details'
 );
 
 CREATE TABLE IF NOT EXISTS Document_Locations(
 Document_ID INT NOT NULL,
 Location_Code INT NOT NULL ,
 Date_in_Location_From DATE NOT NULL,
 Date_IN_Location_To DATE,
 PRIMARY KEY(Document_ID,Location_Code,Date_in_Location_From),
 FOREIGN KEY (Document_ID) REFERENCES All_Documents(Document_ID),
 FOREIGN KEY(Location_Code) REFERENCES Ref_Locations(Location_Code),
 FOREIGN KEY (Date_in_Location_From) REFERENCES Ref_Calendar(Calendar_Date),
 FOREIGN KEY (Date_in_Location_To) REFERENCES Ref_Calendar(Calendar_Date)
 );
  
 INSERT INTO Roles(Role_Name,Role_Description)
 VALUES
 ('Software Developer','Junior developer'),
 ('Software Developer','Senior developer'),
 ('Manager','Top-level Manager'),
 ('Executive Assistant',default),
 ('CEO','Chief Executive Officer'),
 ('COO','Chief Operating Officer');
 
 INSERT INTO Employees(Role_Code,Employee_Name,Gender_MFU,Date_of_Birth,Other_Details)
 VALUES
 (2,'Mircea Budu','M','2000-06-15','Good communication skill'),
 (1,'Petrica Mora','F','1999-05-11','Good problem solving skills'),
 (3,'Ionela Caruta','F','1990-01-11',default),
 (4,'Marin Manea','M','2001-06-15','Great Leader'),
 (5,'Bogdan Marinca','M','1970-01-13',default),
 (2,'Petrica Doru','M','1999-05-11','Good');
 
 INSERT INTO Ref_Documents_Type(Document_Type_Name,Document_Type_Description)
 VALUES
 ('PDF','job application'),
 ('DOC','Contract'),
 ('PDF',default),
 ('HTML','Site'),
 ('TXT','PASSWORDS'),
 ('TXT','Usernames');
 
 INSERT INTO Ref_Calendar(Calendar_Date,Day_Number)
 VALUES
 ('2022-05-11',1),
 ('2022-05-10',2),
 ('2021-06-11',3),
 ('2021-06-12',4),
 ('2021-09-13',5),
 ('2021-09-03',6),
 ('2022-06-12',7),
 ('2021-06-21',8),
 ('2021-03-01',9),
 ('2021-01-02',10),
 ('2020-01-02',11),
 ('2020-02-03',12),
 ('2022-09-09',13);
 
 
 INSERT INTO Ref_Locations(Location_Name,Location_Description)
 VALUES
 ('B235','Medical Cabinet'),
 ('B123','office unit'),
 ('B354','office unit 2'),
 ('B400','office unit 3'),
 ('B532','office unit 4');
 
 INSERT INTO All_Documents(Date_Stored,Document_Type_Code,Document_Name,Document_Description,Other_Details)
 VALUES
 ('2022-05-10',1,'CV_Mircea_Bravo','Job application for Continental','Other'),
 ('2021-06-11',2,'Contract_Munca_Danescu','Labor Contract',default),
 ('2020-01-02',3,'Project','Fish-Eye','Python'),
 ('2022-05-11',4,'Update','Site','New button on the site'),
 ('2021-01-02',5,'PASSWORDS','Passwords for pcs',default),
 ('2021-01-02',6,'Usernames','Usernames for pcs',default);
 
 INSERT INTO Documents_to_be_Destroyed(Document_ID,Destruction_Authorised_by_Employee_ID,Destroyed_by_Employee_ID,Planned_Destruction_Date, Actual_Destruction_Date)
 VALUES
 (1,1,2,'2021-03-01','2021-01-02'),
 (2,3,4,'2021-01-02','2021-01-02'),
 (3,4,5,'2020-01-02','2020-01-02'),
 (4,5,5,'2021-09-03','2022-05-10'),
 (5,1,5,'2022-05-10','2022-05-11');
 
 INSERT INTO Document_Locations(Document_ID,Location_Code,Date_in_Location_From,Date_in_Location_To)
 VALUES
 (1,2,'2022-05-10',default),
  (2,4,'2021-06-11',default),
  (3,5,'2020-01-02',default),
  (4,1,'2022-05-11','2022-09-09'),
  (5,2,'2020-02-03','2021-01-02');
 
 