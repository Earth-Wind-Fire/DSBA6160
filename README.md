Develop a proof on concept database and user interface for the pet services industry to obtain Dr. Patel as a client.

Requirements:
1.  Create sample pet database similar to rover.com
2.  Generate a user interface for Dr. Patel to maintain and update records.




DELIMITER |
DROP TRIGGER IF EXISTS upd_customer|
CREATE TRIGGER upd_customer
 AFTER INSERT ON petcare.user
    FOR EACH ROW
    BEGIN
  INSERT INTO petcare.customers VALUES (new.UserID, CURRENT_DATE());
 END|
    
DELIMITER ;




DELIMITER |
DROP TRIGGER IF EXISTS update_cred|
CREATE TRIGGER update_cred
 AFTER INSERT ON user
    FOR EACH ROW
    BEGIN
  INSERT INTO Credentials VALUES (new.UserID, new.Email, concat(new.LastName, new.UserID), 'guest');
    END|
    
DELIMITER ;







USE petcare;

# creates new users as they are inserted into database
DELIMITER |
CREATE PROCEDURE new_user
 (IN userid int(11), 
     IN lname varchar(45), 
     IN fname varchar(45), 
     IN addr varchar(45), 
     IN city varchar(45), 
     IN state varchar(45), 
     IN cnty varchar(45),
     IN zip varchar(5),
     IN email varchar(45),
     IN phnum varchar(45),
     IN stud tinyint,
     IN occup varchar(45),
     IN sch_pos varchar(45),
     IN sch_nm varchar(45),
     IN coach tinyint
 )
    BEGIN
    
  INSERT INTO user
   VALUES (userid, lname, fname, addr, city, state, cnty, zip, email, phnum, stud, occup)
  ;
        
        INSERT INTO teacher
   VALUES (userid, sch_pos, sch_nm, coach)
  ;
    
    
    END
|
DELIMITER ;




USE petcare;
# creates new orders when they are inserted
DELIMITER |
CREATE PROCEDURE create_order
 (IN ord_num int(11), 
     IN ord_date date, 
     IN tech_id int(11), 
     IN pet_id int(11), 
     IN svc_id int(11)
 )
    BEGIN
    
  INSERT INTO orders
   VALUES (ord_num, ord_date, tech_id, pet_id)
  ;
        
        INSERT INTO orderservices
   VALUES (ord_num, svc_id)
  ;
        
        
    
    END
|
DELIMITER ;







USE petcare;
# view of details associated with a particular order
CREATE VIEW petcare.order_detail_v AS
 (
  SELECT o.OrderID
   , o.OrderDate
            , s.Type
            , s.Cost
   FROM orders o
    INNER JOIN orderservices os
     ON o.OrderID = os.OrderID
    INNER JOIN service s
     ON os.ServiceID = s.ServiceID
 )
;

# finds all users who are also coaches
CREATE VIEW petcare.teachers_coach_v AS
 (
  SELECT concat(u.FirstName, ' ', u.LastName) Name
   , t.Position
   , t.SchoolName
            , u.email
   FROM petcare.user u
    INNER JOIN petcare.teacher t
     ON u.UserID = t.UserID
   WHERE u.UserID IN (SELECT UserID FROM petcare.teacher WHERE coach = 1)
 )
;
SELECT * FROM petcare.teachers_coach_v



