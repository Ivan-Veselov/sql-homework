WITH delegation_size AS (
    SELECT delegations.id, COUNT(1) AS athletes_number
        FROM delegations
        JOIN athletes     ON  athletes.delegation_id = delegations.id
    GROUP BY delegations.id
),
delegation_sport_pairs AS (
    SELECT delegations.id AS delegation_id, sports.id AS sport_id, COUNT(1) AS athletes
        FROM delegations
        JOIN athletes                  ON  athletes.delegation_id = delegations.id
        JOIN athletes_specializations  ON  athletes_specializations.athlete_id = athletes.id
        JOIN sports                    ON  sports.id = athletes_specializations.sport_id
    GROUP BY (delegations.id, sports.id)
),
delegation_statistics AS (
    SELECT delegation_id AS id, MAX(athletes) AS max_specialists_in_one_sport
        FROM delegation_sport_pairs
    GROUP BY delegation_id
)
SELECT countries.name, delegations.id
    FROM delegations
    JOIN delegation_size        ON  delegation_size.id = delegations.id
    JOIN delegation_statistics  ON  delegation_statistics.id = delegations.id
    JOIN countries              ON  countries.id = delegations.country_id
WHERE athletes_number >= 2 AND 2 * max_specialists_in_one_sport >= athletes_number

