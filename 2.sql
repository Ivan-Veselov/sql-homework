SELECT buildings.street, buildings.house_number, buildings.name, delegation_leaders.name,
  delegation_leaders.telephone_number, countries.name, buildings.id
FROM (SELECT buildings.id, count(buildings.id) AS cnt
  FROM buildings
    JOIN delegations ON buildings.id = delegations.headquarters_id
  GROUP BY buildings.id
  HAVING COUNT(buildings.id) > 1) AS cur
  JOIN buildings ON cur.id = buildings.id
  JOIN delegations ON buildings.id = delegations.headquarters_id
  JOIN delegation_leaders ON delegations.id = delegation_leaders.delegation_id
  JOIN countries ON delegations.country_id = countries.id
ORDER BY buildings.street, buildings.house_number, buildings.name