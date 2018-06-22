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

