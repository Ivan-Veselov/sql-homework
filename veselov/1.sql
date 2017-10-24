SELECT DISTINCT Countries.name
    FROM Participations
    JOIN Athletes        ON Athletes.id = Participations.athlete_id
    JOIN Delegations     ON Delegations.id = Athletes.delegation_id
    JOIN Countries       ON Countries.id = Delegations.country_id
WHERE Participations.place <= 3
ORDER BY name ASC;

