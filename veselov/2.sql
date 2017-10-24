SELECT Countries.name
    FROM Delegations
    JOIN Countries    ON Countries.id = Delegations.country_id
EXCEPT
SELECT Countries.name
    FROM Participations
    JOIN Athletes        ON Athletes.id = Participations.athlete_id
    JOIN Delegations     ON Delegations.id = Athletes.delegation_id
    JOIN Countries       ON Countries.id = Delegations.country_id
WHERE Participations.place = 1
ORDER BY name ASC;

