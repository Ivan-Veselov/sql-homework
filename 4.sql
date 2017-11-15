(SELECT sports.name AS name, count(athletes.id) AS cnt
FROM athletes
  JOIN participations ON athletes.id = participations.athlete_id
  JOIN competitions ON participations.competition_id = competitions.id
  JOIN sports ON competitions.sport_id = sports.id
GROUP BY sports.id
ORDER BY cnt DESC
LIMIT 1)
UNION
(SELECT sports.name AS name, count(athletes.id) AS cnt
FROM athletes
  JOIN participations ON athletes.id = participations.athlete_id
  JOIN competitions ON participations.competition_id = competitions.id
  JOIN sports ON competitions.sport_id = sports.id
GROUP BY sports.id
ORDER BY cnt
LIMIT 1)