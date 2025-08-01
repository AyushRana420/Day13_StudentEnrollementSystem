Create Database CollegeDB;
Use CollegeDB;

Create TABLE Student(
StudentID int PRIMARY KEY,
FullName varchar(100) NOT NULL,
Email varchar(100) Unique NOT NULL,
Age int CHECK(AGE >=18)
);

Create TABLE Instructor(
InstructorID int PRIMARY KEY,
FullName varchar(100),
Email varchar(100) Unique,
);

Create TABLE Course(
courseID int PRIMARY KEY,
CourseName varchar(100),
InstructorID INT,
Foreign KEY (InstructorID) References Instructor( InstructorID)
);

Create TABLE Enrollment(
EnrollmentID int PRIMARY KEY,
StudentID int,
CourseID int,
EnrollmentDate Date Default GETDATE(),
FOREIGN KEY(StudentID) REFERENCES Student(StudentID),
FOREIGN KEY(CourseID) REFERENCES Course(courseID)
);

INSERT INTO Instructor VALUES(1,'Dr. Solanke','Solanke@gmail.com');
INSERT INTO Instructor VALUES(2,'Prof Sharma','Sharma@gmail.com');

INSERT INTO Course VALUES(101,'Data Science',1);
INSERT INTO Course VALUES(102,'.NET FSD with Azure Cloud',2);

INSERT INTO Student VALUES(1,'Nandani','ayushrana419@gmail.com',22);
INSERT INTO Student VALUES(2,'Ayush','ayushrana419@gmail.com',21);-- will not accept as email is not unique
INSERT INTO Student VALUES(3,'Shivam','shivam@gmail.com',17); -- will not work as age is less than 18
INSERT INTO Student VALUES(4,'Aditi','aditi@gmail.com',19);

INSERT INTO Enrollment VALUES (1001, 1, 101, GETDATE());
INSERT INTO Enrollment VALUES (1002, 4, 102, GETDATE());
Select * FROM Student;

--GRANT and Revoke for auditor
GRANT SELECT ON Student to auditor;
GRANT SELECT on Enrollment  to auditor;

-- for above to work we have to create login and users
CREATE Login auditor with Password = 'StrongPassword123';
Create User auditor FOR LOGIN auditor;

Revoke SELECT ON Student FROM Auditor; -- for revoking access after some time 

-- Implementing a transaction with commmit and and roll back
BEGIN TRANSACTION;
INSERT INTO Student VALUES(3,'Alex','Alex@HWD.edu',20);
INSERT INTO Enrollment VALUES(1003,3,101,GETDATE());
COMMIT;

-- Rollback
BEGIN Transaction;
INSERT INTO Student VALUES(5,'Angel','Angel@UCLA.UK',19);
RollBACK;
