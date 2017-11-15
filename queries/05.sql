WITH sport_counts AS (
    SELECT sports.id AS sport_id, COUNT(1) AS athletes_number
        FROM athletes
        JOIN athletes_specializations  ON  athletes_specializations.athlete_id = athletes.id
        JOIN sports                    ON  sports.id = athletes_specializations.sport_id
    GROUP BY sports.id
),
sport_statistics AS (
    SELECT *, MAX(athletes_number) OVER (), MIN(athletes_number) OVER ()
        FROM sport_counts
)
SELECT name, athletes_number
    FROM sports
    JOIN sport_statistics  ON  sport_statistics.sport_id = sports.id
WHERE athletes_number = max OR athletes_number = min
ORDER BY athletes_number DESC, name ASC;

