SELECT countries.name, COUNT(CASE WHEN participations.place = 1 THEN true END) AS gold,
                       COUNT(CASE WHEN participations.place = 2 THEN true END) AS silver,
                       COUNT(CASE WHEN participations.place = 3 THEN true END) AS bronze
    FROM countries
    LEFT JOIN delegations     ON  delegations.country_id = countries.id
    LEFT JOIN athletes        ON  athletes.delegation_id = delegations.id
    LEFT JOIN participations  ON  participations.athlete_id = athletes.id
GROUP BY countries.name
ORDER BY gold DESC, silver DESC, bronze DESC, name ASC

