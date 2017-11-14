-- usage: psql -d ... -f ... -v id=...
WITH athletes_number AS (
    SELECT COUNT(1)
        FROM volunteers_assignments
        JOIN volunteers              ON  volunteers.id = volunteers_assignments.volunteer_id
        JOIN athletes                ON  athletes.volunteer_id = volunteers.id
    WHERE volunteers_assignments.assignment_id = :id
)
SELECT vehicles.id
    FROM vehicles
WHERE vehicles.capacity >= (SELECT * FROM athletes_number)
EXCEPT
SELECT vehicles.id
    FROM vehicles
    JOIN assignments  ON  assignments.vehicle_id = vehicles.id
WHERE assignments.timestamp::date = (SELECT timestamp::date FROM assignments WHERE id = :id)

