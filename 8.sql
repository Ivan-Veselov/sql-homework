SELECT percentile_cont(0.5) WITHIN GROUP (ORDER BY cnt)
FROM (SELECT volunteers.id, COUNT(*) as cnt
  FROM volunteers JOIN athletes ON volunteers.id = athletes.volunteer_id
  GROUP BY volunteers.id
  ORDER BY cnt) AS cur