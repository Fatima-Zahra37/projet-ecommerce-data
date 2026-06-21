-- KPI : Taux de retour — France / Women 2023-2024
-- Statuts : Complete + Returned

SELECT
    YEAR(CAST(item_created_at AS TIMESTAMP)) AS annee,
    ROUND(
        COUNT(CASE WHEN item_status = 'Returned' THEN 1 END) * 100.0 /
        COUNT(CASE WHEN item_status IN ('Complete', 'Returned') THEN 1 END),
    1) AS taux_retour_pct
FROM '../data/thelook_fr_women_2023_2024.csv'
WHERE item_status IN ('Complete', 'Returned')
AND   country     = 'France'
AND   department  = 'Women'
GROUP BY annee
ORDER BY annee;
