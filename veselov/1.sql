SELECT DISTINCT countries.name
    FROM participations
    JOIN athletes        ON  athletes.id = participations.athlete_id
    JOIN delegations     ON  delegations.id = athletes.delegation_id
    JOIN countries       ON  countries.id = delegations.country_id
WHERE participations.place <= 3
ORDER BY name ASC;

