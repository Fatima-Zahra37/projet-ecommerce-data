-- KPI : Taux de réachat — France / Women 2023-2024
-- Client fidèle = client avec au moins 2 commandes Complete la même année

WITH commandes_par_client AS (
    SELECT
        YEAR(CAST(item_created_at AS TIMESTAMP)) AS annee,
        user_id,
        COUNT(DISTINCT order_id) AS nb_commandes
    FROM '../data/thelook_fr_women_2023_2024.csv'
    WHERE item_status = 'Complete'
    GROUP BY annee, user_id
)
SELECT
    annee,
    ROUND(
        COUNT(CASE WHEN nb_commandes >= 2 THEN 1 END) * 100.0 /
        COUNT(*),
    1) AS taux_reachat_pct
FROM commandes_par_client
GROUP BY annee
ORDER BY annee;