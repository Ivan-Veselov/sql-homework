WITH building_counts AS (
    SELECT buildings.id AS building_id, competitions.id AS competition_id, COUNT(1) AS athletes_number
        FROM buildings
        JOIN competitions    ON  competitions.site_id = buildings.id
        JOIN participations  ON  participations.competition_id = competitions.id
    GROUP BY (competitions.id, buildings.id)
),
building_statistics AS (
    SELECT *, MAX(athletes_number) OVER (PARTITION BY building_id) AS max,
              MIN(athletes_number) OVER (PARTITION BY building_id) AS min
        FROM building_counts
)
SELECT buildings.name, buildings.street, buildings.house_number, sports.name,
       competitions.timestamp, athletes_number,
       (CASE WHEN (athletes_number = max) THEN 'maximum' ELSE 'minimum' END)::TEXT AS type
    FROM building_statistics
    JOIN buildings     ON  buildings.id = building_statistics.building_id
    JOIN competitions  ON  competitions.id = building_statistics.competition_id
    JOIN sports        ON  sports.id = competitions.sport_id
WHERE athletes_number = max OR athletes_number = min
ORDER BY buildings.name DESC, buildings.street DESC, buildings.house_number DESC, athletes_number DESC;

