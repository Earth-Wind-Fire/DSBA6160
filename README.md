Develop a proof on concept database and user interface for the pet services industry to obtain Dr. Patel as a client.

Requirements:
1.  Create sample pet database similar to rover.com
2.  Generate a user interface for Dr. Patel to maintain and update records.

# Business Rules

1.  DBMS must block technicians that are not certified from administering medicine or bathe pets
2.  Must identify customers who are teachers
3.  Teachers will receive a 10% discount
4.  Must identify college students
5.  Company will start servicing dogs and cats only
6.  Pet type must be expandable
7.  Teachers cannot be students
8.  Students cannot be teachers
9.  Database must have the following tables
   a.  Pets
   b.  Services
   c.  Technicians
       i.  Members of group must be first technicians
   d.  Orders
   e.  Customers
   f.  Ratings
   g.  Teacher
   h.  Occupation
   i.  User
 10.  Must be able to view deleted records
 11.  DBMS Must have backup, recover, and security features

# User Interface was ommitted for the time being, but would be the next step given more time

# See 'petcare_eerd' file also included for entity relationship diagram

# See 'petcare_data_dictionary.xlsx' attached for data dictionary

# Triggers

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


# Views
USE petcare;

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

CREATE VIEW petcare.teachers_coach_v AS
	(
		SELECT concat(u.FirstName, ' ', u.LastName) Name
			, t.Position
			, t.SchoolName
			FROM petcare.user u
				INNER JOIN petcare.teacher t
					ON u.UserID = t.UserID
			WHERE u.UserID IN (SELECT UserID FROM petcare.teacher WHERE coach = 1)
	)
;



# Stored Procedures
USE petcare;

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



