WITH athletes_for_volunteer AS (
    SELECT COUNT(1) AS athletes_number
        FROM volunteers
        JOIN athletes    ON  athletes.volunteer_id = volunteers.id
    GROUP BY volunteers.id
),
athletes_for_volunteer_indexed AS (
    SELECT athletes_number,
           ROW_NUMBER() OVER (ORDER BY athletes_number) AS row_id,
           (SELECT COUNT(1) FROM athletes_for_volunteer) AS volunteers_number
        FROM athletes_for_volunteer
)
SELECT avg(athletes_number)
    FROM athletes_for_volunteer_indexed
WHERE row_id BETWEEN volunteers_number / 2.0 AND volunteers_number / 2.0 + 1

