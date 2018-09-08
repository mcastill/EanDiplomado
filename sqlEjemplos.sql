
declare @nombre varchar(50)= 'mario';
select @nombre;

set @nombre = 'martin';
select @nombre;


DECLARE  @pvt_input TABLE
(
OppositionTeam VARCHAR(100),
Player VARCHAR(100),
Runs INT
);
INSERT INTO @pvt_input VALUES('Delhi Daredevils', 'Rohit Sharma', 50) -- Runs scored by Rohit Sharma against the team 'Delhi Daredevils'
INSERT INTO @pvt_input VALUES('Delhi Daredevils', 'Rohit Sharma', 20) -- Another record for runs scored by Rohit Sharma against the team 'Delhi Daredevils', this will be aggregated when we apply pivot
INSERT INTO @pvt_input VALUES('Delhi Daredevils', 'Bumrah', 40)
INSERT INTO @pvt_input VALUES('Delhi Daredevils', 'Gopal', 70)
INSERT INTO @pvt_input VALUES('Delhi Daredevils', 'McClenaghan', 100)
INSERT INTO @pvt_input VALUES('Delhi Daredevils', 'Harbhajan', 40)
INSERT INTO @pvt_input VALUES('Rajasthan Royals', 'Rohit Sharma', 80)
INSERT INTO @pvt_input VALUES('Rajasthan Royals', 'Bumrah', 50)
INSERT INTO @pvt_input VALUES('Rajasthan Royals', 'Gopal', 54)
INSERT INTO @pvt_input VALUES('Rajasthan Royals', 'McClenaghan', 51)
INSERT INTO @pvt_input VALUES('Rajasthan Royals', 'Harbhajan', 65)
INSERT INTO @pvt_input VALUES('Gujrat Lions', 'Rohit Sharma', 74)
INSERT INTO @pvt_input VALUES('Gujrat Lions', 'Bumrah', 93)
INSERT INTO @pvt_input VALUES('Gujrat Lions', 'Gopal', 35)
INSERT INTO @pvt_input VALUES('Gujrat Lions', 'McClenaghan', 84)
INSERT INTO @pvt_input VALUES('Gujrat Lions', 'Harbhajan', 64)
INSERT INTO @pvt_input VALUES('Kings XI Panjab', 'Rohit Sharma', 34)
INSERT INTO @pvt_input VALUES('Kings XI Panjab', 'Bumrah', 52)
INSERT INTO @pvt_input VALUES('Kings XI Panjab', 'Gopal', 65)
INSERT INTO @pvt_input VALUES('Kings XI Panjab', 'McClenaghan', 45)
INSERT INTO @pvt_input VALUES('Kings XI Panjab', 'Harbhajan', 54)
INSERT INTO @pvt_input VALUES('Pune Sunrisers', 'Rohit Sharma', 95)
INSERT INTO @pvt_input VALUES('Pune Sunrisers', 'Bumrah', 91)
INSERT INTO @pvt_input VALUES('Pune Sunrisers', 'Gopal', 85)
INSERT INTO @pvt_input VALUES('Pune Sunrisers', 'McClenaghan', 95)
INSERT INTO @pvt_input VALUES('Pune Sunrisers', 'Harbhajan', 65)
 
SELECT * FROM @pvt_input;

-- PIVOT Example Converting Column values (Players) to Column Names
SELECT OppositionTeam,  [Rohit Sharma], [Bumrah], [Gopal], [McClenaghan], [Harbhajan]
FROM
(SELECT OppositionTeam, Player, Runs FROM @pvt_input) AS p
PIVOT
(
-- Here pivot expects an aggregate function like SUM, AVG, MIN, MAX
SUM (Runs)
-- These Column Values will become Column names for Pivot result
FOR Player IN ([Rohit Sharma], [Bumrah], [Gopal], [McClenaghan], [Harbhajan])
) AS pvt
ORDER BY pvt.OppositionTeam;

-- xxxxxx

DECLARE @unpivot_input TABLE
(
OppositionTeam VARCHAR(20),
[Rohit Sharma] INT, Bumrah INT,
Gopal INT,
McClenaghan INT,
Harbhajan INT
);
 
INSERT INTO @unpivot_input VALUES ('Delhi Daredevils', 70, 40, 70, 100, 40)
INSERT INTO @unpivot_input VALUES ('Gujrat Lions', 74, 93, 35, 84, 64)
INSERT INTO @unpivot_input VALUES ('Kings XI Panjab', 34, 52, 65, 45, 54)
INSERT INTO @unpivot_input VALUES ('Pune Sunrisers', 95, 91, 85, 95, 65)
INSERT INTO @unpivot_input VALUES ('Rajasthan Royals', 80, 50, 54, 51, 65)
 
SELECT * FROM @unpivot_input;

-- Create the table and insert values as portrayed in the previous example.  
CREATE TABLE pvt (VendorID int, Emp1 int, Emp2 int,  
    Emp3 int, Emp4 int, Emp5 int);  
GO  
INSERT INTO pvt VALUES (1,4,3,5,4,4);  
INSERT INTO pvt VALUES (2,4,1,5,5,5);  
INSERT INTO pvt VALUES (3,4,3,5,4,4);  
INSERT INTO pvt VALUES (4,4,2,5,5,4);  
INSERT INTO pvt VALUES (5,5,1,5,5,5);  
GO  
select * from pvt;
-- Unpivot the table.  
SELECT VendorID, Employee, Orders  
FROM   
   (SELECT VendorID, Emp1, Emp2, Emp3, Emp4, Emp5  
   FROM pvt) p  
UNPIVOT  
   (Orders FOR Employee IN   
      (Emp1, Emp2, Emp3, Emp4, Emp5)  
)AS unpvt;  
GO  
