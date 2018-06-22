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

