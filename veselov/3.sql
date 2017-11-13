WITH building_statistics AS (
    SELECT buildings.id, COUNT(1) AS number_of_headquarters
        FROM buildings
        JOIN delegations ON delegations.headquarters_id = buildings.id
    GROUP BY buildings.id
)
SELECT buildings.street, buildings.house_number, buildings.name,
       delegation_leaders.name, delegation_leaders.telephone_number,
       countries.name AS country
    FROM delegations
    JOIN delegation_leaders   ON delegation_leaders.delegation_id = delegations.id
    JOIN countries            ON countries.id = delegations.country_id
    JOIN buildings            ON buildings.id = delegations.headquarters_id
    JOIN building_statistics  ON building_statistics.id = buildings.id
WHERE number_of_headquarters > 1
ORDER BY buildings.id

