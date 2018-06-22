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

