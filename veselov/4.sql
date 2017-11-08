SELECT countries.name, COUNT(1) AS athletes_number
    FROM athletes
    JOIN delegations  ON delegations.id = athletes.delegation_id
    JOIN countries    ON countries.id = delegations.country_id
GROUP BY countries.id
ORDER BY athletes_number DESC, name ASC;

