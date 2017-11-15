SELECT countries.name, sum(case participations.place when 1 then 1 else 0 end) AS gold,
  sum(case participations.place when 2 then 1 else 0 end) AS silver,
  sum(case participations.place when 3 then 1 else 0 end) AS bronze
FROM athletes
  JOIN participations ON athletes.id = participations.athlete_id
  JOIN delegations ON athletes.delegation_id = delegations.id
  JOIN countries ON delegations.country_id = countries.id
WHERE participations.place < 4
GROUP BY countries.id
ORDER BY gold DESC, silver DESC, bronze DESC