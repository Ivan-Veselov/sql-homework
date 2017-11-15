SELECT countries.name, COUNT(athletes.id)
FROM countries
  JOIN delegations ON countries.id = delegations.country_id
  JOIN athletes ON delegations.id = athletes.delegation_id
GROUP BY countries.id