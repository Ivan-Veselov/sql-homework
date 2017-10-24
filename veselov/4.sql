SELECT Countries.name, COUNT(1) AS athletes_number
    FROM Athletes
    JOIN Delegations  ON Delegations.id = Athletes.delegation_id
    JOIN Countries    ON Countries.id = Delegations.country_id
GROUP BY Countries.id
ORDER BY athletes_number DESC, name ASC;

