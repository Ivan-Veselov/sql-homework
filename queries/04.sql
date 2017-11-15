SELECT countries.name, COUNT(1) AS athletes_number
    FROM countries
    LEFT JOIN delegations  ON  delegations.country_id = countries.id
    LEFT JOIN athletes     ON  athletes.delegation_id = delegations.id
GROUP BY countries.id;

