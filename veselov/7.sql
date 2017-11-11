WITH building_counts AS (
    SELECT buildings.id AS building_id, competitions.id AS competition_id, COUNT(1) AS athletes_number
        FROM buildings
        JOIN competitions    ON competitions.site_id = buildings.id
        JOIN participations  ON participations.competition_id = competitions.id
    GROUP BY (competitions.id, buildings.id)
),
building_statistics AS (
    SELECT *, MAX(athletes_number) OVER (PARTITION BY building_id), MIN(athletes_number) OVER (PARTITION BY building_id)
        FROM building_counts
),
competitions_filtered AS (
    SELECT building_id, competition_id, athletes_number, 'maximum' AS type
        FROM building_statistics
        WHERE athletes_number = max
    UNION    
    SELECT building_id, competition_id, athletes_number, 'minimum' AS type
        FROM building_statistics
        WHERE athletes_number = min
)
SELECT buildings.name, buildings.street, buildings.house_number, sports.name, competitions.timestamp, athletes_number, type
    FROM competitions_filtered
    JOIN buildings     ON buildings.id = competitions_filtered.building_id
    JOIN competitions  ON competitions.id = competitions_filtered.competition_id
    JOIN sports        ON sports.id = competitions.sport_id
ORDER BY buildings.name DESC, buildings.street DESC, buildings.house_number DESC, athletes_number DESC;

