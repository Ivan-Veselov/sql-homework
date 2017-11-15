SELECT countries.name
FROM countries
WHERE countries.name NOT IN(
  SELECT countries.name
  FROM athletes
    JOIN participations ON athletes.id = participations.athlete_id
    JOIN delegations ON athletes.delegation_id = delegations.id
    JOIN countries ON delegations.country_id = countries.id
  WHERE participations.place = 1
  GROUP BY countries.name);
