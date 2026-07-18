-- KPIs : CA, Marge, Panier moyen — France / Women 2023-2024
-- Statuts : Complete uniquement
-- Granularité : annuelle

SELECT
    YEAR(CAST(item_created_at AS TIMESTAMP)) AS annee,
    ROUND(SUM(sale_price), 2)                AS ca_total,
    ROUND(SUM(sale_price - cost), 2)         AS marge_brute,
    ROUND(SUM(sale_price) / COUNT(DISTINCT order_id), 2) AS panier_moyen,
    COUNT(*)                                 AS nb_lignes
FROM '../data/thelook_fr_women_2023_2024.csv'
WHERE item_status = 'Complete'
AND   country     = 'France'
AND   department  = 'Women'
GROUP BY annee
ORDER BY annee;
