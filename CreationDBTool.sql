DROP TABLE IF EXISTS Activity;
CREATE TABLE Activity (
    ActivityID text PRIMARY KEY,
    ActivityType text NOT NULL
) WITHOUT ROWID;

INSERT INTO Activity (ActivityID, ActivityType) VALUES
('1',	'A'),
('2',	'B'),
('3',	'C'),
('4',	'D'),
('5',	'E'),
('6',	'F'),
('7',	'G'),
('8',	'H'),
('9',	'I'),
('10',	'J');

DROP TABLE IF EXISTS Employee;
CREATE TABLE Employee (
    EmployeeID text NOT NULL,
    FirstName text NOT NULL,
    LastName text NOT NULL,
    HourlyCost money NOT NULL,
    CONSTRAINT eployee_pk PRIMARY KEY (EmployeeID)
) WITHOUT ROWID;

INSERT INTO Employee (EmployeeID, FirstName, LastName, HourlyCost) VALUES
('E1',	'John',	'Smith',	'$200.23'),
('A2',	'Jane',	'Doe',	'$178.90'),
('G4',	'Bob',	'Smith',	'$199.34'),
('H9',	'Sally',	'Doe',	'$233.33'),
('T3',	'Bobby',	'Kat',	'$155.05'),
('L99',	'Henrik',	'Hansen',	'$199.99'),
('Z1',	'Jens',	'Jensen',	'$320.12'),
('MN8',	'Danny',	'Mathiason',	'$218.15'),
('K2',	'Karl',	'Karlsson',	'$232.90'),
('P1',	'Peter',	'Petersen',	'$250.10');

DROP TABLE IF EXISTS EmployeePlan;
CREATE TABLE EmployeePlan (
    PlanID text NOT NULL,
    EmployeeID text NOT NULL,
    CONSTRAINT EmployeePlan_EmployeeID_PlanID PRIMARY KEY (EmployeeID, PlanID),
    CONSTRAINT EmployeePlan_EmployeeID_fkey FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID) ON DELETE SET NULL NOT DEFERRABLE,
    CONSTRAINT EmployeePlan_PlanID_fkey FOREIGN KEY (PlanID) REFERENCES Plan(PlanID) ON DELETE SET NULL NOT DEFERRABLE
) WITHOUT ROWID;

INSERT INTO EmployeePlan (PlanID, EmployeeID) VALUES
('2',	'A2'),
('3',	'G4'),
('4',	'H9'),
('5',	'T3'),
('6',	'L99'),
('7',	'Z1'),
('8',	'MN8'),
('9',	'K2'),
('10',	'P1'),
('10',	'A2'),
('10',	'MN8'),
('1',	'T3'),
('6',	'H9'),
('5',	'Z1'),
('2',	'E1');

DROP TABLE IF EXISTS EmployeePlanActivity;
CREATE TABLE EmployeePlanActivity (
    PlanID text NOT NULL,
    ActivityID text NOT NULL,
    StartDate date NOT NULL,
    EndDate date NOT NULL,
    EmployeeID text NOT NULL,
    ActivityLength integer DEFAULT '0' NOT NULL,
    CONSTRAINT EmployeePlanActivity_PlanID_ActivityID_EmployeeID PRIMARY KEY (PlanID, ActivityID, EmployeeID),
    CONSTRAINT PlanActivity_ActivityID_fkey FOREIGN KEY (ActivityID) REFERENCES Activity(ActivityID) ON DELETE SET NULL NOT DEFERRABLE;
    CONSTRAINT PlanActivity_EmployeeID_fkey FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID) ON DELETE SET NULL NOT DEFERRABLE;
    CONSTRAINT PlanActivity_PlanID_fkey FOREIGN KEY (PlanID) REFERENCES Plan(PlanID) ON DELETE SET NULL NOT DEFERRABLE;
) WITHOUT ROWID;

INSERT INTO EmployeePlanActivity (PlanID, ActivityID, StartDate, EndDate, EmployeeID, ActivityLength) VALUES
('2',	'3',	'2010-01-02',	'2010-11-30',	'A2',	8),
('3',	'2',	'2010-02-03',	'2011-01-01',	'G4',	8),
('4',	'10',	'2010-09-01',	'2010-10-30',	'H9',	8),
('5',	'1',	'2011-01-01',	'2011-02-02',	'T3',	8),
('6',	'7',	'2010-01-01',	'2011-06-01',	'L99',	8),
('7',	'9',	'2010-04-30',	'2011-04-30',	'Z1',	8),
('8',	'3',	'2010-01-01',	'2010-02-28',	'MN8',	8),
('9',	'4',	'2010-01-10',	'2010-12-31',	'K2',	8),
('10',	'1',	'2011-01-01',	'2011-12-31',	'P1',	8),
('10',	'5',	'2010-06-06',	'2010-12-24',	'A2',	8),
('10',	'1',	'2010-08-01',	'2010-08-31',	'MN8',	8),
('1',	'3',	'2011-01-01',	'2011-04-24',	'T3',	8),
('6',	'9',	'2010-09-01',	'2010-11-30',	'H9',	8),
('5',	'8',	'2009-01-01',	'2011-12-31',	'Z1',	8),
('2',	'1',	'2010-01-01',	'2010-12-31',	'E1',	8);

DROP TABLE IF EXISTS Plan;
CREATE TABLE Plan (
    PlanID text NOT NULL,
    Name text NOT NULL,
    ProjectID text NOT NULL,
    CONSTRAINT PlanID_PK PRIMARY KEY (PlanID),
    CONSTRAINT Plan_ProjectID_fkey FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID) ON DELETE SET NULL NOT DEFERRABLE
) WITHOUT ROWID;

INSERT INTO Plan (PlanID, Name, ProjectID) VALUES
('1',	'A',	'1'),
('2',	'B',	'1'),
('3',	'C',	'2'),
('4',	'D',	'3'),
('5',	'E',	'4'),
('6',	'F',	'6'),
('7',	'F',	'2'),
('8',	'G',	'4'),
('9',	'H',	'10'),
('10',	'I',	'8');

DROP TABLE IF EXISTS Project;
CREATE TABLE Project (
    ProjectID text NOT NULL,
    ProjectName text NOT NULL,
    StartDate date NOT NULL,
    EndDate date NOT NULL,
    LeaderID text NOT NULL,
    Budget money NOT NULL,
    CONSTRAINT project_pk PRIMARY KEY (ProjectID),
    CONSTRAINT Project_LeaderID_fkey FOREIGN KEY (LeaderID) REFERENCES Employee(EmployeeID) ON DELETE SET NULL NOT DEFERRABLE
) WITHOUT ROWID;

INSERT INTO Project (ProjectID, ProjectName, StartDate, EndDate, LeaderID, Budget) VALUES
('1',	'A',	'2010-01-01',	'2010-12-31',	'P1',	'$1,000,000.00'),
('2',	'B',	'2011-01-01',	'2013-01-14',	'H9',	'$2,000,000.00'),
('3',	'C',	'2010-04-12',	'2011-12-31',	'P1',	'$3,500,000.00'),
('4',	'D',	'2013-11-01',	'2014-11-30',	'H9',	'$1,300,000.00'),
('5',	'E',	'2010-01-01',	'2010-06-11',	'P1',	'$4,100,000.00'),
('6',	'F',	'2010-02-01',	'2010-10-13',	'Z1',	'$2,330,000.00'),
('7',	'G',	'2011-01-01',	'2012-12-31',	'K2',	'$1,200,000.00'),
('8',	'H',	'2012-02-02',	'2012-12-31',	'Z1',	'$9,120,000.00'),
('9',	'I',	'2010-06-01',	'2010-12-31',	'H9',	'$2,300,000.00'),
('10',	'J',	'2012-01-01',	'2015-12-31',	'Z1',	'$1,190,000.00');