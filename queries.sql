-- #1 +
SELECT DISTINCT C.name
FROM participations P
JOIN athletes A ON A.id = P.athlete_id
JOIN delegations D ON D.id = A.delegation_id
JOIN countries C ON C.id = D.country_id
WHERE place <= 3;

-- #2 +
WITH Leaders AS (
  SELECT
    C.name AS name,
    coalesce(MIN(place), 100000) AS min
  FROM participations P
    JOIN athletes A ON A.id = P.athlete_id
    JOIN delegations D ON D.id = A.delegation_id
    RIGHT JOIN countries C ON C.id = D.country_id
  GROUP BY C.id
)
SELECT name
FROM Leaders
WHERE min > 1;

-- #2 +
SELECT name
FROM countries
EXCEPT
SELECT DISTINCT C.name
FROM participations P
  JOIN athletes A ON A.id = P.athlete_id
  JOIN delegations D ON D.id = A.delegation_id
  JOIN countries C ON C.id = D.country_id
WHERE place = 1;

-- #3 +
WITH cummulated AS (
    SELECT
      buildings.street AS street,
      buildings.house_number AS house_number,
      buildings.name AS b_name,
      delegation_leaders.name AS dl_name,
      delegation_leaders.telephone_number AS telephone_number,
      countries.name AS c_name,
      buildings.id AS b_id,
      COUNT(*) OVER (PARTITION BY buildings.id) as count
    FROM delegations
      JOIN buildings ON delegations.headquarters_id = buildings.id
      JOIN countries ON delegations.country_id = countries.id
      JOIN delegation_leaders ON delegations.id = delegation_leaders.delegation_id
)
  SELECT
    street,
    house_number,
    b_name,
    dl_name,
    telephone_number,
    c_name
  FROM cummulated
WHERE count >= 2
ORDER BY b_id;



-- #4 +
SELECT C.name, COUNT(A.id)
FROM countries C
  LEFT JOIN delegations D ON D.country_id = C.id
  LEFT JOIN athletes A ON A.delegation_id = D.id
GROUP BY C.id;

-- #5 +
WITH Counts AS (
    SELECT
      S.name AS name,
      COUNT(*) AS cnt
    FROM athletes A
      JOIN athletes_specializations SP ON A.id = SP.athlete_id
      JOIN sports S ON SP.sport_id = S.id
    GROUP BY S.id
)
SELECT name, cnt
FROM (
  SELECT name, cnt, max(cnt) OVER () AS max, min(cnt) OVER () AS min
  FROM Counts

) as q
WHERE cnt = max OR cnt = min
ORDER BY cnt;


-- #6 assignment can have only one vehicle.
SELECT COUNT(*)
FROM volunteers_assignments VASS
  JOIN volunteers VO ON VASS.volunteer_id = VO.id
  JOIN athletes ATH ON VO.id = ATH.volunteer_id
  JOIN assignments ASS ON VASS.assignment_id = ASS.id
  JOIN vehicles VE ON ASS.vehicle_id = VE.id
GROUP BY ASS.id;


-- #7 +
WITH stat AS (
    SELECT
      competitions.id AS competition_id,
      buildings.id AS building_id,
      COUNT(*) AS count
    FROM competitions
      JOIN buildings ON competitions.site_id = buildings.id
      JOIN participations ON competitions.id = participations.competition_id
    GROUP BY competitions.id, buildings.id
), cummulatives AS (
    SELECT *,
      min(count) OVER (PARTITION BY building_id) AS min,
      max(count) OVER (PARTITION BY building_id) AS max
    FROM stat
)
SELECT
  buildings.name,
  buildings.street,
  buildings.house_number,
  sports.name,
  competitions.timestamp,
  count,
  (CASE WHEN (count = max) THEN 'max' ELSE 'min' END)::Text AS status
FROM cummulatives
  JOIN buildings ON building_id = buildings.id
  JOIN competitions ON competition_id = competitions.id
  JOIN sports ON competitions.sport_id = sports.id
WHERE count = max OR count = min;


-- #8 +
WITH summary AS (
    SELECT
      C.id,
      C.name,
      P.place,
      COUNT(*) AS cnt
    FROM participations P
      JOIN athletes A ON A.id = P.athlete_id
      JOIN delegations D ON D.id = A.delegation_id
      RIGHT JOIN countries C ON C.id = D.country_id
      WHERE place is null OR place <= 3
      GROUP BY C.id, place
      ORDER BY C.name, P.place

) SELECT
  name,
  MAX(CASE WHEN place = 1 THEN cnt ELSE 0 END) AS gold,
  MAX(CASE WHEN place = 2 THEN cnt ELSE 0 END) AS silver,
  MAX(CASE WHEN place = 3 THEN cnt ELSE 0 END) AS bronze
  FROM summary
  WHERE place IS NULL OR place <= 3
  GROUP BY name
  ORDER BY gold DESC, silver DESC, bronze DESC;


-- #9 +
WITH length AS (
  SELECT COUNT(*) FROM volunteers
), Counts AS (
  SELECT COUNT(*) AS cnt
  FROM athletes A
    JOIN volunteers V ON A.volunteer_id = V.id
  GROUP BY V.id
  ORDER BY cnt
), HZ AS (
    SELECT cnt
    FROM Counts
    OFFSET ((SELECT * FROM length) - 1) / 2
    LIMIT CASE WHEN ((SELECT * FROM length) % 2 = 0) THEN 2 ELSE 1 END
)
SELECT AVG(cnt) FROM HZ;


-- #10 +
WITH stat AS (
    SELECT
      country_id,
      sport_id,
      count(*) AS count
    FROM delegations
      JOIN athletes ON delegations.id = athletes.delegation_id
      JOIN athletes_specializations ON athletes.id = athletes_specializations.athlete_id
      JOIN sports ON athletes_specializations.sport_id = sports.id
    GROUP BY country_id, sport_id
), cummulatives AS (
    SELECT
      country_id,
      sport_id,
      count,
      sum(count) OVER (PARTITION BY country_id) as sum,
      max(count) OVER (PARTITION BY country_id) as max
    FROM stat
)
SELECT DISTINCT countries.name
FROM cummulatives
  JOIN countries ON cummulatives.country_id = countries.id
WHERE sum >= 2 AND count = max AND count * 2 >= sum
