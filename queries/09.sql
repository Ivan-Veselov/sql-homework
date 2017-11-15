WITH statistics AS (
    SELECT volunteers.id, COUNT(*) AS athletes_number
        FROM volunteers
        JOIN athletes    ON  athletes.volunteer_id = volunteers.id
    GROUP BY volunteers.id
)
SELECT percentile_cont(0.5) WITHIN GROUP (ORDER BY athletes_number)
    FROM statistics

