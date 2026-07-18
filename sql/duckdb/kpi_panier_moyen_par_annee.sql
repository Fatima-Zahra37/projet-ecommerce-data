-- KPI : Panier moyen — France / Women 2023-2024
-- Panier moyen = CA / nombre de commandes distinctes (Complete, sale_price > 0)

SELECT
    YEAR(CAST(item_created_at AS TIMESTAMP)) AS annee,
    ROUND(SUM(sale_price) / COUNT(DISTINCT order_id), 2) AS panier_moyen
FROM '../data/thelook_fr_women_2023_2024.csv'
WHERE item_status = 'Complete'
AND   sale_price > 0
GROUP BY annee
ORDER BY annee;