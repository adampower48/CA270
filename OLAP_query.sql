# Number of dungeons completed for Priests in Atal'dazar for affixes (fortified, bolstering, skittish, infested) on difficulty +16
SELECT 
    base_class AS Class,
    specialisation AS Spec,
    du.name AS Dungeon,
    SUM(num_completed) AS Completed
FROM
    fact_table f
        INNER JOIN
    affix a ON f.affix_id = a.id
        INNER JOIN
    class c ON f.class_id = c.id
        INNER JOIN
    dungeon du ON f.dungeon_id = du.id
        INNER JOIN
    difficulty di ON f.difficulty_id = di.level
WHERE
    base_class LIKE 'Priest'
        AND du.name LIKE 'Atal\'Dazar'
        AND a.id LIKE 'FO_BO_SK_IN'
        AND di.level = 16
GROUP BY base_class , specialisation WITH ROLLUP;

# Number of dungeons completed by Tanks for all dungeons for all Tyrannical affixes for difficulty >=15
SELECT 
    du.name AS Dungeon,
    base_class AS Class,
    SUM(num_completed) AS Completed
FROM
    fact_table f
        INNER JOIN
    affix a ON f.affix_id = a.id
        INNER JOIN
    class c ON f.class_id = c.id
        INNER JOIN
    dungeon du ON f.dungeon_id = du.id
        INNER JOIN
    difficulty di ON f.difficulty_id = di.level
WHERE
    c.category LIKE 'Tank'
        AND du.name LIKE 'Freehold'
        AND a.level_2 LIKE 'Tyrannical'
        AND di.level >= 15
GROUP BY du.name , base_class WITH ROLLUP;

